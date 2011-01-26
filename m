Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 26 Jan 2011 15:30:01 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "Cho, Yu-Chen" <acho@novell.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, jlee@novell.com
Subject: Re: [PATCH] add Atheros BT AR9285 fw supported
Message-ID: <20110126173001.GE27017@joana>
References: <edc8dae4f78c3c93397e1bd34a7e2337c4aaeb88.1296032839.git.acho@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <edc8dae4f78c3c93397e1bd34a7e2337c4aaeb88.1296032839.git.acho@novell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cho,

* Cho, Yu-Chen <acho@novell.com> [2011-01-26 17:10:59 +0800]:

> Add the btusb.c blacklist [03f0:311d] for Atheros AR9285 Malbec BT
> and add to ath3k.c ath3-1.fw (md5:1211fa34c09e10ba48381586b7c3883d)
> supported this device.
> 
> Signed-off-by: Cho, Yu-Chen <acho@novell.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    3 +++
>  2 files changed, 5 insertions(+), 0 deletions(-)

applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
