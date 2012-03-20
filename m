Return-Path: <cyrus@holtmann.org>
Message-ID: <1332267529.1870.22.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Refactor stop_discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Mar 2012 11:18:49 -0700
In-Reply-To: <1332267336-15967-1-git-send-email-andre.guedes@openbossa.org>
References: <1332267336-15967-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch does a trivial code refactoring in stop_discovery
> function by using a switch statement instead of an if-return-else
> approach.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


