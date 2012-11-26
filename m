Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/5] adaptername: Remove not needed empty remove callback
Date: Mon, 26 Nov 2012 11:52:34 +0100
Message-ID: <7243377.vN3q5Zuh5I@uw000953>
In-Reply-To: <CAJdJm_OLsmmxvLddeT2T=Xg427=ADNNdmfSRre5+jB-inTiGBw@mail.gmail.com>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com> <1353920860-14912-4-git-send-email-szymon.janc@tieto.com> <CAJdJm_OLsmmxvLddeT2T=Xg427=ADNNdmfSRre5+jB-inTiGBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 26 of November 2012 12:45:30 Anderson Lizardo wrote:
> Hi Szymon,

Hi Anderson,

> 
> On Mon, Nov 26, 2012 at 5:07 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> >  static struct btd_adapter_driver adaptername_driver = {
> >         .name   = "adaptername",
> >         .probe  = adaptername_probe,
> > -       .remove = adaptername_remove,
> > +       .remove = NULL,
> >  };
> 
> This variable is static, so not explicitly initialized members will be NULL.

Yes, yet according to code style for bluez statics should be initialized
explicitly, right? Or this does not count for struct members?

-- 
BR
Szymon Janc
