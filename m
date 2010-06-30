Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 21:54:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add udev scripts to gitignore.
Message-ID: <20100630185429.GA12678@jh-x301>
References: <1277860131-3285-1-git-send-email-jprvita@gmail.com>
 <20100630095833.GA2866@jh-x301>
 <AANLkTinBR8gOf-jsqxf2gUkAm08gprUe_KsGc4p7rxLU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinBR8gOf-jsqxf2gUkAm08gprUe_KsGc4p7rxLU@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 30, 2010, João Paulo Rechi Vita wrote:
> 2010/6/30 Johan Hedberg <johan.hedberg@gmail.com>:
> > Hi,
> >
> > On Tue, Jun 29, 2010, João Paulo Rechi Vita wrote:
> >> +scripts/97-bluetooth.rules
> >> +scripts/97-bluetooth-hid2hci.rules
> >
> > How do these files get created? I've never seen them in my bluez tree.
> >
> 
> You have to enable udevrules during the configure phase. They were
> probably leftover because most devs use bootstrap-configure script,
> which pass --disable-udevrules to configure.

Ok, I now get them with that switch. The patch is now pushed upstream
with a minor modification of grouping the entries together with
scripts/bluetooth.rules (which was already in .gitignore).

Johan
