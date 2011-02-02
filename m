Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 13:56:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash while parsering of endpoint properties
Message-ID: <20110202115640.GA16858@jh-x301>
References: <1296645176-23502-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296645176-23502-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 02, 2011, Luiz Augusto von Dentz wrote:
> When parsing endpoint properties application my not have set some of the
> mandatory properties, also the size of capability is now initialized with
> 0 so if the codec doesn't have any capabilities (e.g. pcm) the variable
> won't be used uninitialized.
> ---
>  audio/media.c |   25 +++++++++++++++++--------
>  1 files changed, 17 insertions(+), 8 deletions(-)

Pushed upstream. Thanks.

Johan
