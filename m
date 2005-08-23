Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <032b01c5a7ae$fd98ba00$6c01a8c0@Vijayakumar>
References: <032b01c5a7ae$fd98ba00$6c01a8c0@Vijayakumar>
Content-Type: text/plain
Message-Id: <1124780679.23599.119.camel@pegasus>
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
Date: Tue, 23 Aug 2005 09:04:39 +0200

Hi Vijayakumar,

> My linux kernel version is 2.4.20-8
> Applied 2.4.18 mh patch

this kernel is quite old and the -mh patch for 2.4.18 can't be applied
to a 2.4.20 kernel. Why don't you switch to the latest 2.6 kernel?

>       My pand connection gets disconnected after about 4-5 hrs. I 
> established pand connection between 2 dongles and ran multiple telnet 
> sessions (each running ls -lR in an infinite loop) and an ftp 
> session(transfers files repeatedly between the machines in an infinite 
> loop).After some 4-5 hrs i found that the pand onnection no longer existed.

Run "hcidump -X -V" and see why the connection gets terminated.

> And I found "NET unregister event not supported" in my system log 
> messages....Below is my system log...

This is hotplug stuff and not Bluetooth related.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
