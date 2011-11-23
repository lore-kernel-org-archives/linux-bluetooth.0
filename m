Return-Path: <cyrus@holtmann.org>
Message-ID: <1322059647.29909.4.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Correct version check in hci_setup
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 Nov 2011 15:47:27 +0100
In-Reply-To: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Check for hci_ver instead of lmp_ver
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


