Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F042C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CB8610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbhIBJid convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:38:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34257 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbhIBJid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 05:38:33 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2FB04CECDD;
        Thu,  2 Sep 2021 11:37:34 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO
 use non-HCI transport
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com>
Date:   Thu, 2 Sep 2021 11:37:33 +0200
Cc:     Kiran K <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <135FFE98-549B-4C02-9AC3-AD7F18EC0564@holtmann.org>
References: <20210831115637.6713-1-kiran.k@intel.com>
 <20210831115637.6713-12-kiran.k@intel.com>
 <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> Currently usb tranport is not allowed to suspend when SCO over
>> HCI tranport is active.
>> 
>> This patch shall enable the usb tranport to suspend when SCO
>> link use non-HCI transport
>> 
>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>> Signed-off-by: Kiran K <kiran.k@intel.com>
>> ---
>> 
>> Notes:
>>    changes in v13:
>>    - suspend usb in HFP offload use case
>> 
>> drivers/bluetooth/btintel.c       |  2 +-
>> include/net/bluetooth/bluetooth.h |  4 ++++
>> net/bluetooth/hci_event.c         | 20 +++++++++++---------
>> net/bluetooth/sco.c               |  2 +-
>> 4 files changed, 17 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>> index 6091b691ddc2..2d64e289cf6e 100644
>> --- a/drivers/bluetooth/btintel.c
>> +++ b/drivers/bluetooth/btintel.c
>> @@ -2215,7 +2215,7 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
>> static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
>> {
>>        /* Intel uses 1 as data path id for all the usecases */
>> -       *data_path_id = 1;
>> +       *data_path_id = BT_SCO_PCM_PATH;
>>        return 0;
>> }
>> 
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index c1fa90fb7502..9e2745863b33 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -177,6 +177,10 @@ struct bt_codecs {
>> #define CODING_FORMAT_TRANSPARENT      0x03
>> #define CODING_FORMAT_MSBC             0x05
>> 
>> +/* Audio data transport path used for SCO */
>> +#define BT_SCO_HCI_PATH 0x00
>> +#define BT_SCO_PCM_PATH 0x01
> 
> If this is in fact vendor specific perhaps you should be declared in
> btintel.h not here.
> 
>> +
>> __printf(1, 2)
>> void bt_info(const char *fmt, ...);
>> __printf(1, 2)
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index b48e24629fa4..7ff11cba89cf 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -4516,15 +4516,17 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
>> 
>>        bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
>> 
>> -       switch (ev->air_mode) {
>> -       case 0x02:
>> -               if (hdev->notify)
>> -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
>> -               break;
>> -       case 0x03:
>> -               if (hdev->notify)
>> -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
>> -               break;
>> +       if (conn->codec.data_path == BT_SCO_HCI_PATH) {
>> +               switch (ev->air_mode) {
>> +               case 0x02:
>> +                       if (hdev->notify)
>> +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
>> +                       break;
>> +               case 0x03:
>> +                       if (hdev->notify)
>> +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
>> +                       break;
>> +               }
> 
> Hmm I think we might need to notify the driver to enable PCM routing
> so the likes of btusb can call
> usb_disable_endpoint/usb_enable_endpoint for example since in theory
> userspace may choose to switch from software to hardware offload and
> vice-versa, note without calling usb_disable_endpoint there might not
> be much power saving after all since the endpoint will remain active
> or do we actually have a good explanation why it shall not be called
> when using PCM routing? Note that usb_set_interface will call
> usb_enable_interface that will then call usb_enable_endpoint so
> perhaps we need to call usb_disable_interface, either way we can't
> assume the platform will be restricted to only use one or the other.

actually for the Intel hardware we shouldn’t do this at all. We should switch to vendor specific SCO over bulk endpoints and not claim the ISOC endpoints at all.

Regards

Marcel

