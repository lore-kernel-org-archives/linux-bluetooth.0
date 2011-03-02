Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1299074246.24834.30.camel@macbook.infradead.org>
References: <1299072814-11660-1-git-send-email-geryk@ti.com>
	<1299074246.24834.30.camel@macbook.infradead.org>
Date: Wed, 2 Mar 2011 16:28:30 +0200
Message-ID: <AANLkTikLmg54gHK2tBDMdaHrJH-e6gCEtoAtBov3L-88@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Initial release for Bluetooth init script
From: "Kahn, Gery" <geryk@ti.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Gery Kahn <gery.kahn@gmail.com>, linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Luciano Coelho <coelho@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear David,

On Wed, Mar 2, 2011 at 15:57, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2011-03-02 at 15:33 +0200, Gery Kahn wrote:
>>
>>  WHENCE                            |   12 ++++++++++++
>>  ti-connectivity/TIInit_7.2.31.bts |  Bin 0 -> 48909 bytes
>
> Does this live in /lib/firmware or in /lib/firmware/ti-connectivity?
>
> If the former, please don't put the actual file in a subdirectory. If
> the latter, your comment in the WHENCE file is wrong.
>
This is live in /lib/firmware/ti-connectivity. It is new policy for us, so
i missed it.
Sending v2.


Gery
