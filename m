Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 0/3] HOGP fixes and update of test results
Date: Thu, 26 Feb 2015 12:51:08 +0100
Message-ID: <2917626.daz8GJBBb1@uw000953>
In-Reply-To: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 25 of February 2015 13:22:08 Mariusz Skamra wrote:
>   I deleted most of the code related to finding include services. This was only used
> in situation when HID service as primary service was not found. However according to
> SPEC HID device shall implement HID service as primary. Further HOG is called
> from hidhost's hog_conn_cb when HID service was found and connection was established using LE.
> Now searching for include services is performed because TC_HGDR_RH_BV_01_I requires that.
> Finding battery services is performed like before, during primary services discovery.
> Compared to v3 I used queue instead of GSList for bas.
> 
>   Add a queue of battery services because according to HOGP SPEC there could be more
> than one battery services like in TC_HGDC_HH_BV_14_I where there is only one HID service,
> and two battery services. So the first found bas was overwritten by the second one and
> after reconnection only one bas was attached.
> 
>   For test purposes requiring read of battery level read_value_cb was added.
> 
> Mariusz Skamra (3):
>   android/bas: Read battery level characteristic
>   android/hog: Fix find included battery services
>   android/pts: Update test results for HOGP
> 
>  android/bas.c        | 13 ++++++--
>  android/hog.c        | 84 +++++++++++++++++-----------------------------------
>  android/pts-hogp.txt |  6 ++--
>  3 files changed, 41 insertions(+), 62 deletions(-)
> 

All patches applied (after fixing some minor style issues), thanks. 

-- 
Best regards, 
Szymon Janc
