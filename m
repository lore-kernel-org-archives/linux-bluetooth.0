Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: andoid/bluetoothd IPC: command socket connect failed android bluetooth
Date: Thu, 26 Mar 2015 09:54:55 +0100
Message-ID: <2215776.K1gUTklLIe@leonov>
In-Reply-To: <CAKafyqo7gj0uAOONe1Cf0HOXsKvEUC3mroD4A4xp8z0K9ECW6w@mail.gmail.com>
References: <CAKafyqo7gj0uAOONe1Cf0HOXsKvEUC3mroD4A4xp8z0K9ECW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu Chawandi,

On Thursday 26 of March 2015 11:54:32 Prabhu Chawandi wrote:
> Hi,
> 
>   When I started ths android daemon, I am getting above error.
> 
> Is there anything I am missing ??

On android bluetoothd is not suppose to be started directly. It is started as 
a service by init (check android/android/init.bluetooth.rc) when BT user 
(haltest or android framework) requests it. By BT user I mean process that 
loaded bluetooth.default.so via hw_get_module_by_class() call.

When bluetooth.default.so is initialized it creates listening socket and 
starts bluetoothd service so bluetoothd can then connect to it.

-- 
BR
Szymon Janc
