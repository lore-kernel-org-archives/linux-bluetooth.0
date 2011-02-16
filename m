Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 16 Feb 2011 10:02:06 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "Cho, Yu-Chen" <acho@novell.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, jlee@novell.com
Subject: Re: [PATCH] Add Atheros BT AR5BBU12 fw supported
Message-ID: <20110216130206.GB14085@joana>
References: <967f2d5b2d6382f4aa698a549d4bfa74f35c171f.1297736230.git.acho@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <967f2d5b2d6382f4aa698a549d4bfa74f35c171f.1297736230.git.acho@novell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cho,

* Cho, Yu-Chen <acho@novell.com> [2011-02-15 10:20:07 +0800]:

> Add the btusb.c blacklist [0489:e02c] for Atheros AR5BBU12 BT
> and add to ath3k.c supported this device.
> 
> Signed-off-by: Cho, Yu-Chen <acho@novell.com>
> ---
>  drivers/bluetooth/ath3k.c |    3 +++
>  drivers/bluetooth/btusb.c |    3 +++
>  2 files changed, 6 insertions(+), 0 deletions(-)

Applied to bluetooth-2.6, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
