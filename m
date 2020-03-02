Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EFCC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DA21556
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCBWVK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:21:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33061 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBWVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 17:21:09 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 84C0ACECC4;
        Mon,  2 Mar 2020 23:30:35 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] bluetooth: Enable erroneous data reporting if wbs is
 supported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_X2U0vekAp5+y_hsUefQaK9UzXr2sM=nvSV_MZtuD0=Wg@mail.gmail.com>
Date:   Mon, 2 Mar 2020 23:21:08 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0520C31E-B9D9-42FF-83A4-D6BD2A6C3B55@holtmann.org>
References: <20200228163922.87031-1-alainm@chromium.org>
 <6257E23A-64BD-4073-AED6-4BB7155B5A89@holtmann.org>
 <CALWDO_UDy+0uywAVJSa75sGG+hgK0aYhAZH-MUJVv=ZYn-yBDg@mail.gmail.com>
 <8CC46B7A-0EE5-4482-B9AB-B72B8B381F7F@holtmann.org>
 <CALWDO_X2U0vekAp5+y_hsUefQaK9UzXr2sM=nvSV_MZtuD0=Wg@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>>>> This change will enable erroneous data reporting if wide band speech is
>>>>> supported by the controller as indicated by the
>>>>> HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED quirk.
>>>>> 
>>>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>>>> ---
>>>>> 
>>>>> include/net/bluetooth/hci.h      | 13 ++++++++
>>>>> include/net/bluetooth/hci_core.h |  1 +
>>>>> net/bluetooth/hci_core.c         |  3 ++
>>>>> net/bluetooth/hci_event.c        | 55 ++++++++++++++++++++++++++++++++
>>>>> net/bluetooth/mgmt.c             |  3 +-
>>>>> 5 files changed, 74 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>>> index 0b3ebd35681d..aa1654f9b579 100644
>>>>> --- a/include/net/bluetooth/hci.h
>>>>> +++ b/include/net/bluetooth/hci.h
>>>>> @@ -1095,6 +1095,19 @@ struct hci_rp_read_inq_rsp_tx_power {
>>>>>     __s8     tx_power;
>>>>> } __packed;
>>>>> 
>>>>> +#define HCI_OP_READ_DEF_ERR_DATA_REPORTING   0x0c5a
>>>>> +     #define ERR_DATA_REPORTING_DISABLED     0x00
>>>>> +     #define ERR_DATA_REPORTING_ENABLED      0x01
>>>> 
>>>> are these two defines make the code really more readable. Or is 0x00 and 0x01 obvious enough?
>>> I generally dislike magic numbers.  There are a number of precedent
>>> set in the core specification where 0 and 1 becomes 0, 1 and many
>>> other options (like scan policies).  Having the values clearly spelled
>>> out makes more sense to me, but I'm happy to follow your guidance
>>> here.
>> 
>> we don’t have a clear cut style in this regard. In a lot of cases we have done 0x00 and 0x01, or adding a comment to make sure the reader knows what is going on. Or use a descriptive constant.
>> 
>> I look at it from a code readability point of view. If 6 month from know, the magic number is clear, then it sometimes makes sense to use it to help keep the line length short and avoid to many line breaks. So it is a judgement call.
> Since the constant doesn't make the code difficult to read, am I ok to
> assume it's ok to use a constant here? :)

then go for it.

> 
>> 
>>>>> +struct hci_rp_read_def_err_data_reporting {
>>>>> +     __u8     status;
>>>>> +     __u8     err_data_reporting;
>>>> 
>>> 
>>>> Just call this field enabled.
>>> This is using the field value as defined in the Core Spec.  Happy to
>>> change it if you feel strongly about this.
>> 
>> The Core spec is not consistent either with its field names. But lets keep err_data_reporting then.
> You are right, should we try to be consistent with the core spec in
> any case? :). I dream of a day where these sort of struct will be
> generated by a code generator.
> 
>> 
>>> 
>>>> 
>>>>> +} __packed;
>>>>> +
>>>>> +#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING  0x0c5b
>>>>> +struct hci_cp_write_def_err_data_reporting {
>>>>> +     __u8     err_data_reporting;
>>>> 
>>>> Same as above, just call it enabled.
>>> Same as above.
>>> 
>>> 
>>>> 
>>>>> +} __packed;
>>>>> +
>>>>> #define HCI_OP_SET_EVENT_MASK_PAGE_2  0x0c63
>>>>> 
>>>>> #define HCI_OP_READ_LOCATION_DATA     0x0c64
>>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>>>> index dcc0dc6e2624..c498ac113930 100644
>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>> @@ -260,6 +260,7 @@ struct hci_dev {
>>>>>     __u8            stored_num_keys;
>>>>>     __u8            io_capability;
>>>>>     __s8            inq_tx_power;
>>>>> +     __u8            err_data_reporting;
>>>>>     __u16           page_scan_interval;
>>>>>     __u16           page_scan_window;
>>>>>     __u8            page_scan_type;
>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>> index 4e6d61a95b20..3becdce5457a 100644
>>>>> --- a/net/bluetooth/hci_core.c
>>>>> +++ b/net/bluetooth/hci_core.c
>>>>> @@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>>>>>     if (hdev->commands[8] & 0x01)
>>>>>             hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
>>>>> 
>>>>> +     if (hdev->commands[18] & 0x02)
>>>>> +             hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
>>>>> +
>>>>>     /* Some older Broadcom based Bluetooth 1.2 controllers do not
>>>>>      * support the Read Page Scan Type command. Check support for
>>>>>      * this command in the bit mask of supported commands.
>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>>> index 591e7477e925..21fd1ebd9c6a 100644
>>>>> --- a/net/bluetooth/hci_event.c
>>>>> +++ b/net/bluetooth/hci_event.c
>>>>> @@ -901,6 +901,53 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
>>>>>     hdev->inq_tx_power = rp->tx_power;
>>>>> }
>>>>> 
>>>>> +static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
>>>>> +                                            struct sk_buff *skb)
>>>>> +{
>>>>> +     struct hci_rp_read_def_err_data_reporting *rp = (void *)skb->data;
>>>>> +
>>>>> +     BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
>>>>> +
>>>>> +     if (rp->status)
>>>>> +             return;
>>>>> +
>>>>> +     hdev->err_data_reporting = rp->err_data_reporting;
>>>>> +
>>>>> +     /* If the controller supports wide_band_speech, enable erroneous
>>>>> +      * data reporting.
>>>>> +      */
>>>>> +     if (hdev->err_data_reporting != ERR_DATA_REPORTING_ENABLED &&
>>>>> +         (hdev->commands[18] & 0x04) &&
>>>>> +         test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks)) {
>>>>> +             struct hci_request req;
>>>>> +             struct hci_cp_write_def_err_data_reporting cp = {};
>>>>> +
>>>>> +             hci_req_init(&req, hdev);
>>>>> +             cp.err_data_reporting = ERR_DATA_REPORTING_ENABLED;
>>>>> +
>>>>> +             hci_req_add(&req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
>>>>> +                         sizeof(cp), &cp);
>>>>> +     }
>>>> 
>>>> Please don’t do this here. These event callbacks are just here to store the information in hci_dev for simple read/write commands like this one.
>>> Any recommendations as to where to do this after the read has completed?
>> 
>> Do it in one of the init stages.
> ok.
> 
>> 
>>>>> +}
>>>>> +
>>>>> +static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
>>>>> +                                             struct sk_buff *skb)
>>>>> +{
>>>>> +     __u8 status = *((__u8 *)skb->data);
>>>>> +     struct hci_cp_write_def_err_data_reporting *cp;
>>>>> +
>>>>> +     BT_DBG("%s status 0x%2.2x", hdev->name, status);
>>>>> +
>>>>> +     if (status)
>>>>> +             return;
>>>>> +
>>>>> +     cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING);
>>>>> +     if (!cp)
>>>>> +             return;
>>>>> +
>>>>> +     hdev->err_data_reporting = cp->err_data_reporting;
>>>>> +}
>>>>> +
>>>>> static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
>>>>> {
>>>>>     struct hci_rp_pin_code_reply *rp = (void *) skb->data;
>>>>> @@ -3302,6 +3349,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>>>>>             hci_cc_read_inq_rsp_tx_power(hdev, skb);
>>>>>             break;
>>>>> 
>>>>> +     case HCI_OP_READ_DEF_ERR_DATA_REPORTING:
>>>>> +             hci_cc_read_def_err_data_reporting(hdev, skb);
>>>>> +             break;
>>>>> +
>>>>> +     case HCI_OP_WRITE_DEF_ERR_DATA_REPORTING:
>>>>> +             hci_cc_write_def_err_data_reporting(hdev, skb);
>>>>> +             break;
>>>>> +
>>>>>     case HCI_OP_PIN_CODE_REPLY:
>>>>>             hci_cc_pin_code_reply(hdev, skb);
>>>>>             break;
>>>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>>>> index 1002c657768a..8827d942b2d9 100644
>>>>> --- a/net/bluetooth/mgmt.c
>>>>> +++ b/net/bluetooth/mgmt.c
>>>>> @@ -764,7 +764,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>>>>>                     settings |= MGMT_SETTING_SECURE_CONN;
>>>>> 
>>>>>             if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
>>>>> -                          &hdev->quirks))
>>>>> +                          &hdev->quirks) &&
>>>>> +                 hdev->err_data_reporting == ERR_DATA_REPORTING_ENABLED)
>>>>>                     settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
>>>> 
>>>> This change is wrong. We always want to have it listed as a supported setting. That setting should never change. For the current settings, you want the Wideband speech indication to change. And lets really tie this together with a Set Wideband Speech mgmt command so you can toggle this.
>>>> 
>>>> It is good to have an option to enable/disable it. We do the same for SSP, Secure Connections and other options. Even if bluetoothd will just enable them by default if available, for qualification purposes it has been crucial that we can select different settings at runtime.
>>> I could be convinced that there is value in enabling/disabling
>>> erroneous data reporting, I'm not so sure there is value in being able
>>> to toggle what is supposed to represent the controller's capability to
>>> do it.  Please remember that wide_band_speech in this context is a
>>> capability, not a setting per say while erroneous data reporting is a
>>> setting that could arguably be enabled/disabled.  As previously
>>> discussed you had indicated a preference for tying the two together,
>>> but I'd argue these are separate things.  Perhaps we should go back to
>>> my original proposal to treat them separately?
>>> (https://patchwork.kernel.org/patch/11400785/)
>> 
>> So I prefer to introduce a MGMT_SETTING_WIDEBAND_SPEECH and Set Wideband Speech command to toggle the setting on and off. I really prefer that we can enable/disable this setting. For me it is also important that we have consistency throughout the API as much as possible. As mentioned, this is the same as SSP, SC, BR/EDR, LE etc. setting that configure core features of the hardware. The mgmt is meant to signal that some feature is supported and then allow enabling it if bluetoothd chooses to do so. That bluetoothd might enable it all the time is by design.
>> 
>> And I am almost certain that for qualification purposes, you thank me later that you could easily disable Wideband speech by just calling btmgmt wbs off.
> I'm not clear what it would mean at this layer to disable wideband
> speech.  It would effectively be a no-op unless you want to tie this
> setting to erroneous data reporting.  Using or not using wideband
> speech is then a profile level decision (codec negotiation etc, so I
> don't see any point in having an enable/disable interface here).  I do
> however see the value in a enable/disable MGMT interface for erroneous
> data reporting which is a separate thing.

I want to keep Wideband speech setting enable/disable together with erroneous data reporting. I really think it will come in handy that we can adjust this setting easily via btmgmt. I can also work on the patch for this if you run out of time since it is getting a bit more complex.

Regards

Marcel


