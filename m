Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Aaron Klish <aklish1@urbana.css.mot.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.GSO.4.20.0310141004130.13019-100000@wombat.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] RFCOMM TTY data loss
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 14 Oct 2003 16:51:00 -0500 (CDT)

There seems to be a problem between the Rfcomm tty driver code 
and the generic n_tty line discipline where data can be lost.  
This data loss is with respect to data coming from rfcomm and being
sent to the n_tty line discipline.

In the function, n_tty_receive_buf, there is the following code:

if (n_tty_receive_room(tty) < TTY_THRESHOLD_THROTTLE) {
                /* check TTY_THROTTLED first so it indicates our state */
                if (!test_and_set_bit(TTY_THROTTLED, &tty->flags) &&
                    tty->driver.throttle)
                        tty->driver.throttle(tty);
        }

Basically, if the line discipline receive buffer gets close to
full (crosses the TTY_THRESHOLD_THROTTLE), it indicates to the
tty driver to throttle.

The rfcomm tty driver throttle function stops the flow of credits
to the remote device.  However, the remote device may still have
many outstanding credits remaining.  The remote device can continue
to send data as long as it has outstanding credit.  Specifically, it can
send MTU * "outstanding credit" bytes.  All of these bytes will
be passed to the line discipline regardless of the space remaining in its
receive buffer.  If the MTU * "outstanding credit" 
is greater than the space left in the line
discipline's receive buffer, the line discipline will discard that
data once the receive buffer is completely full.

You can induce data loss on BlueZ by writing a local application that opens
a rfcomm tty but does not read from it for a few seconds during which the
remote peer is sending data. 

During the pause where the application does not read, the line discipline
buffer fills, it throttles the rfcomm tty driver, but the rfcomm tty
driver keeps on sending data to the line discipline until the remote peer uses up all 
its outstanding credits.

We ran a similar experiment with the Affix stack but did not run into
this problem.

The rfcomm credit based flow control should prevent this kind of data loss.

Aaron

------------
Aaron Klish
Bluetooth Software Engineer
Motorola PCS
PH# (217) 384-8598
FX# (217) 384-8550

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
