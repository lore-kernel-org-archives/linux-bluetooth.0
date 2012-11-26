Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Nov 2012 13:26:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/5] adaptername: Remove not needed empty remove callback
Message-ID: <20121126112615.GA25303@x220>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
 <1353920860-14912-4-git-send-email-szymon.janc@tieto.com>
 <CAJdJm_OLsmmxvLddeT2T=Xg427=ADNNdmfSRre5+jB-inTiGBw@mail.gmail.com>
 <7243377.vN3q5Zuh5I@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7243377.vN3q5Zuh5I@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 26, 2012, Szymon Janc wrote:
> On Monday 26 of November 2012 12:45:30 Anderson Lizardo wrote:
> > Hi Szymon,
> 
> Hi Anderson,
> 
> > 
> > On Mon, Nov 26, 2012 at 5:07 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > >  static struct btd_adapter_driver adaptername_driver = {
> > >         .name   = "adaptername",
> > >         .probe  = adaptername_probe,
> > > -       .remove = adaptername_remove,
> > > +       .remove = NULL,
> > >  };
> > 
> > This variable is static, so not explicitly initialized members will be NULL.
> 
> Yes, yet according to code style for bluez statics should be initialized
> explicitly, right? Or this does not count for struct members?

I've left this out for struct members at least in new code so I'd say
that it's not needed.

Johan
