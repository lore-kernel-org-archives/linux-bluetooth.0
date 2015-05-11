Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <554CC8A9.4090604@lampreynetworks.com>
References: <554CC8A9.4090604@lampreynetworks.com>
Date: Mon, 11 May 2015 11:03:59 +0300
Message-ID: <CABBYNZKtYh2pUiyr5sTV31SMDm6sw=_zX3PphqHmn+99LE7wOg@mail.gmail.com>
Subject: Re: LE device automatic pairing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tom Harada <tharada@lampreynetworks.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Fri, May 8, 2015 at 5:31 PM, Tom Harada <tharada@lampreynetworks.com> wrote:
> Hi all,
>
> On a system with kernel 4.0.1 and BlueZ 5.22 or newer, I've noticed that
> BlueZ seems to be automatically pairing with LE devices as soon as it
> detects their advertisements. Is this an intended feature? If so, how can I
> prevent it from happening?

It should be pairing, bluetoothd will create objects for devices found
during the scan but they are considered temporary as long as you don't
request to connect or pair, if you connect to it will still not be
paired but it will be stored persistently in the storage so you can
access after restarting bluetoothd.

With this in mind, what had made you believe we were performing
pairing during scanning?


-- 
Luiz Augusto von Dentz
