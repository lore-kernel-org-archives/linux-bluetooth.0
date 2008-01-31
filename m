Return-Path: <cyrus@holtmann.org>
Message-ID: <47A25328.6000008@in.tum.de>
Date: Fri, 01 Feb 2008 00:00:56 +0100
From: Aleksandar Kanchev <kanchev@in.tum.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------080708030005060009050601"
Subject: [Bluez-devel] kernel bug?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080708030005060009050601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello list,

recently I've stumbled upon something that I think might be a bluez bug.
My nokia phone was messed up, so it dropped rfcomm connections 
immediately after they were established. This caused my glibmm (glib2) 
based program to exit because of a glib error. After researching a bit I 
found out, that I was flushing a glib io channel after the channel was 
polled for IO_OUT, which is right. The flush caused a write() to the 
socket and glib expects write() to return either a negative number (an 
error) or positive > 0, a return = 0 is not expected probably because 
one should first wait for the IO_OUT event.
What was happening is that the connection was being dropped right after 
the socket was polled and this caused glib to crash most of the time. 
Should't bluez close the socket and return < 0 instead of returning 0?
I've attached a small program to better demonstrate what happened. I've 
also attached a copy of the email which I sent to the gtkmm mailing 
list, since I first thought it was a glib issue.

Thanks


--------------080708030005060009050601
Content-Type: text/x-csrc;
 name="bluez-bug.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-bug.c"

/*
 * write() should not return 0 after
 * the remote device has terminated the connetion.
 * This makes glib's io_channel terminate
 * the running program.
 *                kanchev@in.tum.de
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <poll.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>


int main(int argc, char **argv)
{
	char dummy;
	int sock, r;
	struct sockaddr_rc saddr;
	struct pollfd pollfd;

	if (argc != 3) {
		fprintf(stderr, "Usage: %s <bluetooth address> <rfcomm channel>\n", argv[0]);
		return -1;
	}

	if ((sock = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		perror("socket()");
		return -1;
	}

	memset(&saddr, 0, sizeof(struct sockaddr_rc));
	str2ba(argv[1], &saddr.rc_bdaddr);
	saddr.rc_family = AF_BLUETOOTH;
    saddr.rc_channel = (uint8_t) atoi(argv[2]);

	printf("Connecting to %s ...\n", argv[1]);
	if (connect(sock, (struct sockaddr *) &saddr, sizeof(struct sockaddr_rc)) < 0) {
		close(sock);
		perror("connect()");
		return -1;
	}

	pollfd.fd = sock;
	pollfd.events = POLLOUT;
	pollfd.revents = 0;
	if (poll(&pollfd, 1, -1) <= 0) {
		close(sock);
		perror("poll()");
		return -1;
	}

	printf("Turn off the bluetooth device %s now!\nPress enter to continue...", argv[1]);
	fflush(stdout);
	read(0, &dummy, 1);

	r = write(sock, "Hello", 5);
	printf("write() returned %d\n", r);

	close(sock);

	return 0;
}


--------------080708030005060009050601
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Message-ID: <47A1B761.6080306@in.tum.de>
Date: Thu, 31 Jan 2008 12:56:17 +0100
From: Aleksandar Kanchev <kanchev@in.tum.de>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To: gtkmm-list@gnome.org
Subject: is this a glibmm/glib bug?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello list,

I'm developing a bluetooth C++ library based on glibmm. I've stumbled 
upon a problem which concerns Glib::IOChannel(s). The problem occurs in 
the following scenario:
    1) open an RFCOMM socket to a remote bluetooth device and 
Glib::IOChannel::create_from_fd()
    2) connect the socket's file descriptor to Glib::SignalIO and wait 
for Glib:IO_OUT
    3) when Glib::IO_OUT is set, then write some bytes to the 
Glib::IOChannel
    4) shut down the bluetooth device in order to terminate the 
bluetooth connection, this also terminates the file descriptor
    5) flush the Glib::IOChannel, this causes:
GLib-ERROR **: file giochannel.c: line 951 (g_io_channel_flush): 
assertion failed: (this_time > 0)
aborting...

Program received signal SIGABRT, Aborted.
0x00110402 in __kernel_vsyscall ()
(gdb) bt
#0  0x00110402 in __kernel_vsyscall ()
#1  0x00b15690 in raise () from /lib/libc.so.6
#2  0x00b16f91 in abort () from /lib/libc.so.6
#3  0x00d0df7a in g_logv () from /lib/libglib-2.0.so.0
#4  0x00d0dfb9 in g_log () from /lib/libglib-2.0.so.0
#5  0x00d0e036 in g_assert_warning () from /lib/libglib-2.0.so.0
#6  0x00cfa7a1 in g_io_channel_flush () from /lib/libglib-2.0.so.0
#7  0x007f274e in Glib::IOChannel::flush () from /usr/lib/libglibmm-2.4.so.1

I came across this because my nokia phone was disconnecting immediately 
after a connection was established. I was able to reproduce the error by 
sleeping right after a Glib::IOChannel::write and shutting down the 
bluetooth connection from my phone while the program was sleeping, then 
flushing the Glib::IOChannel. If I ::close() (the syscall) the fd, 
instead of shutting down the phone, then I get:
(process:19643): GLib-WARNING **: Invalid file descriptor.
which is ok.

What does the GLib-Error mean? Is it a glib, glibmm or bluez problem?

I was using:
gtkmm24-2.12.3-1.fc8
glibmm24-2.14.2-1.fc8
glib2-2.14.4-1.fc8
bluez-libs-3.20-1.fc8
Linux 2.6.23.14-107.fc8 #1 SMP Mon Jan 14 21:37:30 EST 2008 i686 i686 
i386 GNU/Linux
on Fedora 8

best regards,
Aleksandar


--------------080708030005060009050601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------080708030005060009050601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080708030005060009050601--
