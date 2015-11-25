Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 25 Nov 2015 16:18:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] agent: Change default IO capability to KeyboardDisplay
Message-ID: <20151125141808.GA17560@t440s.lan>
References: <1448454427-13266-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448454427-13266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 25, 2015, Johan Hedberg wrote:
> The intention of the DisplayYesNo default capability was originally to
> provide the richest possible option available. However with LE there
> is a new even more capable option, namely KeyboardDisplay. When
> applied to BR/EDR connections this gets implicitly downgraded to
> DisplayYesNo since KeyboardDisplay is LE-specific.
> ---
> I'm sending this to the list for comments since in principle it's changing
> the behavior of a non-experimental D-Bus API.
> 
>  doc/agent-api.txt | 2 +-
>  src/agent.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied.

Johan
