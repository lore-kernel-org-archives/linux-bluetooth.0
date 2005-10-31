Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Transfer speed of a billionton class 1 USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051031011023.65559.qmail@web30302.mail.mud.yahoo.com>
References: <20051031011023.65559.qmail@web30302.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1130749921.17124.5.camel@blade>
Mime-Version: 1.0
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
Date: Mon, 31 Oct 2005 10:12:01 +0100

Hi Roland,

> I am using BlueZ with a billionton class 1 USB dongle.
> I found its upload speed (to a Nokia 6600) is slow
> (around 5-10K/s), and its download speed is pretty
> fast (around 30K/s). I google the web and found that
> bluetooth has two transmission mode: asymmetric and
> symmetric. I think my dongle is in asymmetric mode and
> I wonder how to switch it to symmetric mode, as I need
> fast upload speed.

if the link manager chooses the wrong packet types then this can happen.
Please run "hcitool info ..." and see what chip is in that phone. I bet
it is an old Nokia chip and then this can happen. However you might
wanna play with HCI_MAX_BULK_TX and HCI_MAX_BULK_RX constants inside the
hci_usb.h source code. I don't know if that helps, but it is worth a
try.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
