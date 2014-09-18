Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <OF599C7E7B.0DAEF4D4-ON65257D56.0050A3C9-65257D56.0050B958@tcs.com>
References: <OF599C7E7B.0DAEF4D4-ON65257D56.0050A3C9-65257D56.0050B958@tcs.com>
Date: Thu, 18 Sep 2014 12:59:02 +0300
Message-ID: <CABBYNZJcxjrfV=cs7S-ZGnNSqUxRMD=dA-NfPupA8ZqKK4+RKQ@mail.gmail.com>
Subject: Re: Missing of SCO packet indications (i.e BT_GET_CAPABILITIES
 ,BT_OPEN ,BT_SET_CONFIGURATION and BT_START_STREAM ) during a phone call
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinod Rayapudi <vinod.rayapudi@tcs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	autoanswer@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 17, 2014 at 5:41 PM, Vinod Rayapudi <vinod.rayapudi@tcs.com> wrote:
> Hi All,
>
> I have an Issue w.r.t SCO packets.
>
> I have connected a phone which support both A2DP and Handsfree profiles.
> During call, I don't see any sco packet indication.
>
> I have added logs in Bluez- 'unix.c' file.
>
> From the logs I understood that, all SCO packet indications and initiations like BT_GET_CAPABILITIES ,BT_OPEN ,BT_SET_CONFIGURATION and BT_START_STREAM etc are triggered from client_cb() callback function.
> In this case, I don't see any such kind of packet transmission.
> How to correct this behavior ?
>
> If the phone has both active A2DP and Handsfree connections, then this issue occurs.
>
> Can anyone help me, how to correct this issue.

It sounds that you are talking about a very old BlueZ version that
used to have unix socket IPC, this is no longer supported so I suggest
you move to BlueZ 5 if you want some support from upstream.


-- 
Luiz Augusto von Dentz
