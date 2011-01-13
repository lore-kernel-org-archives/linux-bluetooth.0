Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jan 2011 17:08:00 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Alexander Holler <holler@ahsoftware.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Alicke Xu <sxu@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: reduce memory usage
Message-ID: <20110113190800.GA13675@vigoh>
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290456541-3812-1-git-send-email-holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

* Alexander Holler <holler@ahsoftware.de> [2010-11-22 21:09:01 +0100]:

> There is no need to hold the firmware in memory.
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  drivers/bluetooth/ath3k.c |   75 ++++++++++++---------------------------------
>  1 files changed, 20 insertions(+), 55 deletions(-)

I'm assuming you tested it a lot. Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
