Return-Path: <cyrus@holtmann.org>
From: =?koi8-r?Q?=F7=CC=C1=C4=C9=D3=CC=C1=D7?= <vladisslav@inbox.ru>
To: linux-bluetooth@vger.kernel.org
Subject: =?koi8-r?Q?[PATCH]_Bluetooth=3A_rfcomm=3A_Release_BTM_while_sleeping_to_avoid_deadlock.?=
Mime-Version: 1.0
Date: Sun, 13 Feb 2011 04:01:45 +0300
Reply-To: =?koi8-r?Q?=F7=CC=C1=C4=C9=D3=CC=C1=D7?= <vladisslav@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1PoQLR-0008E5-00.vladisslav-inbox-ru@f68.mail.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bug description:
Kernel freezes for ~2 seconds after trying to access /dev/rfcommX device.
Steps to reproduce:
1. Edit /etc/bluetooth/rfcomm.conf - uncomment default config, set "bind" to "yes".
2. Issue "sudo rfcomm bind all" to create /dev/rfcomm0 device node.
3. Issue "cat /dev/rfcomm0" to trigger a bug.
Everything freezes (at least GUI): cursor does not move, no response from
keypresses, no gui redraw for 2~3 seconds.
Then cat displays expected error message "cat: /dev/rfcomm0: Host is down"
and system starts to respond again.
What expected (and occurs with 2.6.35) : no freeze between cat and error message.
Things goes worse when device, mentioned in /etc/bluetooth/rfcomm.conf
is in range and not paired - system displays pairing request and locks
up for a longer time, maybe completely - I did not wait longer than ~30
seconds and turned off bluetooth device.

Fix:
Release BTM while sleeping to avoid deadlock.

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 2575c2d..d7b9af4 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -727,7 +727,9 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 			break;
 		}
 
+		tty_unlock();
 		schedule();
+		tty_lock();
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->wait, &wait);




