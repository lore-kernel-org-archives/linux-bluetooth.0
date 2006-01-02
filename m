Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Andrew N. Balahonov" <sspp@cityline.ru>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hci.c:885: storage size of `iv' isn't known
In-Reply-To: <1136201460.22810.10.camel@localhost>
Message-ID: <Pine.LNX.4.63.0601022121160.23868@sundust>
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net>
 <Pine.LNX.4.63.0512312154150.23868@sundust> <1136201460.22810.10.camel@localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="717440693-877106178-1136226735=:23868"
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
Date: Mon, 2 Jan 2006 21:32:15 +0300 (MSK)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--717440693-877106178-1136226735=:23868
Content-Type: TEXT/PLAIN; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: quoted-printable


OS: Openwall GNU/*/Linux., http://www.openwall.com/Owl/

ls -l /lib/libc[.-]*
-rwxr-xr-x    1 root     root         3.9M  20  2003 /lib/libc-2.1.3.so
lrwxrwxrwx    1 root     root           13  23  2004 /lib/libc.so.6 -> li=
bc-2.1.3.so

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-unknown-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)

$ ld -v
GNU ld version 2.10.91 (with BFD 2.10.1.0.4)

$ glib-config --version
1.2.9

--=20
Yours sincerely, Andrew N. Balahonov
1024D/3C340684 94B4 C3C5 8936 9DF5 A2B8  3E5C DB3A CC66 3C34 0684

On Mon, 2 Jan 2006, Marcel Holtmann wrote:

> Hi Andrew,
>
>> Please suggest anything.
>>
>> ~/bluez/bluez-libs-2.24$ make -s
>> Making all in include
>> Making all in src
>> mkdir .libs
>>   gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2
>> -D_FORTIFY_SOURCE=3D2 -c bluetooth.c -Wp,-MD,.deps/bluetooth.TPlo  -fP=
IC
>> -DPIC -o .libs/bluetooth.o
>>   gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2
>> -D_FORTIFY_SOURCE=3D2 -c bluetooth.c -Wp,-MD,.deps/bluetooth.TPlo -o
>> bluetooth.o >/dev/null 2>&1
>>   gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2
>> -D_FORTIFY_SOURCE=3D2 -c hci.c -Wp,-MD,.deps/hci.TPlo  -fPIC -DPIC -o
>> .libs/hci.o
>> hci.c: In function `hci_send_cmd':
>> hci.c:885: storage size of `iv' isn't known
>> hci.c:903: warning: implicit declaration of function `writev'
>> hci.c:885: warning: unused variable `iv'
>> make[2]: *** [hci.lo] =EF=DB=C9=C2=CB=C1 1
>> make[1]: *** [all-recursive] =EF=DB=C9=C2=CB=C1 1
>> make: *** [all] =EF=DB=C9=C2=CB=C1 2
>
> this is strange. What kind of system is this? What kind of compiler do
> you use?
>
> Regards
>
> Marcel

--717440693-877106178-1136226735=:23868--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
