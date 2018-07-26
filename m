Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/1] input/hog-lib: set notify bit on every
 connection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20180725200728.11835-1-2@0x2c.org>
 <20180725200728.11835-2-2@0x2c.org>
 <CABBYNZLDY1g6HuOfqpK=s_2chmCMioDqCP0t8y99+9qhm_iY=A@mail.gmail.com>
From: Simon Schubert <2@0x2c.org>
Message-ID: <e9130bed-dee6-29f3-313e-987c2e5f6c63@0x2c.org>
Date: Thu, 26 Jul 2018 19:50:04 -0400
MIME-Version: 1.0
In-Reply-To: <CABBYNZLDY1g6HuOfqpK=s_2chmCMioDqCP0t8y99+9qhm_iY=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2018-07-26 04:40, Luiz Augusto von Dentz wrote:
> There is a task to convert bt_hog instance to use bt_gatt_client
> instead of GAttrib, that would fix this problem since
> bt_gatt_client_register_notify always write to the CCC for the first
> subscription.

Do you have a link?  Given that this present patch is much less involved
than rewriting bt_hog to use bt_gatt_client, I'd prefer to process this
patch first before getting into larger rewrites.

cheers
  simon

