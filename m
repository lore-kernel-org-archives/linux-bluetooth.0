Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matias Pablo Brutti <matiasbrutti@ciudad.com.ar>
Reply-To: matiasbrutti@ciudad.com.ar
To: "Nicholas A. =?iso-8859-1?q?Prey=DF?=" <nicholas@insolent.de>,
   bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with Logitech MX 900 and Apple keyboard
References: <200404282247.31825.matiasbrutti@ciudad.com.ar> <20040429093614.GA3992@gmx.net>
In-Reply-To: <20040429093614.GA3992@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200404291209.16830.matiasbrutti@ciudad.com.ar>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Apr 2004 12:09:05 -0300

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 29 April 2004 06:36, Nicholas A. Prey=DF wrote:
> On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> > I'm running Mandrake 10.0 official with a 2.6.3-7 ... I just bougth a
> > MX900 and the apple bluetooth keyboard .. the mouse ... was working when
> > I plugged .. like if was a plug and play devide . I didn't have to
> > install anything .. although .. i did not have any bluetooth installatin
> > and if I serch for bluetooth devices . it says that I have no devides ..
> > I'm pretty new on the subject .. and I think I have to load modules to
> > the kernel .. which ones should I load for my Logitech hub .. so It will
> > be able to recognize all my bluetooth .. When I try to start bthid it
> > says that I have no uimput .. or some modules .. what should I do .. or
> > where should I read .. to get my thing working ... I really like
> > bluetooth .. and I would like to work on linux too
> > if you need more info so you can help please email me ...
> > Thanks a lot
>
> It sounds like your bluetooth chip is equipped with a hid proxy.
> Look here:
> http://www.holtmann.org/linux/bluetooth/hid.html
> Look in the CVS "bluez/utils2/hid/" there is a hid service utility.
>
> nicholas
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

Thanks for.. the info is very helpful Now I understand a little more on the=
=20
HID implementation . that should be step 2  I think .. .. the problems .. i=
s=20
that ... I haven been able to figure out .. step one . load some module . s=
o=20
when I do hcitool scan .... or  use some tool for scanning .  It will=20
actually appear something . rigth now .. nothing appears not even the mouse=
=20
that is working ...=20
Thanks a lot . Nicholas . the info was extremelly helpful .. now I get a lo=
t=20
more than before .. :) =20

Matias P Brutti
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQJEalmXJj+mzTB70AQJKgQf+J+NpJMKV+rYJOgj4sZIJ0kgq7Ay01vUX
Vm68A4u+96iCg8DZq/BOp8xYadhKFGlAXWKRYH5ix1itmhydqKEFfC29pZuhTOJM
Pp6o/CgIUbypJSsLX5FgK275keiweEpMfy5ZWLTBwsghmPWnD0yxMWstDqu6YU3W
M9bjqCUYIGCIfn/yHoyzpY0U8zURrgIKBslTmzt2fwZHeWcJ8sUPhaepL46lMZ0Y
OBiMz4uji1riVFNGnJptjPKHER9/wyF7v7HLBOK4gJo0A9Fh84eUv8EcprtnXYrq
sDF8fHKDrlv/ZNCAnLUNdfPdw5Pm85+SSzgT3loLCta4yF/oHp/s5g=3D=3D
=3DcTrK
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
