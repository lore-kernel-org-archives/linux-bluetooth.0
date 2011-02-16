Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 12:03:13 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix creating device object on disconnect complete event
Message-ID: <20110216150313.GC21777@jh-x301>
References: <1297862629-27805-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297862629-27805-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 16, 2011, Luiz Augusto von Dentz wrote:
> There is no need to create a new object if disconnected and the device is
> not permanent/paired.
> ---
>  src/event.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
