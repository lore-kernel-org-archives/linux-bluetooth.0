Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] [BLUETOOTH] Disable incoming connection tracking
	in DUT mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1222329541-4898-1-git-send-email-ville.tervo@nokia.com>
References: <1222329541-4898-1-git-send-email-ville.tervo@nokia.com>
Content-Type: text/plain
Date: Sat, 27 Sep 2008 07:29:10 +0200
Message-Id: <1222493350.7093.11.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> Bluetooth testers establish only low level connection and they won't
> connect to any service. If connection tracking is enabled the connection
> will drop in 10 seconds. This patch adds support for detecting DUT mode
> event and disables incoming connection tracking is status code was
> succesfull.

I think we should just put the device into RAW mode. Having another flag
for DUT is not useful and RAW mode is already handled special.

Regards

Marcel


