Return-Path: <cyrus@holtmann.org>
Subject: Bluez-4.101 LE SMP support
To: <linux-bluetooth@vger.kernel.org>
References: <55D4834E.9080705@convergeddevices.net>
 <20150819162319.GA16000@t440s.P-661HNU-F1>
From: tony <tony.makkiel@convergeddevices.net>
Message-ID: <55E70CA1.1000308@convergeddevices.net>
Date: Wed, 2 Sep 2015 15:50:09 +0100
MIME-Version: 1.0
In-Reply-To: <20150819162319.GA16000@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
         Does bluez-4.101 (kernel 3.1.10) support LE MITM or any 
authentication procedure? I am using gatttool to establish a LE 
connection to another device with identical host and controller. 
Although, I have set sec-level high on both side, I don't see any kind 
of security triggered. The device connects to each other though.

Searching through the archives, I found posts which suggests pairing may 
not be supported using random address type. But I have not modified 
address type. So should be having public address type.

Many Thanks,
Tony
