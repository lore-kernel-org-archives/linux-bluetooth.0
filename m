Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Dec 2010 11:04:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix deinitializing telephony backend when it wasn't
 initialized
Message-ID: <20101202090440.GA18808@jh-x301>
References: <1291279564-16615-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291279564-16615-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 02, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Telephony driver is now deinitialized on headset adapter driver remove so
> telephony_exit should not be called on plugin exit anymore.
> ---
>  audio/manager.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
