Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73EB9.C3D5D6D8"
Date: Tue, 23 Jan 2007 07:39:53 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EC5@eumonex01.palmsource.com>
References: <45B4093B.4000901@appstate.edu> <45B4966D.2090207@palmsource.com>
	<45B4BC05.1010203@appstate.edu>
	<45B4BEC7.6010203@palmsource.com> <45B57230.70407@appstate.edu>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : Still trying to install bluetooth headset on
	Mandriva 2007 for Skype
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73EB9.C3D5D6D8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Retry from configure step using the following :
configure --prefix=3D/usr --enable-debug=3Dyes

Fr=E9d=E9ric




-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Kinney =
Baughman
Date: mar. 23/01/2007 03:25
=C0: BlueZ development
Objet : Re: [Bluez-devel] Still trying to install bluetooth headset on =
Mandriva 2007 for Skype
=20
Fr=E9d=E9ric DALLEAU wrote:
> Run the commands in the main plugz folder where the bootstrap and=20
> configure script are located.
> Or you could erase your current plugz directory and then redo the =
whole=20
> install procedure.

OK.  I'm finally back home and have started over with cvs checkout for=20
plugz.

> Kinney Baughman a =E9crit :
>> Fr=E9d=E9ric DALLEAU wrote:
>>  =20
>>> Hi,
>>>    =20
>>>> A2DPD[596.961]: a2dpd_signal_init: OK
>>>> Segmentation fault
>>>>  =20
>>>>      =20
>>> Strange,
>>> could you run it through gdb?
>>> I updated the cvs :
>>> you need to
>>> cvs update
>>> configure --enable-debug=3Dyes
>>> make
>>> make install

At this step, I run into problems.  Here are the last few lines of=20
output starting with where things start going wrong:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

test -z "/usr/local/lib/alsa-lib" || mkdir -p --  =
/usr/local/lib/alsa-lib"
  /bin/sh ../../libtool --mode=3Dinstall /usr/bin/install -c=20
'libasound_module_pcm_a2dpd.la'=20
'/usr/local/lib/alsa-lib/libasound_module_pcm_a2dpd.la'
libtool: install: error: cannot install `libasound_module_pcm_a2dpd.la'=20
to a directory not ending in /usr/lib/alsa-lib
  /bin/sh ../../libtool --mode=3Dinstall /usr/bin/install -c=20
'libasound_module_ctl_a2dpd.la'=20
'/usr/local/lib/alsa-lib/libasound_module_ctl_a2dpd.la'
libtool: install: error: cannot install `libasound_module_ctl_a2dpd.la'=20
to a directory not ending in /usr/lib/alsa-lib
make[3]: *** [install-alsaLTLIBRARIES] Error 1
make[3]: Leaving directory `/var/dl/plugz/alsa-plugins/a2dpd'
make[2]: *** [install-am] Error 2
make[2]: Leaving directory `/var/dl/plugz/alsa-plugins/a2dpd'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/var/dl/plugz/alsa-plugins'
make: *** [install-recursive] Error 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I took a look at "/usr/local/lib" and "/usr/lib" and they both have=20
"alsa-lib" directories.  Both are owned, writeable and executable by=20
root as you can see below:
--
[root@tower] [21:19] [~]: ll /usr/lib/
total 322986
drwxr-xr-x  3 root root     1024 Jan 22 21:09 alsa-lib/
drwxr-xr-x  3 root root     1024 Oct 22 13:01 ao/
drwxr-xr-x  2 root root     2048 Oct 22 13:36 apache/
--
[root@tower] [21:22] [~]: ll /usr/local/lib/
total 28111
drwxr-xr-x  2 root root     1024 Jan 22 21:11 alsa-lib/
drwxr-xr-x  5 root root     1024 Nov 11 14:18 gtk-2.0/

So I don't understand why we're getting that particular error message.

>>> gdb a2dpd
>>>
>>> press 'r'
>>> when it crashes type  'bt' then give us full output.

I didn't even bother to run these commands yet until I get past the=20
previous errors.

Thanks for your help.

--=20
Kinney Baughman

-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C73EB9.C3D5D6D8
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhIGAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAWAAAAFJFIDogW0JsdWV6LWRldmVs
XSBTdGlsbCB0cnlpbmcgdG8gaW5zdGFsbCBibHVldG9vdGggaGVhZHNldCBvbiBNYW5kcml2YSAy
MDA3IGZvciBTa3lwZQDGHgEFgAMADgAAANcHAQAXAAcAJwA1AAIAWwEBIIADAA4AAADXBwEAFwAH
ACsAEQACADsBAQmAAQAhAAAANDM1MzU1QjNBNjg4MEY0MUEzREI4OTMwMDA5MzFFMjYA6AYBA5AG
AJQRAAA5AAAAAwAmAAAAAAADADYAAAAAAEAAOQB/uTtKuT7HAR4APQABAAAAAQAAAAAAAAACAUcA
AQAAADYAAABjPXVzO2E9IDtwPVBhbG1Tb3VyY2U7bD1FVU1PTkVYMDEtMDcwMTIzMDY0MzE3Wi0x
MjEwNQAAAB4ASQABAAAAVwAAAFJlOiBbQmx1ZXotZGV2ZWxdIFN0aWxsIHRyeWluZyB0byBpbnN0
YWxsIGJsdWV0b290aCBoZWFkc2V0IG9uIE1hbmRyaXZhIDIwMDcgZm9yIFNreXBlAABAAE4AALhf
zZU+xwEeAFoAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dAAAAAIBWwABAAAAcQAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGJsdWV6LWRldmVsLWJvdW5j
ZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAAAAAAgFcAAEAAAAvAAAAU01UUDpCTFVFWi1ERVZFTC1CT1VOQ0VTQExJ
U1RTLlNPVVJDRUZPUkdFLk5FVAAAHgBdAAEAAAAQAAAAS2lubmV5IEJhdWdobWFuAAIBXgABAAAA
RQAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAEtpbm5leSBCYXVnaG1hbgBTTVRQAGJhdWdobWFu
a3JAYXBwc3RhdGUuZWR1AAAAAAIBXwABAAAAHQAAAFNNVFA6QkFVR0hNQU5LUkBBUFBTVEFURS5F
RFUAAAAAHgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2Vz
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEAAAAYAAAA
YmF1Z2htYW5rckBhcHBzdGF0ZS5lZHUAHgBwAAEAAABYAAAAUkUgOiBbQmx1ZXotZGV2ZWxdIFN0
aWxsIHRyeWluZyB0byBpbnN0YWxsIGJsdWV0b290aCBoZWFkc2V0IG9uIE1hbmRyaXZhIDIwMDcg
Zm9yIFNreXBlAAIBcQABAAAAGwAAAAHHPpXXEYfeASdOwkR2sJ18lTYcl8wACNzKaAAeAHQAAQAA
ABIAAABCbHVlWiBkZXZlbG9wbWVudAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAA
HgAdDgEAAABYAAAAUkUgOiBbQmx1ZXotZGV2ZWxdIFN0aWxsIHRyeWluZyB0byBpbnN0YWxsIGJs
dWV0b290aCBoZWFkc2V0IG9uIE1hbmRyaXZhIDIwMDcgZm9yIFNreXBlAAIBCRABAAAAeQgAAHUI
AAD+EAAATFpGdf63/acDAAoAcmNwZzEyNeIyA0N0ZXgFQQEDAfdPCoACpAPjAgBjaArAc/BldDAg
BxMCgA/zAFB/BFYIVQeyEcUOUQMBEMcy9wYABsMRxTMERhDJEtsR09sI7wn3Oxi/DjA1EcIMYM5j
AFALCQFkMzYRUAumowfwETByeSADUiAFoBBuZmlnCHBlIHMRDrBwIHUAkG5nIOx0aB7AAhBsGFAD
8B9hjjoKogqAHkgtLXAYwPEecHg9Lx8wBcAhgAnwEQGgbGUtAQBidWccPXkHkCCEIIRGclz4J2U5
CzAkcQUQAOAjmT0ljwohgCcEBdAHkHNh8mcewGQnBbAegAuAItBDJwUghERlOiAKMnohIuF2ZWwt
BuB1bhJjB5BAbAQAdHMurnMIYSrAAhByJ+AuKIBrBUABACALYCAKsSxDS6cLgCiAHdBCYSMgaAOB
HSklYQ6wKaAAwHIuIEAyMy8wMS8B0DBgNyAwMzoOMCOFJ9RjMCmgQgpBWixRKkEcb3AHgAIwIIRP
YmpvLDEpoB2QKaBbMQIqBV09BgB0AxADIB2xH1NvIL8LgB7gB0ADIAoyNOBvH5DSIB+gYWQRISAC
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
YXBwc3RhdGUuZWR1PiA8NDVCNDk2NkQuMjA5MDIwN0BwYWxtc291cmNlLmNvbT4gPDQ1QjRCQzA1
LjEwMTAyMDNAYXBwc3RhdGUuZWR1PiA8NDVCNEJFQzcuNjAxMDIwM0BwYWxtc291cmNlLmNvbT4g
PDQ1QjU3MjMwLjcwNDA3QGFwcHN0YXRlLmVkdT4AAAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgy
MgAACwDyEAEAAAAfAPMQAQAAALwAAABSAEUAIAAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABlAHYA
ZQBsAF0AIABTAHQAaQBsAGwAIAB0AHIAeQBpAG4AZwAgAHQAbwAgAGkAbgBzAHQAYQBsAGwAIABi
AGwAdQBlAHQAbwBvAHQAaAAgAGgAZQBhAGQAcwBlAHQAIABvAG4AIABNAGEAbgBkAHIAaQB2AGEA
IAAyADAAMAA3ACAAZgBvAHIAIABTAGsAeQBwAGUALgBFAE0ATAAAAAsA9hAAAAAAQAAHMCZXOUq5
PscBQAAIMDxg38O5PscBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxl
YXUAAAAAAgH5PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VS
Q0UvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/
AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0
uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAA
AAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRB
TExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQAAAAeADNAAQAAABgAAABiYXVnaG1hbmtyQGFwcHN0YXRlLmVkdQAeADhAAQAAABEAAABG
UkVERVJJQy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAA
AAADAAYQj+AfAgMABxDYCgAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAFJFVFJZRlJPTUNP
TkZJR1VSRVNURVBVU0lOR1RIRUZPTExPV0lORzpDT05GSUdVUkUtLVBSRUZJWD0vVVNSLS1FTkFC
TEUtREVCVUc9WUVTRlLpROlSSUMtLS0tLS0tLU1FU1MAAAAAAgF/AAEAAABCAAAAPDdBNkRBNTQ1
RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUM1QGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4A
AADcZg==

------_=_NextPart_001_01C73EB9.C3D5D6D8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C73EB9.C3D5D6D8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C73EB9.C3D5D6D8--
