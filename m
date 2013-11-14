Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Nov 2013 17:28:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] android/a2dp: Add implementation of SDP record
Message-ID: <20131114152843.GA27181@x220.p-661hnu-f1>
References: <1384441288-6490-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384441288-6490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 14, 2013, Luiz Augusto von Dentz wrote:
> This adds the following record:
> 
> Service Name: Audio Source
> Service RecHandle: 0x10001
> Service Class ID List:
>   "Audio Source" (0x110a)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>     PSM: 25
>   "AVDTP" (0x0019)
>     uint16: 0x103
> Profile Descriptor List:
>   "Advanced Audio" (0x110d)
>     Version: 0x0103
> ---
> v2: Fix leaking record if bt_adapter_add_record fails
> 
>  android/a2dp.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)

Applied. Thanks.

Johan
