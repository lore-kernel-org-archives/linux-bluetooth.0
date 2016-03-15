Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADGFtMXS0+XWywLJ_=0B_xWaHLCKUKK4HC+ge+3d_G5X_v7z0A@mail.gmail.com>
References: <CADGFtMXS0+XWywLJ_=0B_xWaHLCKUKK4HC+ge+3d_G5X_v7z0A@mail.gmail.com>
Date: Tue, 15 Mar 2016 17:42:31 +0200
Message-ID: <CABBYNZJ+kH0sOjcuhzT6MAoJ=exnqGK9BKs92rs6N6RV8eH+SA@mail.gmail.com>
Subject: Re: device keeps being found and removed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luca Dionisi <luca.dionisi@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luca,

On Tue, Mar 15, 2016 at 3:55 PM, Luca Dionisi <luca.dionisi@gmail.com> wrote:
> I've got this problem on a bq ubuntuphone.
> I've used a bluetooth keyboard with it several times. Today I pressed
> a button "forget this device" on the UI of the phone. Afterwards I
> cannot see the keyboard again when a scan is performed.
> I connected to the phone with ssh and found that a CLI tool was
> present: bluetoothctl.
> From this tool, when I press the pairing button on the bluetooth
> keyboard I see a message with NEW followed immediately by a message
> with CHG and one with DEL referring to the keyboard.
>
> What's the problem?

It has probably deleted your link-key which means you wont be to
reconnect to it until you do a new pairing. Usually for this type of
peripheral you need to put them into pairing mode so that way it
becomes visible again and then you can use the UI or bluetoothctl to
pair to it again which should fix the problem.

-- 
Luiz Augusto von Dentz
