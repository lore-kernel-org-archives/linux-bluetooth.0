Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B51C4727E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB960206BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 16:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIYQjm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:39:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56236 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYQjk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 12:39:40 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id B7A22CECDE;
        Fri, 25 Sep 2020 18:46:36 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix issue reported by static
 analysis tool
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BYAPR11MB3141CF1A1F129710852DD2B8F53B0@BYAPR11MB3141.namprd11.prod.outlook.com>
Date:   Fri, 25 Sep 2020 18:39:36 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kiran K <kiraank@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F03F8F05-0D33-446F-918A-33E9BDCA3350@holtmann.org>
References: <1600747219-11626-1-git-send-email-kiran.k@intel.com>
 <CABBYNZKTQeZZkVCGaCvnL661Qsxc1cFGNggEuM3pD7p0S8yRwQ@mail.gmail.com>
 <BYAPR11MB3141CF1A1F129710852DD2B8F53B0@BYAPR11MB3141.namprd11.prod.outlook.com>
To:     "K, Kiran" <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

>>> Smatch tool reported the below issue:
>>> 
>>> drivers/bluetooth/btintel.c:490 btintel_read_version_tlv()
>>> error: 'tlv->len' from user is not capped properly
>>> 
>>> Additional details in the below link
>>> https://www.spinics.net/lists/linux-bluetooth/msg87786.html
>>> 
>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>> ---
>>> drivers/bluetooth/btintel.c | 43
>>> ++++++++++++++++++++++++++++++++++++++++++-
>>> 1 file changed, 42 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>>> index 88ce5f0..47f2b3d 100644
>>> --- a/drivers/bluetooth/btintel.c
>>> +++ b/drivers/bluetooth/btintel.c
>>> @@ -431,62 +431,99 @@ int btintel_read_version_tlv(struct hci_dev
>> *hdev, struct intel_version_tlv *ver
>>>         * version field like hw_platform, hw_variant, and fw_variant
>>>         * to keep the existing setup flow
>>>         */
>>> -       while (skb->len) {
>>> +       while (skb->len >= sizeof(struct intel_tlv)) {
>>>                struct intel_tlv *tlv;
>>> 
>>>                tlv = (struct intel_tlv *)skb->data;
>>> +               if (struct_size(tlv, val, tlv->len) > skb->len)
>>> +                       goto failed;
>>> +
>>>                switch (tlv->type) {
>>>                case INTEL_TLV_CNVI_TOP:
>>> +                       if (tlv->len < sizeof(u32))
>>> +                               goto failed;
>>>                        version->cnvi_top = get_unaligned_le32(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_CNVR_TOP:
>>> +                       if (tlv->len < sizeof(u32))
>>> +                               goto failed;
>>>                        version->cnvr_top = get_unaligned_le32(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_CNVI_BT:
>>> +                       if (tlv->len < sizeof(u32))
>>> +                               goto failed;
>>>                        version->cnvi_bt = get_unaligned_le32(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_CNVR_BT:
>>> +                       if (tlv->len < sizeof(u32))
>>> +                               goto failed;
>>>                        version->cnvr_bt = get_unaligned_le32(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_DEV_REV_ID:
>>> +                       if (tlv->len < sizeof(u16))
>>> +                               goto failed;
>>>                        version->dev_rev_id = get_unaligned_le16(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_IMAGE_TYPE:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->img_type = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_TIME_STAMP:
>>> +                       if (tlv->len < sizeof(u16))
>>> +                               goto failed;
>>>                        version->timestamp = get_unaligned_le16(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_BUILD_TYPE:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->build_type = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_BUILD_NUM:
>>> +                       if (tlv->len < sizeof(u32))
>>> +                               goto failed;
>>>                        version->build_num = get_unaligned_le32(tlv->val);
>>>                        break;
>>>                case INTEL_TLV_SECURE_BOOT:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->secure_boot = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_OTP_LOCK:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->otp_lock = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_API_LOCK:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->api_lock = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_DEBUG_LOCK:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->debug_lock = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_MIN_FW:
>>> +                       if (tlv->len < 3)
>>> +                               goto failed;
>>>                        version->min_fw_build_nn = tlv->val[0];
>>>                        version->min_fw_build_cw = tlv->val[1];
>>>                        version->min_fw_build_yy = tlv->val[2];
>>>                        break;
>>>                case INTEL_TLV_LIMITED_CCE:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->limited_cce = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_SBE_TYPE:
>>> +                       if (tlv->len < sizeof(u8))
>>> +                               goto failed;
>>>                        version->sbe_type = tlv->val[0];
>>>                        break;
>>>                case INTEL_TLV_OTP_BDADDR:
>>> +                       if (tlv->len != sizeof(version->otp_bd_addr))
>>> +                               goto failed;
>> 
>> Do we really want to fail here? The advantage of using a TLV is that we can
>> skip if the type is not understood or is malformed but with this checks the
>> length becomes useless since the types will always have a fixed value, also
> 
> Agree that the types are fixed here. But if due to some reason if controller is not honoring the same, then driver might end up reading unwanted data. The check is more about driver being defensive rather than believing  what comes on wire.
> 
>> we cannot extend the types later on since it would not be backward
>> compatible if we maintain such strict checks.
> 
> I didn’t get this part. Could you please be more specific ?

please change this that you check the size of the TLV data part against the expected size of the field and only then assign it.

Regards

Marcel

