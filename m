Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] bluetooth/{bnep,cmtp,hidp}: Remove unnecessary
 smp_mb__{before,after}_atomic
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
Date: Tue, 21 Aug 2018 16:55:47 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Message-Id: <FA7B52C1-96F5-47E5-83EB-E2A2147490ED@holtmann.org>
References: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

> The barriers are unneeded; wait_woken() and woken_wake_function()
> already provide us with the required synchronization: remove them
> and document that we're relying on the (implicit) synchronization
> provided by wait_woken() and woken_wake_function().
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> net/bluetooth/bnep/core.c |  7 ++++---
> net/bluetooth/cmtp/core.c | 14 ++++++++------
> net/bluetooth/hidp/core.c | 13 ++++++++-----
> 3 files changed, 20 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
