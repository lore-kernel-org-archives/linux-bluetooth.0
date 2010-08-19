Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 18:02:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Marcel J.E. Mol" <marcel@mesa.nl>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] IrMC sync server support
Message-ID: <20100819150210.GA19066@jh-x301>
References: <201008121013.o7CADR8r004125@joshua.mesa.nl>
 <1281613299.12579.266.camel@localhost.localdomain>
 <20100816172238.GA27814@joshua.mesa.nl>
 <AANLkTi=p5WD+WELPNo=URLVTnpaKQ4xFk9Efu2HiviYE@mail.gmail.com>
 <20100817084850.GA16821@joshua.mesa.nl>
 <AANLkTinD_KNBBpxwXZ8gB5p2o+NA_ThfbmspXe-5NGEc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinD_KNBBpxwXZ8gB5p2o+NA_ThfbmspXe-5NGEc@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 19, 2010, Luiz Augusto von Dentz wrote:
> We decided to use 14, also Johan pushed a complete list of bluez
> assigned number to:
> 
> http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=fbeff4fd303b43fa7f6c27e95fb6f023e80720a9;hp=0627552640140e1d986d36bb4770ccc4b3206b03
> 
> Could you please update your changes to use 14? Also there seems to be
> some white spaces that doesn't follow our code styling, could you
> please fix those?

Since Luiz didn't send an update here about the status I'll do it to
avoid duplicate work at your end. Luiz went ahead and did the cleanups
himself (and I added a few more on top of that) and the resulting patch
is now pushed upstream. Btw, it'd proabably be a good idea for you to
hang out on the #obexd channel on freenode since that's where many of
these quick interactions and decisions seem to be happening now days.

Johan
