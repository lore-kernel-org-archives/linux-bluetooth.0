Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0711230628w4814f601mb5b68d1b2721f346@mail.gmail.com>
Date: Fri, 23 Nov 2007 15:28:29 +0100
From: "Andrea Galbusera" <gizero@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm connection keep-alive problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,
I'm designing an application using rfcomm sockets (standard blocking)
to handle serial communication with four bluetooth devices at the same
time. A requirement is the ability to re-connect to those BT devices
if they go away and then come back again. Since the application is a
sort of communication daemon, I need to intercept any disconnection
and then start a "keep-trying" loop to get the device connected again.
I already have a working prototype, but I experience a problems. When
only one or two devices disconnect at the same time, everything runs
smoothly: I mean that they get connected again as soon as the get
available while I can keep communicating with the other two devices.
On the opposite, when all the four devices are disconnected, I takes
longer and longer to get any of them connected again... Then it get
better I the other gets connected in decreasing time.

I have coded this using a thread for each remote device (every thread
runs the same function with just a different BT address). When the
disconnection is detected, I have a loop calling connect() and waiting
a few seconds before retrying if it fails. This loop sometimes returns
"Operation now in progress", sometimes "Device or resource busy" and
sometimes "Host is down".

I don't know how levels lower than rfcomm work, but I suspect that
calling connect() on different BT adresses from different threads is
causing me some kind of "interfernce" which effect depends on the
number of thread involved. My concern is about the best strategy to
keep calling connect() in the four thread I mentioned, in order to
optimize the time of reconnection when remote devices get available
again.

Follow some code snippets to show the way I'm trying to solve this
(only functions involved in reconnection handling).

Can you suggest a correct strategy or point me to any already
available application that has to do with a similar "keep alive"
problem?

TIA, regards,
Andrea

--------------------------------------------------------------------------

/* setupRcClientSock(). This function attempts to connect to the
remote device and return a connected sockets if it succeeds */
static int setupRcClientSock(char* btaddr, uint8_t btchannel) {
	struct sockaddr_rc rcclient;
	int rcclientsock;
	char errorbuf[EBUFLEN] = "";
	int error_code;

	fprintf(stdout, "Trying connection to remote BT device %s...\n", btaddr);
	/* Create the RFCOMM socket */
	if ((rcclientsock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		error_code = errno;
		sprintf(errorbuf, "socket()");
		goto exit;
	}

	/* Construct the client sockaddr_rc structure */
	memset(&rcclient, 0, sizeof(rcclient));
	rcclient.rc_family = AF_BLUETOOTH;
	rcclient.rc_channel = (uint8_t)btchannel;
	str2ba(btaddr, &rcclient.rc_bdaddr);

	/* Connect to server */
	if (connect(rcclientsock, (struct sockaddr *)&rcclient,
sizeof(rcclient)) < 0) {
		error_code = errno;
		sprintf(errorbuf, "connect()");
		goto release;
	}
	
	fprintf(stdout, "connected to remote BT device %s\n", btaddr);
	return rcclientsock;

release:
	close(rcclientsock);
exit:
	fprintf(stderr, "setupRcClientSock: %s failed for arm %s. %s\n",
			errorbuf, btaddr, strerror(error_code));
	return -1;
}

/* reconnectRcClientSock(). This function blocks trying to connect to
the remote device and return a connected socket when it succeeds */
static int reconnectRcClientSock(char* btaddr, uint8_t btchannel) {
	int rcclientsock;

	while ((rcclientsock = setupRcClientSock(btaddr, btchannel)) < 0) {
		/* Keep trying to connect with a small delay */
		sleep(TO_RECONNECT);
	}
	return rcclientsock;
}

/* handleRcConnect(). This function is the thread handler triggered by
a disconnection. It calls reconnectRcClientSock() */
void* handleRcConnect(void *thread_data) {
	struct armdata *parmdata = (struct armdata *) thread_data;
	int rcclientsock;
	while (1) {
		pthread_mutex_lock(&thread_flags_mutex);
		while (!thread_flags[parmdata->armid].running) {
			pthread_cond_wait(&thread_flags_cv, &thread_flags_mutex);
		}
		printf("arm %d. handleRcConnect() running\n", parmdata->armid);
		pthread_mutex_unlock(&thread_flags_mutex);
		rcclientsock = reconnectRcClientSock(parmdata->btaddr, parmdata->btchannel);
		/* must return the new socket... check when unlocking the flag */
		pthread_mutex_lock(&thread_flags_mutex);
		thread_flags[parmdata->armid].running = 0;
		thread_flags[parmdata->armid].done = 1;
		thread_flags[parmdata->armid].newrcclientsock = rcclientsock;
		pthread_mutex_unlock(&thread_flags_mutex);
		printf("arm %d. handleRcConnect() done\n", parmdata->armid);
	}

	return NULL;
}

--------------------------------------------------------------------------

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
