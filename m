Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d6db2b820601281404q11cb9ba0k21116724a9047d7f@mail.gmail.com>
From: michael grosman <michaelg100@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9139_11108388.1138485888504"
Subject: [Bluez-users] Compiling bluez-utils for MIPS
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 29 Jan 2006 00:04:48 +0200

------=_Part_9139_11108388.1138485888504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all!
I'm trying to compile bluez-utils-2.24 project for Linux 2.4.20 that runs o=
n
MIPS. This cross-compilation was done on my desktop Linux 2.6.12. All neede=
d
drivers (HCI, RFCOMM, L2CAP) were uploaded to the > MIPS-board early (after
some patches for kernel 2.4.20 that I found in internet). I configured the
environment with the following variables:
export PLATFORM=3Dmipsel-uclibc
export BUILD=3Di386-pc-linux-gnu
export HOSTCC=3Dgcc
export CROSS_COMPILE=3Dmipsel-uclibc-
export LDFLAGS=3D-Wl,-dynamic-linker,/lib/ld-uClibc.so.0,-soname=3Dlibc.so.=
0
and runned ./configure mipsel-linux --build=3D$BUILD.
Making the project was OK, it used "mipsel-linux-gcc", etc., so it seemed
OK. After uploading all the bluez utilities on the MIPS-board, each call
for these utilities (i.e. "hciconfig") failed with such a prompt:
libc.so.6: aborted attempt to load hciconfig!
To my understanding, it still used my desktop standard library (cause  "
libc.so.6" is a symbolic link in /usr/local/lib on my PC) instead the
libc.so.0 on the MIPS-board.
I tryied adding LDFLAG "-soname=3Dlibc.so.0", but it did not force defining
the right library in building executables.

Could someone help me in configuring this project? What did I miss?

Thanks in advance,

MichaelG

------=_Part_9139_11108388.1138485888504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<p>Hi all!</p>
<div>I'm trying to compile bluez-utils-2.24 project for Linux 2.4.20 that r=
uns on MIPS. This cross-compilation was done on my desktop Linux&nbsp;2.6.1=
2. All needed drivers (HCI, RFCOMM, L2CAP) were uploaded to the &gt; MIPS-b=
oard early (after some patches for kernel=20
2.4.20 that I found in&nbsp;internet). I configured the environment with th=
e following variables: </div>
<div>export PLATFORM=3Dmipsel-uclibc&nbsp;</div>
<div>export BUILD=3Di386-pc-linux-gnu </div>
<div>export HOSTCC=3Dgcc </div>
<div>export CROSS_COMPILE=3Dmipsel-uclibc- </div>
<div>export&nbsp;LDFLAGS=3D-Wl,-dynamic-linker,/lib/ld-uClibc.so.0,-soname=
=3Dlibc.so.0&nbsp;</div>
<div>and runned ./configure mipsel-linux --build=3D$BUILD.&nbsp; </div>
<div>Making the project was OK, it used &quot;mipsel-linux-gcc&quot;, etc.,=
 so it&nbsp;seemed OK. After uploading all the bluez utilities on the MIPS-=
board, each call&nbsp; for these utilities (i.e. &quot;hciconfig&quot;) fai=
led with such a prompt:&nbsp;
</div>
<div>libc.so.6: aborted attempt to load hciconfig!</div>
<div>To my&nbsp;understanding, it still used my desktop standard library (c=
ause&nbsp;&nbsp;&quot;libc.so.6&quot; is a symbolic link in /usr/local/lib =
on my PC) instead the&nbsp;libc.so.0 on the MIPS-board.&nbsp;</div>
<div>I tryied&nbsp;adding LDFLAG &quot;-soname=3Dlibc.so.0&quot;,&nbsp;but =
it did not&nbsp;force&nbsp;defining the&nbsp;right library in building exec=
utables.</div>
<p>Could someone help me in configuring this project? What did I miss?</p>
<p>Thanks in advance, </p>
<p>MichaelG</p>

------=_Part_9139_11108388.1138485888504--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
