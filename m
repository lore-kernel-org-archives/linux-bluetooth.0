Return-Path: <cyrus@holtmann.org>
Message-ID: <1331573974.14217.83.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: trivial: Correct types
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 10:39:34 -0700
In-Reply-To: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Fix sparse warnigns below:
> ...
> net/bluetooth/hci_sysfs.c:458:33: warning: cast to restricted __be32
> net/bluetooth/hci_sysfs.c:458:47: warning: cast to restricted __be16
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_sysfs.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


