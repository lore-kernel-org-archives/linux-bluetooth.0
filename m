Return-Path: <charles@bueche.ch>
Date: Wed, 18 Aug 2004 21:14:17 +0200
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] OT: SonyEricsson K700i addressbook and OBEX over
 Bluetooth
Message-Id: <20040818211417.1d5da5d6@bluez.bueche.ch>
In-Reply-To: <1092818433.31651.60.camel@pegasus>
References: <20040817123228.2d896a07@bluez.bueche.ch>
	<1092818433.31651.60.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On Wed, 18 Aug 2004 10:40:33 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:
> > 1. OBEX File Transfer (eg to get pictures from the pone) : in
> > Konqueror, using kde-buetooth, the selection of "obex://[btaddr]:7/"
> > brings up"Authentication Required". From my analysis of the source
> > code, it might be caused by the transport layer (bluez), but not
> > sure.
> 
> Check the hcidump and ask the KDE-Bluetooth developers.

I will try to contact them directly. Sadly, their list server seem to be
down.

> > 2. UID field in VCARD's : if I send a single VCARD in a file for a
> > record already present in the phone, it asks "overwrite y/n ?". If I
> > send a file containing two or more VCARD's for records already
> > present in the phone, it duplicate them. I added a UID fields as
> > recommended by the Vcard spec, the phone seem to ignore it.
> 
> Sounds like a bug in the phone. Tell SE about it ;)

I had the same idea, unfortunately, to get in touch with a developer,
one need to pay a good amount of money. For $0, you only get access to
user forums :-/

Thanks anyway, best regards,
Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
