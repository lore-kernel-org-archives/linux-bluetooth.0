Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2142043.GSBL5JKzgO@athlon>
References: <1416912448-28177-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1416912448-28177-5-git-send-email-lukasz.rymanowski@tieto.com>
	<2142043.GSBL5JKzgO@athlon>
Date: Fri, 28 Nov 2014 09:56:12 +0100
Message-ID: <CAN_7+Ya7YW86PtCu4q8jqu+s+d_1V8XPb-XCzxEv14BWEQVnuQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] android/handsfree-client: Send AT+BCC to start codec negotiation
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 27, 2014 at 9:50 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Łukasz,
>
> On Tuesday 25 November 2014 11:47:27 Lukasz Rymanowski wrote:
>> With this patch we start codec negotation on audio connect if both sides
>> does support it.
>>
>> This patch also moves cmd_complete_cb and codec_negotiation_supported
>> functions up in the file
>> ---
>>  android/handsfree-client.c | 107
>> +++++++++++++++++++++++---------------------- 1 file changed, 54
>> insertions(+), 53 deletions(-)
>>
>> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
>> index 4118b7e..d942a21 100644
>> --- a/android/handsfree-client.c
>> +++ b/android/handsfree-client.c
>> @@ -292,11 +292,63 @@ done:
>>                       HAL_OP_HF_CLIENT_DISCONNECT, status);
>>  }
>>
>> +static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
>> +                                                     void *user_data)
>> +{
>> +     struct hal_ev_hf_client_command_complete ev;
>> +
>> +     DBG("");
>> +     memset(&ev, 0, sizeof(ev));
>> +
>> +     switch (result) {
>> +     case HFP_RESULT_OK:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_OK;
>> +             break;
>> +     case HFP_RESULT_NO_CARRIER:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_NO_CARRIER;
>> +             break;
>> +     case HFP_RESULT_ERROR:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
>> +             break;
>> +     case HFP_RESULT_BUSY:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BUSY;
>> +             break;
>> +     case HFP_RESULT_NO_ANSWER:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_NO_ANSWER;
>> +             break;
>> +     case HFP_RESULT_DELAYED:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_DELAYED;
>> +             break;
>> +     case HFP_RESULT_BLACKLISTED:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BACKLISTED;
>> +             break;
>> +     case HFP_RESULT_CME_ERROR:
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_CME;
>> +             ev.cme = cme_err;
>> +             break;
>> +     default:
>> +             error("hf-client: Unknown error code %d", result);
>> +             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
>> +             break;
>> +     }
>> +
>> +     ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
>> +                     HAL_EV_CLIENT_COMMAND_COMPLETE, sizeof(ev), &ev);
>> +}
>> +
>> +static bool codec_negotiation_supported(struct device *dev)
>> +{
>> +     return (dev->features & HFP_AG_FEAT_CODEC) &&
>> +                     (hfp_hf_features & HFP_HF_FEAT_CODEC);
>> +}
>> +
>>  static bool connect_sco(struct device *dev)
>>  {
>> -     /* TODO: handle codec negotiation */
>> +     if (codec_negotiation_supported(dev))
>> +             return hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
>> +                                                             "AT+BCC");
>
> This looks strange. It would result in calling command complete callback
> without pending AT command from framework. Shouldn't this be dedicated cb that
> would handle (unlikely, but still..) error and set audio state back to
> disconnected?

You are right. Somehow I missed that.

Also we should handle case when AG replied OK but didn't open
> SCO eg with timeout. This is to avoid getting stuck in connecting audio state.

I wouldn't be paranoid on that unless you have seen such IOT issue? If
not I would not complicate here.

\Lukasz
>
>>
>> -     return bt_sco_connect(sco, &dev->bdaddr, 0);
>> +     return bt_sco_connect(sco, &dev->bdaddr, BT_VOICE_CVSD_16BIT);
>>  }
>>
>>  static void set_audio_state(struct device *dev, uint8_t state)
>> @@ -377,51 +429,6 @@ done:
>>                               HAL_OP_HF_CLIENT_DISCONNECT_AUDIO, status);
>>  }
>>
>> -static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
>> -                                                     void *user_data)
>> -{
>> -     struct hal_ev_hf_client_command_complete ev;
>> -
>> -     DBG("");
>> -
>> -     memset(&ev, 0, sizeof(ev));
>> -
>> -     switch (result) {
>> -     case HFP_RESULT_OK:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_OK;
>> -             break;
>> -     case HFP_RESULT_NO_CARRIER:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_NO_CARRIER;
>> -             break;
>> -     case HFP_RESULT_ERROR:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
>> -             break;
>> -     case HFP_RESULT_BUSY:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BUSY;
>> -             break;
>> -     case HFP_RESULT_NO_ANSWER:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_NO_ANSWER;
>> -             break;
>> -     case HFP_RESULT_DELAYED:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_DELAYED;
>> -             break;
>> -     case HFP_RESULT_BLACKLISTED:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BACKLISTED;
>> -             break;
>> -     case HFP_RESULT_CME_ERROR:
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_CME;
>> -             ev.cme = cme_err;
>> -             break;
>> -     default:
>> -             error("hf-client: Unknown error code %d", result);
>> -             ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
>> -             break;
>> -     }
>> -
>> -     ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
>> -                     HAL_EV_CLIENT_COMMAND_COMPLETE, sizeof(ev), &ev);
>> -}
>> -
>>  static void handle_start_vr(const void *buf, uint16_t len)
>>  {
>>       struct device *dev;
>> @@ -1653,12 +1660,6 @@ static void slc_brsf_cb(struct hfp_context *context,
>> void *user_data) dev->features = feat;
>>  }
>>
>> -static bool codec_negotiation_supported(struct device *dev)
>> -{
>> -     return (dev->features & HFP_AG_FEAT_CODEC) &&
>> -                     (hfp_hf_features & HFP_HF_FEAT_CODEC);
>> -}
>> -
>>  static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err,
>>                                                       void *user_data)
>>  {
>
> --
> Szymon K. Janc
> szymon.janc@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
