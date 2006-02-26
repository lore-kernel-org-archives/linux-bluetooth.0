Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f30e2610602261444m477c13b6m3667c3031e5cb298@mail.gmail.com>
From: "Jeff Wilson" <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] decoding RFCOMM on hcidump -X -V
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
Date: Sun, 26 Feb 2006 16:44:09 -0600

Hi Marcel, hi list,

Does Bluetooth's RFCOMM protocol have ACKs and a sliding window, like
TCP?  Is it possible for a sending application to block on send when
sending a large payload to a slow reading application?

I'm trying to debug a program I wrote using
socket(PF_BLUETOOTH,SOCK_STREAM,BTPROTO_RFCOMM). Where can I learn
more about decoding the output of `hcidump -X -V` especially as it
applies to traffic crossing this RFCOMM socket?  I am particularly
interested in what to look for when chasing flow control and TCP-like
reliability.

Thanks for your time,

       Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
