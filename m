Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Change LE advertising interval via D-Bus API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com>
Date: Tue, 9 Aug 2016 14:19:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com>
To: Alex Coplan <alex.coplan@starleaf.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> There doesn’t currently appear to be an obvious way to change the advertising interval via the D-Bus API.
> 
> Are there plans to add this as an option to the RegisterAdvertisement method, or perhaps a property of the LEAdvertisement1 interface?

what do you want to change it to? There are certain limits that make sense. For example fine control over the advertising interval from an application makes no sense. It might however make sense to have some low, medium, high interval adjectives so that bluetoothd can pick the right options. Even the mgmt API into the kernel for setting advertising has no control over advertising internal at the moment.

Regards

Marcel

