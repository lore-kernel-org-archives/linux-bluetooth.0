Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0709280211o1e447c88mfcad13e26f1c8343@mail.gmail.com>
Date: Fri, 28 Sep 2007 11:11:53 +0200
From: "Andrea Galbusera" <gizero@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1190964593.6484.83.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <f8e53fb0709280019i51e9175bl5a3fa8fa8965c75d@mail.gmail.com>
	<1190964593.6484.83.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Detecting disconnection when using RFCOMM tty API
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

Hi Marcel, thanks for your answers.

> if you poll the TTY you should get a HUP signal. Keeping the same file
> descriptor is not possible since on disconnect the TTY will be close. It
> won't re-connect automatically. So you have to open it again to trigger
> the actual re-connection.

I'm trying to catch the HUP but with no luck. I'm probably doing
something wrong. Basically I do the following:

void hangup_handler (int signal_number) {
	/* terminate the process on link lost */
	printf("Hello from my SIGHUP handler\n");
	exit(2);
}

int main(void) {
        struct sigaction sa;

	/* Install the signal handler for disconnections */
	memset(&sa, 0, sizeof(sa));
	sa.sa_handler = &hangup_handler;
	sigaction(SIGHUP, &sa, NULL);

        poll_device();
}

The apllication process correctly catches and handle the signal if I
issue it by "kill -SIGHUP <pid>", but nothing happens if I switch off
my remote device causing the link loss.

> The socket API is much more flexible. Use that one.

I'm unexperienced in sockets programming. Can you suggest me a good
documentation on using sockets with bluez rfcomm?

Regards,
Andrea

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
