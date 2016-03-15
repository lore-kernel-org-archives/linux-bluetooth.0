Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFah_xDfwqU3pGMoJ_fUwN=ZqwMGJrGp4Ynj-+wNjzF67oD75g@mail.gmail.com>
References: <CAFah_xDfwqU3pGMoJ_fUwN=ZqwMGJrGp4Ynj-+wNjzF67oD75g@mail.gmail.com>
Date: Tue, 15 Mar 2016 11:07:20 +0200
Message-ID: <CABBYNZLZYoingyodYn3XpBy0ci3Qy1vNz1zRk6kdZB4DGGgx2A@mail.gmail.com>
Subject: Re: Raspberry Pi 3: BLE via Java?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: PV Subramanian <pvs@visybl.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 15, 2016 at 2:05 AM, PV Subramanian <pvs@visybl.com> wrote:
> Hello: Just got my new Raspberry Pi 3, and confirmed BLE is working
> (sudo hcitool lescan)

hcitool is deprecated, either use bluetoothctl or btmgmt to scan.

> How can one access BlueZ via Java, to enable applications?

There exists Java bindings for D-Bus, so you can probably use
bluetoothd, otherwise you will probably need to implement the
something to talk to the mgmt interface in java.

> Thanks
>
> PVS
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
