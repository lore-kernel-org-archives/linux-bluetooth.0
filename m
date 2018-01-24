Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <C2BC44D770753C45AAAC42695FB5BE02012572ED98@SLC-EXMB01.CORP.SRELAY.COM>
References: <C2BC44D770753C45AAAC42695FB5BE02012572ED98@SLC-EXMB01.CORP.SRELAY.COM>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jan 2018 08:54:47 -0200
Message-ID: <CABBYNZK1WdS3+FobE_V6AdAfKGVDqt3wT5JoevkzONvdfJMpEQ@mail.gmail.com>
Subject: Re: apple keyboard
To: Thomas Green <TGreen2@sorenson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Tue, Jan 23, 2018 at 8:55 PM, Thomas Green <TGreen2@sorenson.com> wrote:
> All,
>
> I have a Bluetooth apple keyboard that I'm trying to use.  The keyboard pairs and connects just fine, but the custom apple driver hid_apple.ko is never loaded.  I can
>
> modprobe hid_apple
>
> and it loads and works fine.  Where in the driver initialization code should I look to find out why the available driver isn't being loaded automatically?  I'm on bluez 5.48

What model? We need to check if the pid/vid is really matching the
driver, this should be available in dmesg when the hid device appears.
Perhaps apple has changed the pid/vid when discovered over Bluetooth.

> Tom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
