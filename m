Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Error compiling bluez-utils for buildroot/ARM
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4239536C.5030202@amplex.dk>
References: <4239536C.5030202@amplex.dk>
Content-Type: text/plain
Message-Id: <1111058060.11792.63.camel@pegasus>
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
Date: Thu, 17 Mar 2005 12:14:20 +0100

Hi Stephan,

> If I add  --libdir=${TARGET_DIR}/usr/lib  (which expands to 
> --libdir=/home/sth/au/buildroot/build_arm/root/usr/lib) to the 
> configure command, the configuring succeeds, but compilation fails:
> 
> ...
> 
> /home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-gcc 
> -I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE  -Os -pipe    -o hcid 
> main.o security.o storage.o lib.o parser.o lexer.o kword.o 
> glib-ectomy.o     -L/home/sth/au/buildroot/build_arm/root/usr/lib 
> -lbluetooth
> lexer.o(.text+0x7e0): In function `yy_get_next_buffer':
> : undefined reference to `_IO_getc'
> collect2: ld returned 1 exit status

this looks like we have a problem with the generated code for the
parser. Try to remove parser.[ch] and lexer.c. Maybe you need to add
another library for the target platform to provide _IO_getc().

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
