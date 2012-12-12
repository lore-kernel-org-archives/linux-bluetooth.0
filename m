Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 11/16] avctp: Convert register/unregister to accept btd_adapter
Date: Wed, 12 Dec 2012 14:05:34 +0100
Message-ID: <1817885.dOt4kLiv3S@uw000953>
In-Reply-To: <CAJdJm_MsHj8B3vSu3bHbstgYs0j7tYM9Dm16XK6p3jC1o0cHvw@mail.gmail.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com> <CAJdJm_M6cors5nxsbx7RCAiSTQsMscYGhPFXWZmDstrEab5hQw@mail.gmail.com> <CAJdJm_MsHj8B3vSu3bHbstgYs0j7tYM9Dm16XK6p3jC1o0cHvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 12 of December 2012 15:03:04 Anderson Lizardo wrote:
> On Wed, Dec 12, 2012 at 8:55 AM, Anderson Lizardo

Hi,

> <anderson.lizardo@openbossa.org> wrote:
> > Ignore that, now I see "manager_get_device()" returns a audio device,
> > not btd_device :)
> 
> As a side note, it is unfortunate that profiles/audio/manager.c has
> manager_get_device(), manager_find_device() etc. and src/manager.c has
> manager_find_adapter() , manager_get_default_adapter() etc. It gets
> confusing sometimes to follow code mixing these functions.

This is cleared up a bit later on in this patch set.

> 
> Regards,
> 

-- 
BR
Szymon Janc
