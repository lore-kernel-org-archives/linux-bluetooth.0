Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: George Fankhauser <gfa@sensaco.com>
Message-ID: <loom.20050109T210055-110@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Issues with multiple (concurrent) rfcomm connections
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 9 Jan 2005 20:24:51 +0000 (UTC)

Dear all

I just ran across an issue with setting up multiple rfcomm connections from a 
linux laptop with kernel 2.4.28-mh1 using an Anycom USB-120 dongle with Silicon 
Wave chipset.

I just tried to maintain 2 connections to 2 seperate commercial rs232 adapters 
(roalan wcs 232) using the socket API (test source attached). While connection 
setup is ok, and reconnects (e.g. after powerfail of peers) work too for a 
single device, running the same procedure in parallel leads to a behavor where 
no more sockets can be opened. It starts with a write failed to the socket (ok 
so far), but the following connection attempts lead to errors 16 (resource or 
device busy) and 11 (resource temp. unavailable) or 110 (timeout). From this 
state, the system does not recover and all bluez modules have to be reloaded ;-(

as an alternative I tried the same thing using seperate processes instead of 
threads or, using the rfcomm utility and cat for sending data. I always end up 
with the same errors.

I wonder whether this problem is known, or related to Silicon Wave. Could 
anyone try this with a CSR based system?

thanks and regards
George



-----------

compile with

	gcc -g -c -std=c99 prog.c
	gcc -lbluetooth -lpthread prog.o -o prog



#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

#include <errno.h>

#include <sys/time.h>
#include <sys/select.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

#define TESTSIZE 10

void do_rw(int s) {
	char x[TESTSIZE];
	char y[TESTSIZE];
	int err, count = 0;

	for (int i = 0; i < TESTSIZE; i++) { x[i] = (s + i) % 10 + '0'; }

	while(1) {
		fd_set fds;
		struct timeval t = {0,0};
		
		FD_ZERO(&fds);
		select(s, &fds, NULL, NULL, &t);
		
		if (FD_ISSET(s, &fds)) {
			err = read(s, y, TESTSIZE);
			if (err < 0) { printf("read: %d\n", err); perror(""); }
			else if (err == 0) {}
			else { printf("read %d bytes\n", err); }
		}		
		
		err = write(s, x, TESTSIZE);
		if (err < 0) {
			printf("cannot write to socket %d: %d (errno=%d)\n", s, err, errno);
			perror("");
			if (errno == 11) { sleep(1); continue; }
			break;
		} else if (err == 0) {
			printf("write returns 0\n");
		} else if (err != TESTSIZE) {
			printf("bytes written < bytes to write\n (%d < %d)\n", err, TESTSIZE);
		} else {
			if (!(count++ % 10)) { printf("%d ", s); fflush(NULL); }
		}
		//sleep(1);
	}
}

void do_connect(char* addrstring) {
	int s, err;
	struct sockaddr_rc addr;

	s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
	if (s < 0) {
		printf("socket failed\n");
		return;
	}
	printf("do_connect %s, sock no %d\n", addrstring, s);
		
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, BDADDR_ANY);
	addr.rc_channel = 0;
	err = bind(s, (struct sockaddr *)&addr, sizeof(addr));
	if (err < 0) {
		printf("bind failed: %d (errno=%d)\n", err, errno);
		perror("");
		close(s);
		return;
	}
	addr.rc_family = AF_BLUETOOTH;
	str2ba(addrstring, &addr.rc_bdaddr);
	addr.rc_channel = 1;
	err = connect(s, (struct sockaddr *)&addr, sizeof(addr));
	
	if (err == 0) {
		printf("connection established\n");
		do_rw(s);
	}
	else {
		printf("connect failed: %d (errno=%d)\n", err, errno);
		perror("");
	}
	close(s);
}

void* thread_main(void* addrstring)
{
	while(1) {
		do_connect((char*)addrstring);		
		sleep(1);
	}
}


int main(int argc, char **argv) {
	pthread_t       thread1;
	pthread_t       thread2;
		
	pthread_create(&thread1, NULL, thread_main, "00:02:78:02:84:CB"); // rs232 (2)
	pthread_create(&thread2, NULL, thread_main, "00:02:78:02:85:84");//WCS-232 (3)

	//single threads or sep. processes
	//thread_main("00:02:78:02:84:CB");
	//thread_main("00:02:78:02:85:84");
	
	while (1) sleep(1);

	printf("main exit...\n");
}






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
