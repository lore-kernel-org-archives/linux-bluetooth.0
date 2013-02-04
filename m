Return-Path: <cyrus@holtmann.org>
Message-ID: <1359970052.6873.23.camel@aeonflux>
Subject: Re: [PATCH BlueZ] AVRCP: Handler player features as a byte array
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 04 Feb 2013 11:27:32 +0200
In-Reply-To: <CABBYNZ+u55P_TVMUEcfwJkc9KpT2GVnYjZzG6RuFVfWhReGpsg@mail.gmail.com>
References: <1359924910-27167-1-git-send-email-luiz.dentz@gmail.com>
	 <20130204083030.GA1147@x220>
	 <CABBYNZ+u55P_TVMUEcfwJkc9KpT2GVnYjZzG6RuFVfWhReGpsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> --- a/profiles/audio/player.c
> >> +++ b/profiles/audio/player.c
> >> @@ -67,7 +67,7 @@ struct media_player {
> >>       char                    *name;          /* Player name */
> >>       char                    *type;          /* Player type */
> >>       char                    *subtype;       /* Player subtype */
> >> -     uint64_t                features[2];    /* Player features */
> >> +     uint8_t                 *features;      /* Player features */
> >
> > Why not just have this as features[16] here as well so you don't need to
> > do g_memdup and g_free?
> 
> I was planning to have a NULL check if the features are valid.

actually I like to decrease the number of extra memory allocations. So
what benefit is the test for features giving you actually.

Regards

Marcel


