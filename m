Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Aug 2014 13:45:52 +0200 (CEST)
From: Martin =?utf-8?Q?R=C3=B6sch?= <martin.roesch@neratec.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <900387215.186828.1407843952699.JavaMail.zimbra@neratec.com>
In-Reply-To: <CALNtCMkA=9GZWNBse7TN1u-ygWEm3zt-aNvjqhyzZV9jDCtL_g@mail.gmail.com>
References: <CALNtCMkA=9GZWNBse7TN1u-ygWEm3zt-aNvjqhyzZV9jDCtL_g@mail.gmail.com>
Subject: Re: Gatttool: Why limited to 5 connections?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nancy,

> Is this a gatttool limitation or a hardware limitation?

It is a hardware limitation of the CSR dongle.
I did a similar test using bluetoothctl not long ago: 
Using a CSR dongle, only 5 bluetooth LE devices could connect.
With a Broadcom dongle (BCM20702) I could establish 14 concurrent connections. Then I ran out of bluetooth LE devices....

Regards,

Martin
