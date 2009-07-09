Return-Path: <cyrus@holtmann.org>
Subject: Re: Could I ask you about Bluetooth 3.0 +HS with BlueZ ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Chan-Yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <000001ca003b$03063790$0912a6b0$%park@samsung.com>
References: <000001ca003b$03063790$0912a6b0$%park@samsung.com>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 19:57:14 -0700
Message-Id: <1247108234.9709.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-Yeol,

> Recently Bluetooth SIG has announced "Bluetooth 3.0 + HS which include
> WiFi."
> 
> As far as I know, there is AMP(Alternate Mac/Phy) Layer on the L2CAP Layer..

actually AMP is below L2CAP.

> So I think we should develop additional layer for the newly made spec.
> 
> Related to this issue, comments would be appreciated.

First you have to create an AMP device layer that will hook into
mac80211 so we can use WiFi devices.

Regards

Marcel


