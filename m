Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
Date: Mon, 28 Mar 2011 16:49:24 +0200
Cc: "Par-Gunnar Hjalmdahl" <par-gunnar.p.hjalmdahl@stericsson.com>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 devel@driverdev.osuosl.org,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Pavan Savoy <pavan_savoy@sify.com>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com> <AANLkTimhcFNDdq0FCP2rVdDJ5V_YP+E82+80OavsuAS=@mail.gmail.com>
In-Reply-To: <AANLkTimhcFNDdq0FCP2rVdDJ5V_YP+E82+80OavsuAS=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103281649.25140.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 28 March 2011, Vitaly Wool wrote:
> On Mon, Mar 28, 2011 at 11:03 AM, Par-Gunnar Hjalmdahl
> <par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> >
> > +/* Function located in drivers/staging/cg2900 */
> > +extern void cg2900_init_board(void);
> > +
> 
> I'm confused. Where in the drivers/staging is this function? Couldn't
> find it in the previous patch.

It's in v2 of patch 2/2, in

drivers/staging/cg2900/board-mop500-cg2900.c

	Arnd
