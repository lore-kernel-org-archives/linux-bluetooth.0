Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1658533.bR5FcK4maG@leonov>
References: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1658533.bR5FcK4maG@leonov>
Date: Thu, 11 Dec 2014 09:50:42 +0100
Message-ID: <CAMv5Gbf_+_5-TdgaUCntSCfBB9ifCdz89sWxEQUiL+RNtO=voA@mail.gmail.com>
Subject: Re: [PATCH 1/5] android/tester: Add missing AVRCP cb_table entries
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 10 December 2014 at 13:43, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Grzegorz,
>
> On Monday 08 of December 2014 11:35:04 Grzegorz Kolodziejczyk wrote:
>> cb_table should be filled simultaneously with expected bt_callbacks
>> enum. Without this, debug logs can cause errors.
>> ---
>>  android/tester-main.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/android/tester-main.c b/android/tester-main.c
>> index 33ef3ce..8f3bc3c 100644
>> --- a/android/tester-main.c
>> +++ b/android/tester-main.c
>> @@ -68,6 +68,14 @@ static struct {
>>       DBG_CB(CB_A2DP_CONN_STATE),
>>       DBG_CB(CB_A2DP_AUDIO_STATE),
>>
>> +     /* AVRCP */
>> +     DBG_CB(CB_AVRCP_PLAY_STATUS_REQ),
>> +     DBG_CB(CB_AVRCP_PLAY_STATUS_RSP),
>> +     DBG_CB(CB_AVRCP_REG_NOTIF_REQ),
>> +     DBG_CB(CB_AVRCP_REG_NOTIF_RSP),
>> +     DBG_CB(CB_AVRCP_GET_ATTR_REQ),
>> +     DBG_CB(CB_AVRCP_GET_ATTR_RSP),
>> +
>>       /* Gatt client */
>>       DBG_CB(CB_GATTC_REGISTER_CLIENT),
>>       DBG_CB(CB_GATTC_SCAN_RESULT),
>
> Patches 1-3 are now applied, thanks.
>
> Please remember that commit message should start from capital letter. I've
> fixed this for those patches.

I'll try to remember.
>
> --
> BR
> Szymon Janc

BR
Grzegorz Kolodziejczyk
