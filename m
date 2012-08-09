Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
References: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
Date: Thu, 9 Aug 2012 12:50:18 +0300
Message-ID: <CABBYNZ+x4bVxA8=DH+=DytA-vebdG30q=KrRwKNR8pzyHXkoJA@mail.gmail.com>
Subject: Re: [PATCH BlueZ V2 0/3] Remove remained local A2DP endpoints
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi chanyeol,

On Thu, Aug 9, 2012 at 10:45 AM,  <chanyeol.park@samsung.com> wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
>
> Local A2DP endpoints(SBC,MPEG) are not used anymore.
> So references, structures, and functions related to them should be
> removed.
>
> Chan-yeol Park (3):
>   audio: Remove unused local A2DP endpoints reference
>   audio: Remove legacy SBC endpoint
>   audio: Remove legacy MPEG endpoint
>
>  audio/a2dp.c |  484 +---------------------------------------------------------
>  audio/a2dp.h |   99 ------------
>  2 files changed, 3 insertions(+), 580 deletions(-)
>
> --
> 1.7.9.5

All 3 patches are now upstream, thanks.

-- 
Luiz Augusto von Dentz
