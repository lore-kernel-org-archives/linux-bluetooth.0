Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1480498971.2363.1.camel@toniob.net>
Subject: Re: Continuing the Xbox One Bluetooth controller debugging
From: Anthony Bourguignon <contact@toniob.net>
To: Cameron Gutman <aicommander@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vinicius.gomes@intel.com
Date: Wed, 30 Nov 2016 10:42:51 +0100
In-Reply-To: <1480481503.2256.4.camel@gmail.com>
References: <1480481503.2256.4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Le mardi 29 novembre 2016 à 20:51 -0800, Cameron Gutman a écrit :
> Hi,
> 
> I'm interesting in continuing the debugging of the Xbox One S
> controller's issues with the BlueZ stack (original report [0]).
> I confirmed the issue still affects v4.9-rc7. I've also tried
> Vinicius's patch from [1] applied on v4.9-rc7 without success.
> 
> The controller is updated with the latest firmware and connects
> reliably to (at least) macOS Sierra, Windows 10 14393, Android
> 6.0.1, 7.0, and 7.1.1 (including devices using 3.10 and 3.18
> based kernels).
> 
> I'm happy to collect logs, test other patches, etc.

Steam has made a patch referencing the xbox one S controller :
https://github.com/ValveSoftware/steamlink-sdk/commit/d6afa93787217033a0f0f5db5f557b252c36260e#diff-
45ba5a41f43606276c9bf9018eed43c2

You should check this.
