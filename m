Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171119095806.Horde.RoDJIijadVKVaiRfz_99dX8@www.vfemail.net>
References: <20171119095806.Horde.RoDJIijadVKVaiRfz_99dX8@www.vfemail.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Nov 2017 11:07:43 +0200
Message-ID: <CABBYNZK-eZX3DnAZRz_EeMedmgNWFGH_mAzLkDYDRm97UAL16A@mail.gmail.com>
Subject: Re: [BlueZ] bluetoothctl Tab-Completion
To: manday@openmail.cc
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cedric,

On Sun, Nov 19, 2017 at 11:58 AM,  <manday@openmail.cc> wrote:
> Hello,
>
> I would like to point out that the helpful "Tab-Completion" feature in
> bluetoothctl (with readline support, I suppose) misbehaves for the "pair"
> command, where it suggests either "on" or "off" as argument, but not a
> device.
>
> Also, I have noticed that sometimes Tab-Completion drops dead alltogether,
> though I couldn't see a reproducible pattern.

Have you tried with latest upstream, I did fix a few things related to
tab-completion, previously it would not ignore leading spaces but now
that should work. I will check what is going one with pair, perhaps
the wrong completion callback is being used.
