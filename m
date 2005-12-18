Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] compile problem with bluez-utils-2.23 (uint16_t,
	.. missing)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <m3mziyxlv7.fsf@gondor.middle-earth.priv>
References: <m3mziyxlv7.fsf@gondor.middle-earth.priv>
Content-Type: text/plain
Message-Id: <1134933248.6881.32.camel@localhost>
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
Date: Sun, 18 Dec 2005 20:14:08 +0100

Hi Christian,

> I've tried to compile bluez-utils 2.23 and it failed with an error:
> 
> if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/include  -I/usr/include -O2 -fomit-frame-pointer -pipe -march=i586 -mtune=athlon -D_FORTIFY_SOURCE=2 -MT csr_usb.o -MD -MP -MF ".deps/csr_usb.Tpo" -c -o csr_usb.o csr_usb.c; \
> then mv -f ".deps/csr_usb.Tpo" ".deps/csr_usb.Po"; else rm -f ".deps/csr_usb.Tpo"; exit 1; fi
> In file included from csr_usb.c:34:
> csr.h:500: error: syntax error before "def"
> csr.h:501: error: syntax error before "id"
> csr.h:502: error: syntax error before "ver"
> csr.h:503: error: syntax error before "pskey"
> csr.h:504: error: syntax error before "pskey"
> csr.h:507: error: syntax error before "varid"
> csr.h:508: error: syntax error before "varid"
> csr.h:512: error: syntax error before "varid"
> csr.h:513: error: syntax error before "varid"
> csr.h:517: error: syntax error before "varid"
> csr.h:518: error: syntax error before "varid"
> 
> It seems, that uint16_t, uint32_t, ... are not found.

what compiler do you use? I never had that problem.

> I've solved the problem by including inttypes.h in csr.h:

I prefer using <stdint.h>. Does this also work for you?

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
