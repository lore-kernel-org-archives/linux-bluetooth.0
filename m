Return-Path: <SRS0=rPQ+=Z6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E3C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FB620700
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 08:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfLHIfG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Dec 2019 03:35:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56593 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHIfF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Dec 2019 03:35:05 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 86266CED0A;
        Sun,  8 Dec 2019 09:44:14 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [RFC BlueZ] Adding support for blocking keys and mgmt tests.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_Xg4sEYQdNEQp9_AtyPLk8M5iOuLB3MMVLLTbcweCZ0gw@mail.gmail.com>
Date:   Sun, 8 Dec 2019 09:35:03 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C74B4724-16C8-4DA9-908F-3321A9B2378C@holtmann.org>
References: <20191204013306.29935-1-alainm@chromium.org>
 <D5E83A6A-608A-461D-8C8F-50C7A6F79C1B@holtmann.org>
 <CALWDO_Xg4sEYQdNEQp9_AtyPLk8M5iOuLB3MMVLLTbcweCZ0gw@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> Would love feedback on this.  Corresponding kernel change also sent for
>>> comments.
>>> 
>>> ---
>>> lib/mgmt.h       | 12 +++++++++
>>> src/adapter.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++----
>>> unit/test-mgmt.c | 33 ++++++++++++++++++++++++
>>> 3 files changed, 107 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/lib/mgmt.h b/lib/mgmt.h
>>> index 570dec997..fa50a3656 100644
>>> --- a/lib/mgmt.h
>>> +++ b/lib/mgmt.h
>>> @@ -583,6 +583,18 @@ struct mgmt_cp_set_phy_confguration {
>>>      uint32_t        selected_phys;
>>> } __packed;
>>> 
>>> +#define MGMT_OP_SET_BLOCKED_KEYS     0x0046
>>> +struct mgmt_blocked_key_info {
>>> +     uint8_t type;
>>> +     uint8_t val[16];
>>> +} __packed;
>>> +
>>> +struct mgmt_cp_set_blocked_keys {
>>> +     uint16_t key_count;
>>> +     struct mgmt_blocked_key_info keys[0];
>>> +} __packed;
>>> +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
>>> +
>>> 
>>> #define MGMT_EV_CMD_COMPLETE          0x0001
>>> struct mgmt_ev_cmd_complete {
>>> diff --git a/src/adapter.c b/src/adapter.c
>>> index cef25616f..1b451af30 100644
>>> --- a/src/adapter.c
>>> +++ b/src/adapter.c
>>> @@ -99,6 +99,19 @@
>>> #define DISTANCE_VAL_INVALID  0x7FFF
>>> #define PATHLOSS_MAX          137
>>> 
>>> +/**
>>> + * These are known security keys that have been compromised.
>>> + * If this grows or there are needs to be platform specific, it is
>>> + * conceivable that these could be read from a config file.
>>> +*/
>>> +static const struct mgmt_blocked_key_info blocked_keys [] = {
>>> +     // Google Titan Security Keys
>>> +     { 0x01 /* LTK */, {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
>>> +                                     0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
>>> +     { 0x02 /* IRK */, {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
>>> +                                     0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
>>> +};
>>> +
>>> static DBusConnection *dbus_conn = NULL;
>>> 
>>> static bool kernel_conn_control = false;
>>> @@ -8827,6 +8840,40 @@ failed:
>>>      btd_adapter_unref(adapter);
>>> }
>>> 
>>> +static void set_blocked_ltks_complete(uint8_t status, uint16_t length,
>>> +                                     const void *param, void *user_data)
>>> +{
>>> +     struct btd_adapter *adapter = user_data;
>>> +
>>> +     if (status != MGMT_STATUS_SUCCESS) {
>>> +             btd_error(adapter->dev_id,
>>> +                             "Failed to set blocked LTKs: %s (0x%02x)",
>>> +                             mgmt_errstr(status), status);
>>> +             return;
>>> +     }
>>> +
>>> +     DBG("Successfully set blocked keys for index %u", adapter->dev_id);
>>> +}
>>> +
>>> +static bool set_blocked_keys(uint16_t index, struct btd_adapter *adapter)
>>> +{
>>> +     uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
>>> +                                     sizeof(blocked_keys)] = { 0 };
>>> +     struct mgmt_cp_set_blocked_keys *cp =
>>> +                                     (struct mgmt_cp_set_blocked_keys *)buffer;
>>> +     int i;
>>> +
>>> +     cp->key_count = G_N_ELEMENTS(blocked_keys);
>>> +     for (i = 0; i < cp->key_count; ++i) {
>>> +             cp->keys[i].type = blocked_keys[i].type;
>>> +             memcpy(cp->keys[i].val, blocked_keys[i].val, sizeof(cp->keys[i].val));
>>> +     }
>>> +
>>> +     return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, index,
>>> +                                     sizeof(buffer), buffer, read_info_complete, adapter, NULL);
>> 
>> wrong callback here.
> [alain] Oups, indeed, nice catch. Fixed.
>> 
>>> +}
>>> +
>>> +
>>> static void index_added(uint16_t index, uint16_t length, const void *param,
>>>                                                      void *user_data)
>>> {
>>> @@ -8861,15 +8908,25 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
>>>       */
>>>      adapter_list = g_list_append(adapter_list, adapter);
>>> 
>>> -     DBG("sending read info command for index %u", index);
>>> +     DBG("Setting blocked keys for index %u", index);
>>> +     if (!set_blocked_keys(index, adapter)){
>>> +             btd_error(adapter->dev_id,
>>> +                     "Failed to set blocked keys for index %u", index);
>>> +             // TODO: Until the MGMT is ported to all kernels, this is best effort.
>>> +     }
>> 
>> Just check if the command is supported. We have a list of supported commands.
> [alain] Thanks, I couldn't find that originally, but found a similar
> check for MGMT_OP_ADD_DEVICE now.
> 
>>> 
>>> -     if (mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
>>> -                                     read_info_complete, adapter, NULL) > 0)
>>> -             return;
>>> +     DBG("sending read info command for index %u", index);
>>> 
>>> -     btd_error(adapter->dev_id,
>>> +     if (!mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
>>> +                                     read_info_complete, adapter, NULL) > 0) {
>>> +             btd_error(adapter->dev_id,
>>>                      "Failed to read controller info for index %u", index);
>>> +                     goto unload;
>>> +     }
>>> +
>>> +     return;
>> 
>> We need to keep the read info the first command. The blocked keys setting should happen either just before loading the keys or right after.
> [alain] My logic was to actually set the block before the other modes
> are set in read_info_complete. I moved it in the next version, please
> let me know if that makes more sense to you.

it is fine to do this as the first command, but it needs to happen after read info. Also mgmt_send should nicely queue commands.

>> 
>>> 
>>> +unload:
>>>      adapter_list = g_list_remove(adapter_list, adapter);
>>> 
>>>      btd_adapter_unref(adapter);
>>> diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
>>> index c67678b9a..d73c03f61 100644
>>> --- a/unit/test-mgmt.c
>>> +++ b/unit/test-mgmt.c
>>> @@ -256,6 +256,33 @@ static const struct command_test_data command_test_3 = {
>>>      .rsp_status = MGMT_STATUS_INVALID_INDEX,
>>> };
>> 
>> Separate patch for the tests please and I think something went wrong in your email client or editor.
> [alain] Since the tests also depends on the mgmt.h changes, do you
> have a proposal on how best to organize these to avoid conflicts since
> they both depend on the mgmt.h changes?  I'm also not sure what you
> mean about the formatting, I used git send-email...

When I received them, you had single space and not tabs in it.

I am fine with you sending the mgmt-tester change as second patch when the support is added to bluetoothd. I am also fine if you just send a patch to add the mgmt.h changes. Your choice. I just don’t want to intermix patch for different subdirectories if it is not needed.

Regards

Marcel

