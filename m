Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347627360-13997-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347627360-13997-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 17 Sep 2012 16:33:37 +0300
Message-ID: <CABBYNZ+VH5MGYKkmHZ9usjWd2uxNEND5xuD6rPkPLOw8cpdCfw@mail.gmail.com>
Subject: Re: [RFC v5 0/4] Optional acquire in Media API and related
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Sep 14, 2012 at 3:55 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Same as v4 but rebased on the latest pushed patches.
>
> From original patch:
>
> This patch reopens the discussion started by the thread "when is acquire
> ok to call". The race condition seems to be real (even thought difficult
> to reproduce), and I couldn't think of any approach to solve this
> without altering the Media API.
>
> Mikel Astiz (4):
>   media: Split transport state based on playing flag
>   media: Expose transport state in D-Bus
>   media: Automatically release transport when HUP
>   media: Extend media API with optional acquire
>
>  audio/transport.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  doc/media-api.txt |   19 +++++++++
>  2 files changed, 121 insertions(+), 11 deletions(-)
>
> --
> 1.7.7.6

All 4 patches are now upstream, thanks.


-- 
Luiz Augusto von Dentz
