Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05051610046ddb3671@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
In-Reply-To: <1115903015.18499.34.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115722824.8949.242.camel@pegasus>
	 <e1effdeb05051006043be12b4a@mail.gmail.com>
	 <1115901638.18499.30.camel@pegasus>
	 <e1effdeb0505120553473405cc@mail.gmail.com>
	 <1115903015.18499.34.camel@pegasus>
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
Date: Mon, 16 May 2005 14:04:57 -0300

Hi Marcel,

After lost a lot of time trying change the code to support
DBUS version 0.33 I was informed that the code for get byte=20
arrays is broken.

I decided develop the PAND DBUS support based on dbus 0.23.
At least, this version works and there is debian distribution!
I can make a workaround using version 0.23 and when a new
DBUS stable version became available I can fix my part.

When I was navigating in the BlueZ source code, I notice that
bluez-pin is using DBUS service too. Therefore, there is two
applications using DBUS 0.23: bluez-pin and hcid=20

This week I will post my initial draft of DBUS PAND service.

Regards,
Claudio.

On 5/12/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I will send as soon as possible. This week is being very tumultuated
> > for me.
> >
> > Who is the focal point/contact of hcid? I want contact him for verify
> > if this patch will NOT broke something.
>=20
> post it to the mailing list for review. I will do the final decision of
> including it or not.
>=20
> Regards
>=20
> Marcel
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
