Return-Path: <cyrus@holtmann.org>
Subject: Re: Abt hcid.conf
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6887eb5d0902250749t784b97cahe8f24af7b335570a@mail.gmail.com>
References: <6887eb5d0902250749t784b97cahe8f24af7b335570a@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 18:23:04 +0100
Message-Id: <1235582584.24169.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

> I m modifying hcid.com lying in /etc/bluetooth for "security none"
> which as per hcid.conf disables security manager.
> So after that when I reboot my linux and then try to connect with
> bluetooth headset BH-209 (Nokia) it doesn't connect to it.
> Error is "Connection refused" which is because of no linkkey.
> 
> when I disable security manager why it checks for security???
> Even I tried with "security auto" which reads local passkey that I
> have set to "0000" and my BH-209 also have default PIN "0000", still
> it prompts to enter passkey in bluetooth pairing & control wizard.
> 
> So I m confused...exactly how can we disable security manager for
> simple connections?
> Does changes in hcid.conf make any impact?
> I m using bluez-4.30 on Fedora 9 (kernel 2.6.25-14)

with Bluetooth if only one side requires authentication and encryption
you have to do it (even if security is none). And all headsets require a
proper pairing.

Regards

Marcel


