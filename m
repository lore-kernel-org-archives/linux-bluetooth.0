Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] strange HP bluetooth headset
Message-ID: <20050319000704.GA31904@externe.net>
References: <20050318171309.GB25843@externe.net> <423B1845.6090604@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <423B1845.6090604@xmission.com>
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
Date: Fri, 18 Mar 2005 19:07:04 -0500

On Friday, 18 March 2005 at 11:04:53 (-0700), Brad Midgley wrote:
> we found our headsets did not follow the standard very well. maybe the=20
> hp set doesn't either.

I tried to hardcodes parameters in a2play - I can tweak them but I
don't get good results.

> is there any way you can capture the bt stream going out of your=20
> pocketpc device?

If I had a pocket PC running windows, yes. Since I only have a Zaurus
and a Simpad running Windows CE.NET, it won't be possible
immediately. The worst is I don't have the drivers CD.

> >plays much too fast, without any distortion however. So I guess
> >there's some capability settings I'm missing.
>=20
> what else does a2play print out, like the capabilities, etc?

I thought I had posted that ?
a2play reports:
subbands =3D 1
allocation method =3D 1
channel_mode =3D 2
blocks =3D 3
sampling frequency =3D 2
bitpool =3D 32
frame len =3D 72

That's when it works better (the only problem is the audio being 2 to
4 times faster than it should be- it's hard to tell.)

Before I tried rcplay, when it was skipping a lot, I had a2play reporting=
:
subbands =3D 0
allocation method =3D 1
channel_mode =3D 0
blocks =3D 3
sampling frequency =3D 3
bitpool =3D 18
frame len =3D 38

> re: suggestions, you could try different numbers of frames in each=20
> packet... see:
>=20
> while(psize + frame_len + sizeof(sbc_info) < mtu)
>=20
> and maybe try change mtu to (mtu-1) or (mtu/2) etc...

Will do.

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
