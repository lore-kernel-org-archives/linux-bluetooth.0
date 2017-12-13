Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: Add support to advertise when connected
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171208124057.32162-1-lukasz.rymanowski@codecoup.pl>
Date: Wed, 13 Dec 2017 09:42:35 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FAED1DA6-7C0F-47A0-AA07-C392AB43AF67@holtmann.org>
References: <20171208124057.32162-1-lukasz.rymanowski@codecoup.pl>
To: =?utf-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> So far, kernel did not allow to advertise when there was a connection
> established. With this patch kernel does allow it if controller
> supports it.
> 
> If controller supports non-connectable advertising when connected, then
> only non-connectable advertising instances will be advertised.
> 
> Signed-off-by: Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
> ---
> net/bluetooth/hci_request.c | 55 +++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 46 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

I also assume that we will be getting mgmt-tester patches to verify the behavior.

Regards

Marcel

