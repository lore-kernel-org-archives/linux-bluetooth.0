Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add AR30XX device ID on Asus laptops
From: Marcel Holtmann <marcel@holtmann.org>
To: Keng-Yu Lin <kengyu@canonical.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Nov 2011 14:46:46 +0900
In-Reply-To: <1321413683-4502-1-git-send-email-kengyu@canonical.com>
References: <1321413683-4502-1-git-send-email-kengyu@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321422409.15441.510.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keng-Yu,

> The ID is found on Asus K54HR and K53U.
> Blacklist the AR3011-based device ID [0489:e03d]
> and add to ath3k.c for firmware loading.

please include the output of /proc/bus/usb/devices or usb-devices script
for this hardware before and after firmware loading. I want this as part
of the commit message so we have it for future reference.

Regards

Marcel


