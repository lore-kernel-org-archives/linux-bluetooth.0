Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Jan 2011 16:25:46 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 09/11] Bluetooth: Fix leaking blacklist when
 unregistering a hci device
Message-ID: <20110117182546.GB2885@vigoh>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
 <1294135732-26765-9-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294135732-26765-9-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-01-04 12:08:50 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> The blacklist should be freed before the hci device gets unregistered.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

This one is applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
