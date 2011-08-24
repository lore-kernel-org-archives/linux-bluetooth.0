Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFpRq5k1425=uttf1f-a3996qWmMyEh-AJhXL4SeGXW_QYC25A@mail.gmail.com>
References: <CAFpRq5k1425=uttf1f-a3996qWmMyEh-AJhXL4SeGXW_QYC25A@mail.gmail.com>
Date: Wed, 24 Aug 2011 09:37:52 -0300
Message-ID: <CAKT1EBdVf6pchy4sAb2qrT_FWqD5fxDNC0tsHzmFKXP6jDjpxA@mail.gmail.com>
Subject: Re: L2CAP socket binding fails with gatttool over LE
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Dmitry Shipilov <dmitry.shipilov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

On Tue, Aug 23, 2011 at 5:17 PM, Dmitry Shipilov
<dmitry.shipilov@gmail.com> wrote:
> Hello!
>
> I was trying to use gatttool from the latest BlueZ 4.96 over LE link,
> but it immediately fails with error message:
>
> $ sudo gatttool --adapter=hci0 --device=<BD addr> --primary
> l2cap_bind: Invalid argument (22)

It looks that you don't have a proper kernel.

I sent an email last week containing links for the kernel & BlueZ.
Search for: "Current status on BLE development"

BR,
Claudio
