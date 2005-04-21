Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e9a6e82b0504210458a0ba170@mail.gmail.com>
From: Stefan Magdalinski <smagdali@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluez + 6630 rfcomm was working, suddenly died.
In-Reply-To: <1114013959.2469.189.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e9a6e82b050420074245382ddd@mail.gmail.com>
	 <1114008711.2469.175.camel@pegasus>
	 <e9a6e82b0504200915563ed0a0@mail.gmail.com>
	 <1114013959.2469.189.camel@pegasus>
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
Date: Thu, 21 Apr 2005 12:58:33 +0100

On 4/20/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Stefan,
>=20
> > looks like the version of hcidump (1.1.2) is too old for -V, but
> > here's what I get for -X
>=20
> then install a new one, because I am not going to decode the HCI parts
> any time again by hand.

fair enough.

so I rebuilt everything from the latest sources, was running 'hcidump
-X -V', and when I tried to connect this time, it was working again,
and I can pair the devices ok.

so thanks for your help. I'll see how it goes over the next few days.

>=20
> > is there a repository I should be adding to sources.list to pull a newe=
r one?
>=20
> The source is available.


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
