Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603030622x37694d06sfcdbf5bbbb7bcf98@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2656_8915122.1141395758004"
Subject: [Bluez-users] Re: Re: Re: Re: Help me! hciattach have no error msg, but hciconfig don't find the device.
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
Date: Fri, 3 Mar 2006 22:22:38 +0800

------=_Part_2656_8915122.1141395758004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,Erwin
Follows your suggestion, I want to download bluez-utils-2.10 and
bluez-libs-2.10 package from
http://bluez.sf.net/download/bluez-utils-2.10.tar.gz
But, I can not download these source because of network enviroment.
Can you do me a favor to send me the copy of bluez-utils-2.10 and
bluez-libs-2.10 package to my email(zhuyong0003@gmail.com)?

Thanks a lot.

Best regards
yong Zhu

Am Donnerstag, den 02.03.2006, 23:08 +0800 schrieb zhu yong:
> Hi,Erwin
> my board use Samsung 44B0x chip of ATM7TDMI. I use bluez-utils-2.24
> and bluez-libs-2.24.
> Do I need patchs for non-mmu systems?
> Is 'startup script'  /etc/hcid.conf?
> I have no ides how to change the file, I use default config.

>The default config should be ok. Some patches are necessary because of
>the fork() restrictions on nommu (they may be different for 2.24!):
>http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez-utils-2.10/

>My startup script works as follows:

>/sbin/hcid -n &
>/sbin/hciattach ttyS0 csr &

>-Erwin

------=_Part_2656_8915122.1141395758004
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,Erwin</div>
<div>Follows your suggestion, I want to download bluez-utils-2.10 and bluez=
-libs-2.10 package from</div>
<div><a href=3D"http://bluez.sf.net/download/bluez-utils-2.10.tar.gz">http:=
//bluez.sf.net/download/bluez-utils-2.10.tar.gz</a><br>But, I can not downl=
oad these source because of network enviroment.</div>
<div>Can you do me a favor to send me the copy of bluez-utils-2.10 and blue=
z-libs-2.10 package to my email(<a href=3D"mailto:zhuyong0003@gmail.com">zh=
uyong0003@gmail.com</a>)?</div>
<div>&nbsp;</div>
<div>Thanks a lot.</div>
<div>&nbsp;</div>
<div>Best regards</div>
<div>yong Zhu</div>
<div><br>Am Donnerstag, den 02.03.2006, 23:08 +0800 schrieb zhu yong:<br>&g=
t; Hi,Erwin<br>&gt; my board use Samsung 44B0x chip of ATM7TDMI. I use blue=
z-utils-2.24<br>&gt; and bluez-libs-2.24.<br>&gt; Do I need patchs for non-=
mmu systems?
<br>&gt; Is 'startup script' &nbsp;/etc/hcid.conf?<br>&gt; I have no ides h=
ow to change the file, I use default config.<br><br>&gt;The default config =
should be ok. Some patches are necessary because of<br>&gt;the fork() restr=
ictions on nommu (they may be different for=20
2.24!):<br>&gt;<a onclick=3D"return top.js.OpenExtLink(window,event,this)" =
href=3D"http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez-utils-2.10/=
" target=3D"_blank">http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez=
-utils-2.10/
</a><br><br>&gt;My startup script works as follows:<br><br>&gt;/sbin/hcid -=
n &amp;<br>&gt;/sbin/hciattach ttyS0 csr &amp;<br><br>&gt;-Erwin<br>&nbsp;<=
/div>

------=_Part_2656_8915122.1141395758004--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
