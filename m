Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438A3135.6080208@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Decoder Performance
References: <20051018062749.78971.qmail@web34106.mail.mud.yahoo.com>	 <4389D1EC.4070703@xmission.com> <1133116270.13629.3.camel@blade>	 <438A22EE.1020504@xmission.com> <1133128269.13629.24.camel@blade>
In-Reply-To: <1133128269.13629.24.camel@blade>
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
Date: Sun, 27 Nov 2005 15:20:37 -0700

Marcel

>>bunch of macro calls that are replaced at compile time by either
>>floating or fixed point math.
> 
> but this is totally ugly.

the macros are also how the inline arm assembly gets inserted, so there
are potentially a bunch of implementation for each macro, especially
since 32-bit fixed is still experimental:

 - floating
 - 64-bit fixed generic
 - arm 64-bit asm
 - 32-bit fixed generic
 - arm 32-bit asm

it's ugly, but what should it look like? it doesn't look much better by
removing floating from the list.

> This is no real point. If you need a decoder for regression testing,
> then simply make a copy of it.

sure.

> If the fixed point decoder is too slow, then this needs to be fixed.
> Having too decoders won't really help.

inline asm may help but the difference is probably in the noise level.

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
