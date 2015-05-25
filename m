Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Support for Reconnection Address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFF@EMBSVR01.ember.local>
Date: Mon, 25 May 2015 20:59:24 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3FF7A071-7E13-480B-B3AA-53D31D24E7D0@holtmann.org>
References: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFF@EMBSVR01.ember.local>
To: Ankur Patel <ankur@embertec.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

> I just would like to know if Bluez 5.30 does support Reconnection Address Characteristic value on the peripheral as non-resolvable private address? As I didn't find any information about it on doc. Also while browsing the source, I found comment " /* FIXME: Missing Privacy and Reconnection Address */" at Line#1638 under git/src/attrib-server.c. This makes me wondering if Bluez has the support or not.

hasn’t that characteristic been removed in Bluetooth 4.1 specification?

Regards

Marcel

