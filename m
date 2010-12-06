Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Dec 2010 15:53:22 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH] Bluetooth: Fix initial RFCOMM DLC security level
Message-ID: <20101206175322.GA883@vigoh>
References: <1291643777-18851-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291643777-18851-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-12-06 15:56:17 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> Due to commit 63ce0900 connections initiated through TTYs created with
> "rfcomm bind ..." would have security level BT_SECURITY_SDP instead of
> BT_SECURITY_LOW. This would cause instant connection failure between any
> two SSP capable devices due to the L2CAP connect request to RFCOMM being
> sent before authentication has been performed. This patch fixes the
> regression by always initializing the DLC security level to
> BT_SECURITY_LOW.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>

Patch has been applied to bluetooth-2.6, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
