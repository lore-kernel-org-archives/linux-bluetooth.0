Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Limit OOB to P-256 values for Secure Connection Only mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2080375.GZdINHllEn@leonov>
Date: Tue, 27 Jan 2015 13:08:34 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <459A528B-2187-4CD6-B299-42EB967F98FF@holtmann.org>
References: <1422386512-15819-1-git-send-email-marcel@holtmann.org> <2080375.GZdINHllEn@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>> When using Secure Connection Only mode, the P-192 hash and rand values
>> for BR/EDR and the TK value for LE are not valid. The Secure Connections
>> Only mode limits the encryption keys to P-256 derived values for both
>> transports. To avoid accidentally loading weak values for pairing just
>> restrict it to P-256 values.
> 
> If so, shouldn't enabling Secure Connection Only mode result in clearing OOB 
> data (or at least removing legacy ones)?

coming to think about this, another option is to just not use the P-192 values when in SC only mode. Which is something we are currently missing.

Regards

Marcel

