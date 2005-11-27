Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438A22EE.1020504@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Decoder Performance
References: <20051018062749.78971.qmail@web34106.mail.mud.yahoo.com>	 <4389D1EC.4070703@xmission.com> <1133116270.13629.3.camel@blade>
In-Reply-To: <1133116270.13629.3.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sun, 27 Nov 2005 14:19:42 -0700

Marcel

>>fwiw, we have a fixed-point decoder in the btsco cvs now. If you try it,
>>let me know how it goes.
> 
> is there any need to keep the floating point decoder?

yeah, we should leave it in. The decoder and encoder are written as a
bunch of macro calls that are replaced at compile time by either
floating or fixed point math.

also... floats runs a bit faster if you have an fpu and regression
testing would be easier with a decoder/encoder that we can "trust."

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
