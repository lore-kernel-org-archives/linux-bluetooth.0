Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 00/16] android/tester: Unifying the way PDU is handled
Date: Tue, 30 Sep 2014 11:44:28 +0200
Message-ID: <1896433.RfLfb6axKr@uw000953>
In-Reply-To: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 26 of September 2014 08:31:01 Jakub Tyszkowski wrote:
> This patchset makes all testers use common struct for using raw data (PDUs).
> Also some helpers were added for pdu matching and sending.
> 
> v2 changes:
>   * added generic hook and connect callback in tester-main for handling simple
>     cases when only pdu exchange is needed on given channel
> 
> Jakub Tyszkowski (16):
>   android/tester: Expose gatt-tester's pdu definition to other testers
>   android/tester: Make AVRCP tests use generic pdu struct
>   android/tester: Make A2DP tests use generic pdu struct
>   android/tester: Make GATT tests use generic pdu struct
>   android/tester: Make HidHost tests use generic pdu struct
>   android/tester: Make PAN tests use generic pdu struct
>   android/tester: Make HDP tests use generic pdu struct
>   android/tester: Expose pdu_set structure so it can be reused
>   android/tester: Add generic hook to handle pdu exchange
>   android/tester: Make A2DP use pdu exchange mechanism
>   android/tester: Make AVRCP tests use generic pdu exchange mechanism
>   android/tester: Make GATT use generic cid_data
>   android/tester: Make HDP tests use generic PDU exchange mechanism
>   android/tester: Make HIDHost tests use generic PDU exchange mechanism
>   android/tester: Make PAN use generic PDU exchange mechanism
>   android-tester: Use generic connect callback for simple cases
> 
>  android/tester-a2dp.c    | 109 +++++++--------------
>  android/tester-avrcp.c   | 181 +++++++++++++----------------------
>  android/tester-gatt.c    |  72 +++++---------
>  android/tester-hdp.c     | 200 ++++++++++++++++----------------------
>  android/tester-hidhost.c | 243 +++++++++++++++++++++--------------------------
>  android/tester-main.c    |  58 +++++++++++
>  android/tester-main.h    |  32 +++++++
>  android/tester-pan.c     |  45 +++------
>  8 files changed, 413 insertions(+), 527 deletions(-)
> 

This looks quite good to me but needs to be rebased.

-- 
Best regards, 
Szymon Janc
