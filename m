Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160511125102.GC17904@arthur-bzh>
References: <20160511125102.GC17904@arthur-bzh>
Date: Thu, 12 May 2016 11:39:44 +0300
Message-ID: <CABBYNZ+c4mFuBUsR3uzOnMKMKJV-3GXkJiDZESoWzBvnXRg6Yg@mail.gmail.com>
Subject: Re: gatt server and reset of hci device
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arthur LAMBERT <lambertarthur22@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arthur,

On Wed, May 11, 2016 at 3:51 PM, Arthur LAMBERT
<lambertarthur22@gmail.com> wrote:
> Hi,
>
> I am working with bluez 5.39. I have a custom gatt server which used c api from
> btgatt-server from bluez source. Eveything is working great exept when I reset
> hci device. I need to disable bluetooth for few hours for specific use case.
>
> If I run hci down/up and try again to connect to gatt server, the client is able
> to connect but services are not available. Moreover my server does not see the
> client connexion.
>
> Do I need to make a specific stuff to be able to make it work this use case ?

Is that something preventing you to use bluetoothd and just create a
plugin or use the GATT API for your server? Manually using hciconfig
is not recommended since it may interfere with other users, for manual
testing it is actually recommended to use btmgmt or bluetoothd +
bluetoothctl. Also note that having btgatt-server along side with
bluetoothd will not work because both listen on the same channel and
the kernel can only redirect the packets to one process.
