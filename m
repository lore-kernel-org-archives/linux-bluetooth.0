Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluez Certification
From: Marcel Holtmann <marcel@holtmann.org>
To: Balaji Palaniswami <balaji_palaniswami@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <454943.43647.qm@web95403.mail.in2.yahoo.com>
References: <454943.43647.qm@web95403.mail.in2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Jul 2009 10:40:04 -0700
Message-Id: <1246988404.3384.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balaji,

> I had a couple of questions related to the BQB qualification
> of the Bluez stack and was wondering if someone could help with the same
>  
> The BQB certification is of two types – profile and host.
> Basically we are trying to get the BQB profile qualification for a BT
> dongle.
>  
> There are a number of companies that have done the BQB host
> side certification for the Bluez stack. Ideally we would like to leverage the
> BT host certification done by the other companies for the host side and simply do a profile cert for our device.
>  
> The questions I have are the following:
> Is 1) Is it possible to reuse a certification done by someone
> else? Has this been done before? ( The Helsinki developer meeting minutes from
> 2008 seem to suggest this has been done before)

yes, it is possible if kernel version and source code are matching. And
if the BlueZ source code is matching.

> 2) If it is possible then what is the procedure for the
> same? 

Just do it. The Bluetooth SIG has a procedure for it. It is a little bit
confusing, but should still work.

> 3) Is there a particular BQ ID that has been made
> available for other people to use?

There are few, but it always depends on 1) and it if matches.

> 4) Have any devices been qualified for Bluetooth 2.1 with
> Bluez?

Yes. Not sure if all of them are listed yet.

Regards

Marcel


