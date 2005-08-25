Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Send packets using scotest  over bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <30238633.1124977021953.JavaMail.Administrator@appsrv>
References: <30238633.1124977021953.JavaMail.Administrator@appsrv>
Content-Type: text/plain
Message-Id: <1124996789.8019.65.camel@pegasus>
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
Date: Thu, 25 Aug 2005 21:06:29 +0200

Hi Ivy,

don't do cross-posting.

>        I have two bluetooth tongles with Linux machines. I am trying to send voice over bluetooth.  For test purpose, i m using scotest program. SCO test program generates some packets with 0x7F (except First 6 Bytes). scotest program connect with another PC,authunicated successfully and starts sending data . between  i ma running hcidump -XR in the sending machine. But i am not seeing any data like going out ... But another system receiving completly 0xFF ..  MY dongle info. 

the SCO data send on one side must not be the same as received on the
other side. There is a CVSD codec in between.

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
