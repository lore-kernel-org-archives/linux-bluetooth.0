Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez/android
Date: Mon, 15 Jun 2015 14:12:47 +0200
Message-ID: <4720167.a4B9p9nNG6@leonov>
In-Reply-To: <CAKafyqq_RN9syQgA3o8z0Wx_DN8O83i4A2S5Ns8N4-SWNyE4Mg@mail.gmail.com>
References: <CAKafyqq_RN9syQgA3o8z0Wx_DN8O83i4A2S5Ns8N4-SWNyE4Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Monday 15 of June 2015 17:06:41 Prabhu Chawandi wrote:
>  This is with respect to HFP profile.
> 
> While I pressed the Button on my HF device, service level connection
> is happening - BTHF_STATE_CONNECTED is coming.
> 
> But next callbacks are not coming on pressing of buttons - like voice
> recognition.
> 
> Can any body help me

HFP is a bit special since BfA provides only part of the implementation and 
rest is implemented in Android Framework. When HF device is connected SLC 
creation must happen. Most likely your HF device is sending some AT commands 
and you must response to those as per HFP specification. Only when all 
required SLC AT commands are handled state will be set to 
BTHF_STATE_SCL_CONNECTED. This is normally handled by Android Framework but if 
you are using haltest you must handle those on your own.

For details on how to setup SLC I recommend HFP specification lecture.

-- 
BR
Szymon Janc
