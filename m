Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Nov 2010 14:24:30 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH 1/3] Bluetooth: Simplify remote features callback
 function logic
Message-ID: <20101110162430.GD3275@vigoh>
References: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-11-10 17:11:51 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> The current remote and remote extended features event callbacks logic
> can be made simpler by using a label and goto statements instead of the
> current multiple levels of nested if statements.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   91 +++++++++++++++++++++++----------------------
>  1 files changed, 47 insertions(+), 44 deletions(-)

Applied to bluetooth-next-2.6, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
