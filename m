Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA8FC43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 11:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978F121580
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 11:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKHIB/jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978F121580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeI0Rec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:34:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34641 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeI0Rec (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:34:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so2192150otl.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Sep 2018 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FxrVoiclznsjQubLikNYvL3CwEjMfrNEW6a2+ijPMFI=;
        b=kKHIB/jnJ4c+p2GaGo5Nmf0T+9SsLq2bHoyjgJ77Tg1E6ncGmyCenI6N0SKorLxkah
         0iaqoqfbh1MAuTXxvracGGvjaVbZFRtZLYYoIRrawSIQXLl2700kH8iGbAkm1wPg8eOh
         m499+gjnNkGEmCIEkX0dHxXfUTZdtUKVMxkL3cEpExUdEBtsuaXezcvBK+uSO/6kkzCr
         B7xL9ButQpiULEObF+56CU4azsd9iEoGpLFIcYZgIF5PYe9xCIjoQUYrcor5ZsByaC+u
         RU4XdQjECC61x4X9CG/tbvLuKOk5qtdylIXkmkG4wfaE7cvbzkTDm+3lCgVnwbGpkzAz
         3Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FxrVoiclznsjQubLikNYvL3CwEjMfrNEW6a2+ijPMFI=;
        b=bwpCvhQBJbwqd3V5w+xmIxSQ8bfqzLaq2F2cBrvlMVFHxvVCPcK9cTZgrCDld8WKdM
         1iYIxKQvFkTHEVHJcU3cfpX/4oARt7Qz0cZpBSDOel8WeOSuxaDS240KJ9z2lJkRqCQY
         ZjV9LMMkCsPwZR5wgfsPp2SPAu55JSjV+1OuhyDdD/Iwhn0aUu10P4dmrzinaHbq2o7S
         8O71shr9a73+gZrqnhGnOzJhyodkKujQ5B8rHPK7u6Nan96kWZoMwdKWU3IrtKSuelZw
         dRhp4FJGQExPskwxQZfNUb+WsLFZpshqQ/Pt8Zj9pX8TXleWqGVLesWE6/4s/poIJewa
         4m9w==
X-Gm-Message-State: ABuFfog2T5BssQqQOezlQDjQTyN7wp/8Bf8ubEbMtYX7Du05OndL5hHw
        GlDWF1WXYGEwjWpLXThQQ12+CnPzXpJRBWQPpGevGSW/
X-Google-Smtp-Source: ACcGV60tl5AeQznOaWNt9h2vWFCl5zo5Ke49PXzIG0FM74D3Mj3ncL63DT+ux69HErmS7DObF9nH3HCgOsI2eUx4vyU=
X-Received: by 2002:a9d:2a89:: with SMTP id e9-v6mr4366795otb.82.1538047005726;
 Thu, 27 Sep 2018 04:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5b02:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 04:16:44
 -0700 (PDT)
In-Reply-To: <2A9C1D9B-41AA-492C-9144-E8332409BF83@holtmann.org>
References: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com> <2A9C1D9B-41AA-492C-9144-E8332409BF83@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Sep 2018 14:16:44 +0300
Message-ID: <CABBYNZ+s9a1cKyH7T6J5+=60J7H6aoVt5K1_bx0aR+y0hh5pcw@mail.gmail.com>
Subject: Re: [PATCH] support fast advertising interval
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bharat Bhusan Panda <bharat.b.panda@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Bharat,

On Thu, Sep 27, 2018 at 1:57 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Bharat,
>
>> Changes made to add support for fast advertising interval as per
>> core 4.1 specification, section 9.3.11.2.
>>
>> A peripheral device enetering any of the following GAP modes and
>> sending either non-connectable advertising events or scannable undirected
>> advertising events should use adv_fast_interval2(100ms - 150ms)
>> for adv_fast_period(30s).
>>         - Non-Discoverable Mode
>>         - Non-Connectable Mode
>>         - Limited Discoverable Mode
>>         - General Discoverable Mode
>
> can we also get a patch documenting this in mgmt-api.txt in bluez.git.
>
>>
>> Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
>> ---
>> include/net/bluetooth/hci_core.h |  2 ++
>> net/bluetooth/hci_request.c      | 22 ++++++++++++++++++++++
>> 2 files changed, 24 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index b619a19..2fe908c 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1456,6 +1456,8 @@ struct hci_mgmt_chan {
>> #define DISCOV_INTERLEAVED_INQUIRY_LEN        0x04
>> #define DISCOV_BREDR_INQUIRY_LEN      0x08
>> #define DISCOV_LE_RESTART_DELAY               msecs_to_jiffies(200)   /* msec */
>> +#define DISCOV_LE_FAST_ADV_INT_MIN   100     /* msec */
>> +#define DISCOV_LE_FAST_ADV_INT_MAX   150     /* msec */
>>
>> void mgmt_fill_version_info(void *ver);
>> int mgmt_new_settings(struct hci_dev *hdev);
>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>> index 66c0781..5cf3ef9 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -1005,6 +1005,28 @@ void __hci_req_enable_advertising(struct hci_request *req)
>>       else
>>               cp.type = LE_ADV_NONCONN_IND;
>>
>> +     /* As per core 4.1 spec, section 9.3.11.2: A peripheral device
>> +      * enetering any of the following GAP modes and sending either
>
> Fix the typo please.
>
>> +      * non-connectable advertising events or scannable undirected
>> +      * advertising events should use adv_fast_interval2(100ms - 150ms)
>> +      * for adv_fast_period(30s).
>> +      *
>> +      *      - Non-Discoverable Mode
>> +      *      - Non-Connectable Mode
>> +      *      - Limited Discoverable Mode
>> +      *      - General Discoverable Mode
>> +      */
>> +     if ((cp.type == LE_ADV_NONCONN_IND) || (cp.type = LE_ADV_SCAN_IND)) {
>
> This extra (x == y) parentheses are not needed.

Btw the second part of the expression seem wrong, it is assigning not comparing.

>
>> +             if ((hci_dev_test_flag(hdev, HCI_DISCOVERABLE)) ||
>> +             (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) ||
>> +             (hdev->discovery.limited == true)) {
>
> And this is wrongly aligned. In addition, you need a bit more comment text above explains on what are the conditions.
>
>> +                     cp.min_interval =
>> +                             cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
>> +                     cp.max_interval =
>> +                             cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
>> +             }
>> +     }
>> +
>>       cp.own_address_type = own_addr_type;
>>       cp.channel_map = hdev->le_adv_channel_map;
>
> Regards
>
> Marcel
>



-- 
Luiz Augusto von Dentz
