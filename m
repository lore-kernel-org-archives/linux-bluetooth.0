Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/7] adapter: Convert adapter_get_address into simple getter
Date: Fri, 5 Oct 2012 13:00:43 +0200
Message-ID: <2873952.xf1WXSFxdW@uw000953>
In-Reply-To: <CAJdJm_N7omVUmhsmWoOUyCmuWojAKN5Lms=6a0qwbsYbXCf_Bw@mail.gmail.com>
References: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com> <CAJdJm_N7omVUmhsmWoOUyCmuWojAKN5Lms=6a0qwbsYbXCf_Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 05 of October 2012 13:54:17 Anderson Lizardo wrote:
> Hi Szymon,

Hi,

> 
> On Fri, Oct 5, 2012 at 4:16 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > @@ -2578,6 +2557,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
> >         if (device_is_bonded(device))
> >                 return btd_error_already_exists(msg);
> >
> > +                               adapter_get_address(adapter),
> >         bonding = bonding_request_new(msg, device, agent_path,
> >                                         capability);
> >
> 
> The above looks like a typo (and unfortunately, it compiles, due to the comma).


Crap, will send fix asap.

-- 
BR
Szymon Janc
