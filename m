Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Low latency options for Bluetooth?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <87wox5di3k.fsf@mure.haselwarter.org>
Date: Wed, 18 Apr 2018 08:42:03 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5AE870C0-52D4-4EA8-B947-D33AE0662461@holtmann.org>
References: <87wox5di3k.fsf@mure.haselwarter.org>
To: Philipp Haselwarter <philipp@haselwarter.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Philipp,

> Legacy bluetooth codecs have a latency of ~200 ms or more, which creates
> a noticeable lag when watching videos or during voice calls.
> 
> The AptX Low Latency (LL) codec can provide a stable connection with at
> most 40 ms of latency.
> 
> - Is there a way to get AptX LL to work on Linux?
> - Are there alternatives for a low latency Bluetooth connection?

with BlueZ for Android we actually had AptX working (given CSR provided you with a correct binary).

Regards

Marcel

