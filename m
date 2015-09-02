Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Bluez-4.101 LE SMP support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55E70CA1.1000308@convergeddevices.net>
Date: Wed, 2 Sep 2015 10:09:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <04CDDAA6-7D5F-4A0A-B27B-62B062FF973E@holtmann.org>
References: <55D4834E.9080705@convergeddevices.net> <20150819162319.GA16000@t440s.P-661HNU-F1> <55E70CA1.1000308@convergeddevices.net>
To: tony <tony.makkiel@convergeddevices.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

>        Does bluez-4.101 (kernel 3.1.10) support LE MITM or any authentication procedure? I am using gatttool to establish a LE connection to another device with identical host and controller. Although, I have set sec-level high on both side, I don't see any kind of security triggered. The device connects to each other though.
> 
> Searching through the archives, I found posts which suggests pairing may not be supported using random address type. But I have not modified address type. So should be having public address type.

the combination of BlueZ 4.101 and Linux 3.1.10 is not something I would suggest for LE usage. There is pretty much no guarantee on what works and what not. The 3.1.10 kernel does not have the mgmt interface and BlueZ 4.x has limited LE security support.

We started supporting LE officially with BlueZ 5.x and pretty much kernel 3.9 or later is recommended at least.

Regards

Marcel

