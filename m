Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Wed, 8 Oct 2008 18:57:34 +0000 (UTC)
Message-ID: <loom.20081008T184606-189@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Using multiple process on single SCO socket
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
I am currently simulating a duplex voice traffic on a single SCO link.
(two adapters connect with one single SCO user level socket).
On each side, after connected, I fork another process to perform the write
operations, and the parent process will perform the read operaions.
The pseudo code looks like the following

connect(sockfd);
if (!fork()) { /* child process */
  while (1) {
    if (write(sockfd) < 0) break;
  }
  close(sockfd);
  return 0;
}
/* parent process */
while(1) {
  if (read(sockfd) < 0) break;
}
close(sockfd);


But after one side close the connection, the other side of the PC has this oops.
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000058
Call Trace:
[memcpy_fromiovec+55/96] memcpy_fromiovec+0x37/0x60
[<f8bc6fa9>] sco_sock_sendmsg+0x119/0x160 [sco]
[sock_aio_write+285/304] sock_aio_write+0x11d/0x130
[getnstimeofday+54/208] getnstimeofday+0x36/0xd0
[do_sync_write+213/288] do_sync_write+0xd5/0x120
[hrtimer_try_to_cancel+60/144] hrtimer_try_to_cancel+0x3c/0x90
[autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
[hrtimer_wakeup+0/32] hrtimer_wakeup+0x0/0x20
[vfs_write+346/368] vfs_write+0x15a/0x170
[sys_write+65/112] sys_write+0x41/0x70

Is there any safe way to run two processes on a single SCO socket?
Originally I use the following way, but actually these two direction traffic
will block each other.

while(1) {
  if (write(sockfd) < 0) break;
  if (read(sockfd) < 0) break;
}
close(sockfd);


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
