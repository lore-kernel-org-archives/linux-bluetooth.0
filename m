Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 1/3] btusb: wake system up when receives a wake irq
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1487917471-5501-1-git-send-email-jeffy.chen@rock-chips.com>
Date: Mon, 27 Mar 2017 16:30:15 +0200
Cc: Amitkumar Karwar <akarwar@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Message-Id: <516F5219-FE0B-4578-88A6-62479A8A9BAD@holtmann.org>
References: <1487917471-5501-1-git-send-email-jeffy.chen@rock-chips.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeffy,

> Currrently we are disabling this wake irq after receiving it. If this
> happens before we finish suspend and the pm event check is disabled,
> the system will continue suspending, and this irq would not work again.
> 
> We may need to abort system suspend to avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)

the first two patches have been applied to bluetooth-next tree.

Regards

Marcel
