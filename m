Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 29 Mar 2011 08:20:30 +0200
Subject: RE: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA3377B51C79@EXDCVYMBSTM005.EQ1STM.local>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <AANLkTimhcFNDdq0FCP2rVdDJ5V_YP+E82+80OavsuAS=@mail.gmail.com>
In-Reply-To: <AANLkTimhcFNDdq0FCP2rVdDJ5V_YP+E82+80OavsuAS=@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

I was asked to break out the CG2900 specific stuff from mach-ux500
folder and put it into the staging folder.
So the function exist in the new file
drivers/staging/cg2900/board-mop500-cg2900.c
(As you point out the file and the function did not exist in
the previous patch).

/P-G

> -----Original Message-----
> From: Vitaly Wool [mailto:vitalywool@gmail.com]
> Sent: den 28 mars 2011 16:40
> To: Par-Gunnar HJALMDAHL
> Cc: Greg Kroah-Hartman; devel@driverdev.osuosl.org; Linus Walleij;
> linux-kernel@vger.kernel.org; linux-bluetooth@vger.kernel.org; Pavan
> Savoy; Alan Cox; Arnd Bergmann; Marcel Holtmann; Lukasz Rymanowski;
> Linus WALLEIJ; Par-Gunnar Hjalmdahl; Lee Jones; Mathieu Poirier
> Subject: Re: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
>=20
> On Mon, Mar 28, 2011 at 11:03 AM, Par-Gunnar Hjalmdahl
> <par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> >
> > +/* Function located in drivers/staging/cg2900 */
> > +extern void cg2900_init_board(void);
> > +
>=20
> I'm confused. Where in the drivers/staging is this function? Couldn't
> find it in the previous patch.
>=20
> ~Vitaly
