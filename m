Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] EVT_CONN_COMPLETE not received on HCI socket
	when RFComm connected
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42E8F1F8.10700@palmsource.com>
References: <42E8F1F8.10700@palmsource.com>
Content-Type: text/plain
Message-Id: <1122592426.5814.1.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Jul 2005 01:13:46 +0200

Hi Fred,

> I am writing a daemon that watches over bluetooth states (up, down, 
> connected, disconnected, ...) to display this information to user.
> I use HCI_FILTER (set to all events) to do this, but when a program make 
> a connection using RFComm I do not receive the EVT_CONN_COMPLETE event 
> (I use BlueZ 2.17 libs and utils).
> Is it normal ? Is there a way to watch for connection/disconnection for 
> all protocols ?

you can only watch ACL and SCO connect complete events with it. With the
new bluetoothd and the new event mechanism from the kernel we can add
something like this. In general it is not possible to what RFCOMM events
for connection and disconnection.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
