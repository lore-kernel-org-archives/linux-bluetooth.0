Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8991BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6590A2072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgFJQ7L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:59:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54762 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJQ7L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 12:59:11 -0400
Received: from [192.168.1.91] (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id EDAE8CECE8;
        Wed, 10 Jun 2020 19:08:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1 3/3] bluetooth: implement read/set default system
 parameters mgmt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_UynvNvTwh6mfsEFR+vEiLC3zCMbRdEpB+Hm9C+5RTGDA@mail.gmail.com>
Date:   Wed, 10 Jun 2020 18:58:38 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E2F963C9-6AD1-43B1-A342-BDB8BE923130@holtmann.org>
References: <20200609140351.153833-1-alainm@chromium.org>
 <20200609140351.153833-4-alainm@chromium.org>
 <4CD6CBD8-0EC4-47F1-8B05-5AC8BB78B97A@holtmann.org>
 <CALWDO_UynvNvTwh6mfsEFR+vEiLC3zCMbRdEpB+Hm9C+5RTGDA@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> This patch implements the read default system parameters and the set
>>> default system parameters mgmt commands.
>>> 
>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>> ---
>>> 
>>> net/bluetooth/mgmt.c | 429 +++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 429 insertions(+)
>> 
>> I have the feeling that we want to create a net/bluetooth/mgmt_config.c to move all the configuration parameters parsing and handling into a separate. I have the feeling that otherwise mgmt.c will grow quickly.
> ok, I'll send out a v2 that split it out in mgmt_config.c/h
> 
>> 
>>> 
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index 9e8a3cccc6ca..98a4193c8e66 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -111,6 +111,8 @@ static const u16 mgmt_commands[] = {
>>>      MGMT_OP_READ_SECURITY_INFO,
>>>      MGMT_OP_READ_EXP_FEATURES_INFO,
>>>      MGMT_OP_SET_EXP_FEATURE,
>>> +     MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS,
>>> +     MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
>>> };
>> 
>> Please also add the OP_READ_ command to mgmt_untrusted_commands array.
> ACK.
>> 
>>> static const u16 mgmt_events[] = {
>>> @@ -3849,6 +3851,431 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
>>>                             MGMT_STATUS_NOT_SUPPORTED);
>>> }
>>> 
>>> +static int read_default_system_parameters(struct sock *sk, struct hci_dev *hdev,
>>> +                                       void *data, u16 data_len)
>>> +{
>>> +     struct {
>>> +             struct mgmt_system_parameter_tlv entry;
>>> +             union {
>>> +                     /* This is a simplification for now since all values
>>> +                      * are 16 bits.  In the future, this code may need
>>> +                      * refactoring to account for variable length values
>>> +                      * and properly calculate the required buffer size.
>>> +                      */
>>> +                     u16 value;
>>> +             };
>>> +     } __packed params[] = {
>>> +             /* Please see mgmt-api.txt for documentation of these values */
>>> +             {
>>> +                     { 0x0000, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_page_scan_type) }
>>> +             },
>>> +             {
>>> +                     { 0x0001, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_page_scan_int) }
>>> +             },
>>> +             {
>>> +                     { 0x0002, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_page_scan_window) }
>>> +             },
>>> +             {
>>> +                     { 0x0003, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_inq_scan_type) }
>>> +             },
>>> +             {
>>> +                     { 0x0004, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_inq_scan_int) }
>>> +             },
>>> +             {
>>> +                     { 0x0005, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_inq_scan_window) }
>>> +             },
>>> +             {
>>> +                     { 0x0006, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_br_lsto) }
>>> +             },
>>> +             {
>>> +                     { 0x0007, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_page_timeout) }
>>> +             },
>>> +             {
>>> +                     { 0x0008, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->sniff_min_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x0009, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->sniff_max_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x000a, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_adv_min_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x000b, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_adv_max_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x000c, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->def_multi_adv_rotation_duration) }
>>> +             },
>>> +             {
>>> +                     { 0x000d, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x000e, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_window) }
>>> +             },
>>> +             {
>>> +                     { 0x000f, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_int_suspend) }
>>> +             },
>>> +             {
>>> +                     { 0x0010, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_window_suspend) }
>>> +             },
>>> +             {
>>> +                     { 0x0011, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_int_discovery) }
>>> +             },
>>> +             {
>>> +                     { 0x0012, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_window_discovery) }
>>> +             },
>>> +             {
>>> +                     { 0x0013, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_int_adv_monitor) }
>>> +             },
>>> +             {
>>> +                     { 0x0014, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_window_adv_monitor) }
>>> +             },
>>> +             {
>>> +                     { 0x0015, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_int_connect) }
>>> +             },
>>> +             {
>>> +                     { 0x0016, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_scan_window_connect) }
>>> +             },
>>> +             {
>>> +                     { 0x0017, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_conn_min_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x0018, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_conn_max_interval) }
>>> +             },
>>> +             {
>>> +                     { 0x0019, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_conn_latency) }
>>> +             },
>>> +             {
>>> +                     { 0x001a, sizeof(__u16) },
>>> +                     { cpu_to_le16(hdev->le_supv_timeout) }
>>> +             },
>> 
>> This is creative and I like it. However I would take it one step further. Define a macro similar USB_DEVICE etc. so you get a simpler table.
>> 
>>        { HDEV_PARAM(0x0018, le_conn_max_interval) },
>>        { HDEV_PARAM(0x0019, le_conn_latency) },
>>        { }
>> 
>> 
> Ok, that makes sense, I'll think of something for v2.
> 
>>> +     };
>>> +     struct mgmt_rp_read_default_system_parameters *rp = (void *)params;
>>> +
>>> +     bt_dev_dbg(hdev, "sock %p", sk);
>>> +
>>> +     return mgmt_cmd_complete(sk, hdev->id,
>>> +                              MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS,
>>> +                              0, rp, sizeof(params));
>> 
>> Please introduce HCI_MGMT_SYSTEM_CONFIG_EVENTS and send them out as described in mgmt-api.txt
> Looks like you added this after my original proposal to mgmt-api.txt.
> I'd like to propose this is also implemented in a separate patch.

feel free to add it as a separate patch. See the Experimental Feature commands + event on how this could be done.

Regards

Marcel

