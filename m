Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Modify scotest?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43A27DFD.9070007@thomson.net>
References: <1513322956@web.de> <1134675751.12505.21.camel@localhost>
	 <43A27DFD.9070007@thomson.net>
Content-Type: text/plain
Message-Id: <1134723051.30889.3.camel@localhost>
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
Date: Fri, 16 Dec 2005 09:50:51 +0100

Hi Arnaud,

> Using SCO for quality measurement is a good idea if your bluetouth 
> device supports trasnparent audio, and if you configure them to use this 
> mode. If not, you can still try a configuration like ulaw on air, ulaw 
> on HCI (no conversion in theory)

no it is not a good idea. The chip will insert bits/bytes/frames as it
thinks it needs to. The transparent audio is not guaranteed. Read the
posts from the CSR guys for any details. 

> In this case, write a tool like scotest that always send FF.FF.FF...FF 
> frames (or anything you want) (write the same amount of data that you 
> receive). Then juste count zeros bits to detect BER, and 00.00.00...00 
> frames for PER.

Get a CSR development kit and get their BCCMD specification and use
their internals to get the BER values.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
