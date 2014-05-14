Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] android/gatt: Fix handling advertising state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 14 May 2014 08:12:27 -0700
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Message-Id: <D2E1C6A3-BB46-4C9D-8603-241B6CF69EBE@holtmann.org>
References: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch fixes enabling advertising.
> It was not possible to enable it if we had server registered
> which is on listen_apps list but does not trigger advertising.

does this mean we always advertise when registering GATT server? If so, then this is wrong. The GATT server has nothing to do with advertising.

Regards

Marcel

