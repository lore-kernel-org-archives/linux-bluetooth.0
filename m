Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 16/16] avctp: Remove double looking for audio device
Date: Wed, 12 Dec 2012 14:24:17 +0100
Message-ID: <12216041.cC5xxHztGE@uw000953>
In-Reply-To: <CAJdJm_PqVbJTQKuqor7-2Dz+gRKTu+Bca7mSMW8PsFj8qW6itw@mail.gmail.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com> <1355308088-9080-17-git-send-email-szymon.janc@tieto.com> <CAJdJm_PqVbJTQKuqor7-2Dz+gRKTu+Bca7mSMW8PsFj8qW6itw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 12 of December 2012 15:19:44 Anderson Lizardo wrote:
> Hi Szymon,

Hi Anderson,

> 
> On Wed, Dec 12, 2012 at 6:28 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > There is no need to double call for manager_get_audio_device with
> > toggled create flag. manager_get_audio_device with create set to true
> > will only create new audio device if matching one was not found.
> 
> What's the difference between "manager_get_audio_device(device,
> FALSE)" and "manager_find_device(device)" ? Also, would be better to
> rename manager_find_device() to manager_find_audio_device()?

No difference, please see patch 13/16, manager_find_device{s} are made
static there.


-- 
BR
Szymon Janc
