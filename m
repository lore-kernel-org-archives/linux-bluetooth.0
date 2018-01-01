Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] usb: quirks: Add reset-resume quirk for QCA6174 Rome
 Bluetooth
To: Leif Liddy <leif.linux@gmail.com>, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kai.heng.feng@canonical.com, stable@vger.kernel.org,
        mka@chromium.org, briannorris@chromium.org, drake@endlessm.com
References: <20171231171335.12020-1-leif.linux@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7d8d2984-deeb-a34e-80fa-09e824312e6c@cogentembedded.com>
Date: Mon, 1 Jan 2018 12:51:20 +0300
MIME-Version: 1.0
In-Reply-To: <20171231171335.12020-1-leif.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

On 12/31/2017 8:13 PM, Leif Liddy wrote:

> This is a rework of reverted commit fd865802c66bc451dc515ed89360f84376ce1a56

    You need to also specify the commit summry enclosed in (""). Alos, 12 
digits of SHA1 is enough.

> The issue is that some QCA Rome bluetooth controllers stop functioning upon resume from suspend.
> These devices seem to be losing power during suspend. This patch will enable
> reset_resume in usb core (instead of btusb) and will target the specific device 0x0cf3:0xe300
> 
> Signed-off-by: Leif Liddy <leif.linux@gmail.com>
[...]

MBR, Sergei
