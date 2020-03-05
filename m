Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9FCC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342632073D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 15:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCEPYF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:24:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35523 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgCEPYF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 10:24:05 -0500
Received: from [172.20.10.2] (x59cc89fd.dyn.telefonica.de [89.204.137.253])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1871ECECED;
        Thu,  5 Mar 2020 16:33:31 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v3] bluetooth: Enable erroneous data reporting if wbs is
 supported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_Wp2CGYzqSwi9B8ZTPus_a5s7c0eF-DY6z=uyQJWsqfdQ@mail.gmail.com>
Date:   Thu, 5 Mar 2020 16:24:02 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <96B49122-2015-47F2-98DD-DD3F6712282E@holtmann.org>
References: <20200304172207.58963-1-alainm@chromium.org>
 <952F72CF-2414-4940-B5CE-D33981E56B90@holtmann.org>
 <CALWDO_Wp2CGYzqSwi9B8ZTPus_a5s7c0eF-DY6z=uyQJWsqfdQ@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> This change intruduces a wide band speech setting which allows higher
>>> level clients to query the local controller support for wide band speech
>>> as well as set the setting state when the radio is powered off.
>>> Internally, this setting controls if erroneous data reporting is enabled
>>> on the controller.
>>> 
>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>> ---
>>> 
>>> include/net/bluetooth/hci.h      | 14 ++++++++
>>> include/net/bluetooth/hci_core.h |  1 +
>>> include/net/bluetooth/mgmt.h     |  2 ++
>>> net/bluetooth/hci_core.c         | 21 +++++++++++
>>> net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++
>>> net/bluetooth/mgmt.c             | 62 ++++++++++++++++++++++++++++++++
>>> 6 files changed, 139 insertions(+)
>>> 
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 0b3ebd35681d..d66648e9ff13 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -286,6 +286,7 @@ enum {
>>>      HCI_FAST_CONNECTABLE,
>>>      HCI_BREDR_ENABLED,
>>>      HCI_LE_SCAN_INTERRUPTED,
>>> +     HCI_WIDE_BAND_SPEECH_ENABLED,
>> 
>> lets use HCI_WIDEBAND_SPEECH_ENABLED. It might be just me, but when I look at WIDE_BAND compared to WIDEBAND, I prefer the latter.
> Ack.
>> 
>>> 
>>>      HCI_DUT_MODE,
>>>      HCI_VENDOR_DIAG,
>>> @@ -1095,6 +1096,19 @@ struct hci_rp_read_inq_rsp_tx_power {
>>>      __s8     tx_power;
>>> } __packed;
>>> 
>>> +#define HCI_OP_READ_DEF_ERR_DATA_REPORTING   0x0c5a
>>> +     #define ERR_DATA_REPORTING_DISABLED     0x00
>>> +     #define ERR_DATA_REPORTING_ENABLED      0x01
>>> +struct hci_rp_read_def_err_data_reporting {
>>> +     __u8     status;
>>> +     __u8     err_data_reporting;
>>> +} __packed;
>>> +
>>> +#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING  0x0c5b
>>> +struct hci_cp_write_def_err_data_reporting {
>>> +     __u8     err_data_reporting;
>>> +} __packed;
>>> +
>>> #define HCI_OP_SET_EVENT_MASK_PAGE_2  0x0c63
>>> 
>>> #define HCI_OP_READ_LOCATION_DATA     0x0c64
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index dcc0dc6e2624..c498ac113930 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -260,6 +260,7 @@ struct hci_dev {
>>>      __u8            stored_num_keys;
>>>      __u8            io_capability;
>>>      __s8            inq_tx_power;
>>> +     __u8            err_data_reporting;
>>>      __u16           page_scan_interval;
>>>      __u16           page_scan_window;
>>>      __u8            page_scan_type;
>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>>> index f69f88e8e109..b203df07e7fc 100644
>>> --- a/include/net/bluetooth/mgmt.h
>>> +++ b/include/net/bluetooth/mgmt.h
>>> @@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
>>> } __packed;
>>> #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
>>> 
>>> +#define MGMT_OP_SET_WIDE_BAND_SPEECH 0x0047
>>> +
>>> #define MGMT_EV_CMD_COMPLETE          0x0001
>>> struct mgmt_ev_cmd_complete {
>>>      __le16  opcode;
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 4e6d61a95b20..d526d7568396 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>>>      if (hdev->commands[8] & 0x01)
>>>              hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
>>> 
>>> +     if (hdev->commands[18] & 0x02)
>>> +             hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
>>> +
>>>      /* Some older Broadcom based Bluetooth 1.2 controllers do not
>>>       * support the Read Page Scan Type command. Check support for
>>>       * this command in the bit mask of supported commands.
>>> @@ -838,6 +841,24 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
>>>                          sizeof(support), &support);
>>>      }
>>> 
>>> +     /* Set erroneous data reporting if supported to the wideband speech
>>> +      * setting value
>>> +      */
>>> +     if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks) &&
>>> +         (hdev->commands[18] & 0x04) &&
>>> +         hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED) !=
>>> +          (hdev->err_data_reporting != ERR_DATA_REPORTING_ENABLED)) {
>> 
>> So this statement is creating a knot in my brain ;)
>> 
>> 
>>        if (hdev->commands[18] & 0x04) {
>>                bool enabled = hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED);
>> 
>>                ..
>> 
>>                cp.err_data_reporting = enabled ? ERR_DATA_REPORTING_ENABLED :
>>                                                  ERR_DATA_REPORTING_DISABLED;
>> 
>>                ..
>>        }
>> 
>> I would not bother checking the quirk here. I would just configure that setting based on the HCI_WIDEBAND_SPEECH_ENABLED flag. Unless we have controllers that report this command and don’t allow setting the value, then we have to deal with it, but right now I assume that they get the basics of HCI right.
>> 
>> Btw. I am debating a coding style here.
>> 
>>                cp.err_data_reporting = enabled ? ERR_DATA_REPORTING_ENABLED
>>                                                : ERR_DATA_REPORTING_DISABLED;
>> 
>> But I am not even sure that is clearer or cleaner.
> 
> I agree the QUIRK check could be avoided, but I'd argue the following
> condition is still required to avoid sending a command that otherwise
> is not necessary to the controller:
> hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED) !=
> (hdev->err_data_reporting != ERR_DATA_REPORTING_ENABLED).  I can
> however simplify it by using a bool enabled flag as you suggested.

ok, then do that.

Regards

Marcel

