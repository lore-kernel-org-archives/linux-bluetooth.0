Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Feb 2011 15:22:33 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add firmware support for Atheros 3012
Message-ID: <20110211172233.GA2173@joana>
References: <1297418933-15467-1-git-send-email-sbalashanmugam@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297418933-15467-1-git-send-email-sbalashanmugam@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

* Bala Shanmugam <sbalashanmugam@atheros.com> [2011-02-11 15:38:53 +0530]:

> Blacklisted AR3012 PID in btusb and added the same
> in ath3k to load patch and sysconfig files.
> 
> Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |  279 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btusb.c |    3 +
>  2 files changed, 282 insertions(+), 0 deletions(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
