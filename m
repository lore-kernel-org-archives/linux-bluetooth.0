Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4239711A.8070604@amplex.dk>
From: Stephan Henningsen <sth@amplex.dk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Error compiling bluez-utils for buildroot/ARM
References: <4239536C.5030202@amplex.dk> <1111058060.11792.63.camel@pegasus>
In-Reply-To: <1111058060.11792.63.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 17 Mar 2005 12:59:22 +0100

Hi,

Marcel Holtmann wrote:
> this looks like we have a problem with the generated code for the
> parser. Try to remove parser.[ch] and lexer.c. Maybe you need to add
> another library for the target platform to provide _IO_getc().

I am not sure what you mean, but I did the following with the same 
unsuccessful result:

 From buildroot/ I did:

sth@speedball:~/au/buildroot$ make bluez-utils-cleandir \
				bluez-utils-configure
<blahblah..successful>
sth@speedball:~/au/buildroot$ rm \
			build_arm/bluez-utils-2.15/*/parser.[ch] \
			build_arm/bluez-utils-2.15/*/lexer.c -fv
removed `build_arm/bluez-utils-2.15/hcid/parser.c'
removed `build_arm/bluez-utils-2.15/hcid/parser.h'
removed `build_arm/bluez-utils-2.15/rfcomm/parser.c'
removed `build_arm/bluez-utils-2.15/rfcomm/parser.h'
removed `build_arm/bluez-utils-2.15/hcid/lexer.c'
removed `build_arm/bluez-utils-2.15/rfcomm/lexer.c'
sth@speedball:~/au/buildroot$ make bluez-utils 

<blahblah>
/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-gcc 
-I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE  -Os -pipe 
-L/home/sth/au/buildroot/build_arm/root/usr/lib -o hcid  main.o 
security.o storage.o lib.o parser.o lexer.o kword.o glib-ectomy.o 
   -lbluetooth
lexer.o(.text+0x7e0): In function `yy_get_next_buffer':
: undefined reference to `_IO_getc'
collect2: ld returned 1 exit status
make[3]: *** [hcid] Error 1
make[3]: Leaving directory 
`/home/sth/au/buildroot/build_arm/bluez-utils-2.15/hcid'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory 
`/home/sth/au/buildroot/build_arm/bluez-utils-2.15'
make[1]: *** [all] Error 2
make[1]: Leaving directory 
`/home/sth/au/buildroot/build_arm/bluez-utils-2.15'
make: *** 
[/home/sth/au/buildroot/build_arm/bluez-utils-2.15/src/l2ping.o] Error 2
sth@speedball:~/au/buildroot$



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
