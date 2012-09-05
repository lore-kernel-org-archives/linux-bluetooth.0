Return-Path: <cyrus@holtmann.org>
Message-ID: <1346833772.21200.79.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: mgmt: Implement support for passkey
 notification
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 05 Sep 2012 01:29:32 -0700
In-Reply-To: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
References: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds support for Secure Simple Pairing with devices that have
> KeyboardOnly as their IO capability. Such devices will cause a passkey
> notification on our side and optionally also keypress notifications.
> Without this patch some keyboards cannot be paired using the mgmt
> interface.

can we see a mgmt-api.txt documentation patch as RFC first.

Regards

Marcel


