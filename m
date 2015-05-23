Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sat, 23 May 2015 13:15:09 +0930
Subject: Support for Reconnection Address
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFF@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

I just would like to know if Bluez 5.30 does support Reconnection Address Characteristic value on the peripheral as non-resolvable private address? As I didn't find any information about it on doc. Also while browsing the source, I found comment " /* FIXME: Missing Privacy and Reconnection Address */" at Line#1638 under git/src/attrib-server.c. This makes me wondering if Bluez has the support or not.

Regards,
Ankur
