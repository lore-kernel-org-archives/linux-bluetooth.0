Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:54:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH] Bluetooth: Don't set Discoverty Type while stopping
 Discovery
Message-ID: <20120405105414.GG32212@x220>
References: <1333601841-2301-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333601841-2301-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Thu, Apr 05, 2012, Hemant Gupta wrote:
> This patch prevents resetting of discovery type while stopping
> discovery, which was sending wrong type information to management
> interface of BlueZ when discovery failed.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/hci_core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied to bluetooth-next, but you really need to start using a spell
checker on your commit messages. Also, you don't necessarily need to
refer to the behavior caused to current user space since it's perfectly
possible to justify the patch without that. Furthermore, please prefix
any fixes with "Fix ...". It makes it easier to get these pulled once
applied to bluetooth.git (less explaining to do to the wireless
maintainer).

Johan
