Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABL=VJNsGRmz1wvhFxn79_zesYjo3oD5tdrXEy_9vqB9Q7Bd_g@mail.gmail.com>
References: <CABL=VJNsGRmz1wvhFxn79_zesYjo3oD5tdrXEy_9vqB9Q7Bd_g@mail.gmail.com>
Date: Wed, 17 Sep 2014 23:11:18 +0530
Message-ID: <CABL=VJPbh=2qve9a=CUJfajSdHkAXGmkP1dG8x=DKcFy2y_iQw@mail.gmail.com>
Subject: Re: Missing of SCO packet indications
From: Vinod Rayapudi <vinodrayapudi@gmail.com>
To: linux-bluetooth@vger.kernel.org, autoanswer@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can anyone help on this issue.

Regards,
Vinod.

On Wed, Sep 17, 2014 at 8:10 PM, Vinod Rayapudi <vinodrayapudi@gmail.com> wrote:
> Hi All,
>
> I have an Issue w.r.t SCO packets.
>
> I have connected a phone which support both A2DP and Handsfree profiles.
> During call, I don't see any sco packet indication.
>
> I have added logs in Bluez- 'unix.c' file.
>
> From the logs I understood that, all SCO packet indications and
> initiations like BT_GET_CAPABILITIES ,BT_OPEN ,BT_SET_CONFIGURATION
> and BT_START_STREAM etc are triggered from client_cb() callback
> function.
> In this case, I don't see any such kind of packet transmission.
> How to correct this behavior ?
>
> If the phone has both active A2DP and Handsfree connections, then this
> issue occurs.
>
> Can anyone help me, how to correct this issue.
>
>
> Thanks & Regards,
> Vinod.
