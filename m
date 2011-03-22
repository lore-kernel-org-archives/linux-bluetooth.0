Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Mar 2011 12:36:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when unregistering a2dp driver before media
 driver
Message-ID: <20110322103653.GA28726@jh-x301>
References: <1300709926-32395-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300709926-32395-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 21, 2011, Luiz Augusto von Dentz wrote:
> Since media driver uses a2dp to register its sep and store a pointer,
> this pointer may be invalid/freed when media driver is unregistered.
> 
> To fix this now a2dp will also release any sep registered using media
> API.
> 
> It also protect from future changes on the order of drivers removal by
> checking if pointers (sep or endpoint) are still available in the list
> before removing them.
> ---
>  audio/a2dp.c  |    7 +++++++
>  audio/media.c |    3 +++
>  2 files changed, 10 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
