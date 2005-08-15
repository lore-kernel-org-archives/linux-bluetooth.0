Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <396736060508141923370a6662@mail.gmail.com>
From: Robert Brewer <rwb123@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing problem - please help
In-Reply-To: <42FEDEBA.8060007@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <39673606050813203174545cc1@mail.gmail.com>
	 <42FEDEBA.8060007@xmission.com>
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
Date: Sun, 14 Aug 2005 22:23:34 -0400

I'm not sure I ever had an /etc/bluetooth/link_key file. =20
I've got an email into Logitech support to find out more
about it pairing abilities and any reset capability... but
my guess is the best I can do is remove the battery.  I'm
not certain that will clear its memory though.

If I tried to find the PIN and hostname used on the Windows
side would that help?

Thanks for the tips.

-Rob

On 8/14/05, Brad Midgley <bmidgley@xmission.com> wrote:
> Robert,
>=20
> > A few weeks ago I successfully paired my headset with my broadcom dongl=
e
> > under bluez.  I was able to l2ping the headset, and btsco was able to m=
ake
> > the headset ring.  I couldn't get audio data through, but now I know th=
at
> > is because bluez doesn't support SCO for broadcom.
> >
> > Now I can't get the headset paired.  The past week I've been pairing th=
e headset
> > with the same dongle under WinXP.  Any thoughts on what is going wrong?
>=20
> Several people have had similar issues. Sometimes, removing
> /etc/bluetooth/link_key works since it resets the pairing. Sometimes it
> doesn't help at all.
>=20
> Is it true that the failed attempts are all on dualboot machines that
> have used windows to pair to the headset? Maybe the headset remembers
> the bdaddr but gets confused by the fact that the stored credentials
> under linux don't match the last pairing in windows. That's about the
> only idea I've had on it and I don't see much discussion here about
> what's going on...
>=20
> Some headsets remember multiple pairings. Does yours have a reset,
> something more drastic than just putting it in pairing mode? My iTech
> set has a reset but I've come to believe they put that in there because
> the headset completely locks up and becomes unresponsive on occasion :(
>=20
> Brad
>=20
>=20

--=20
Robert W. Brewer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
