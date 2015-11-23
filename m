Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2] Bluetooth: Fix powering on with privacy and advertising
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448224941-834-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Date: Mon, 23 Nov 2015 13:58:53 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4B5D0F1E-52F4-4A21-BEE5-5C9F62AF65EA@holtmann.org>
References: <1448224941-834-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> In order to enable advertising with privacy enabled, SMP has to be
> registered in order to generate new RPA. During power on, it will be
> registered at the very end which is the reason why advertising is not
> enabled and it's not possible to enable it anymore due to mismatch
> between hci_dev settings and actual controller state.
> 
> This fixes this problem by moving SMP registration earlier, just after
> controller is powered (which is ok, because LE SMP will be already able
> to decide on identity address to be used), but before advertising is
> enabled.
> ---
> net/bluetooth/mgmt.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

