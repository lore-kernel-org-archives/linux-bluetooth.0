Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC Decoder Performance
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <438A22EE.1020504@xmission.com>
References: <20051018062749.78971.qmail@web34106.mail.mud.yahoo.com>
	 <4389D1EC.4070703@xmission.com> <1133116270.13629.3.camel@blade>
	 <438A22EE.1020504@xmission.com>
Content-Type: text/plain
Message-Id: <1133128269.13629.24.camel@blade>
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
Date: Sun, 27 Nov 2005 22:51:09 +0100

Hi Brad,

> >>fwiw, we have a fixed-point decoder in the btsco cvs now. If you try it,
> >>let me know how it goes.
> > 
> > is there any need to keep the floating point decoder?
> 
> yeah, we should leave it in. The decoder and encoder are written as a
> bunch of macro calls that are replaced at compile time by either
> floating or fixed point math.

but this is totally ugly.

> also... floats runs a bit faster if you have an fpu and regression
> testing would be easier with a decoder/encoder that we can "trust."

This is no real point. If you need a decoder for regression testing,
then simply make a copy of it.

If the fixed point decoder is too slow, then this needs to be fixed.
Having too decoders won't really help.

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
