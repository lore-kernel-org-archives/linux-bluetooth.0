Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alex Coplan <alex.coplan@starleaf.com>
Content-Type: text/plain; charset=utf-8
Subject: Change LE advertising interval via D-Bus API
Message-Id: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com>
Date: Tue, 9 Aug 2016 13:09:09 +0100
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

There doesn’t currently appear to be an obvious way to change the advertising interval via the D-Bus API.

Are there plans to add this as an option to the RegisterAdvertisement method, or perhaps a property of the LEAdvertisement1 interface?

Regards,
Alex