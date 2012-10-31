Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 16:18:01 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Notify about device registration before power
 on
Message-ID: <20121031181801.GB1679@joana>
References: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-10-30 01:35:40 -0700]:

> It is important that the monitor interface gets notified about
> a new device before its power on procedure has been started.
> 
> For some reason that is no longer working as expected and the power
> on procedure runs first. It is safe to just notify about device
> registration and trigger the power on procedure afterwards.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
