Return-Path: <SRS0=UugF=SB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F276C43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 22:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6B42146F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 22:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaV3Z34K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfC3Wof (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Mar 2019 18:44:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38171 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbfC3Woe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Mar 2019 18:44:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so5014183edr.5;
        Sat, 30 Mar 2019 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=y5qkv5fOum9QvGSuEiGh6DKKM0OmEEcwYVZymnxcnRw=;
        b=uaV3Z34Kaai7oqHm+ExN1IepfLJizddMv0kBLaK43r94kxJwqRPqh3ZNVVNOLw+H2a
         xLyakvwnvU3VkutgePEQK78aLxQ5rkC2XSsAPBtn1ipNTwp1PLBzSUqBSblc1wl/lFKX
         tY3pkXjiKaeABGysEDL2BkKDruqBB1ifHqsLEy3w/0BZTCsxSFALJN6d/WaqESUtKy6n
         cgG80LSOEIcowx6n9qVyd3u8OzuFQLe3nYOP6godW0a9BVBnSGmU8sp2zYOWAzbwi3nL
         QLDbua9krki+cCQXj+Y5MjN9KDc5irOQmH1gdSHOJyB29HU62V3bq2FUsYc01pUTW5c7
         QXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=y5qkv5fOum9QvGSuEiGh6DKKM0OmEEcwYVZymnxcnRw=;
        b=GAybVUomQelMvM1XM+n9sfQKTxT3qA6XtE89HL9GT1tb4Xfw3rPT49ITDczSw90GbQ
         L6lyEeXnpigoLhW758r5hIa1NEVbKYnfipr/PkpHRLsqtT66KrLHyj1iVwH0CfVN3ODO
         nNcr75B4HfEJ29pnKgLGaeyp0DoQ7Dg2MSIRZYtc/x8i3KQXE2ODKYIhvsKI11XLX+LX
         UMqQXmYlz8ZR1TeD4NzSdNXIZ/JZ6n+vmFAb5WOUp0wvCoxtJ/FHzTJB7q0oc1xBlD4H
         9KCYcz1onEge5R1ImGRIIYVEnyK27npKehrH4fP7R4TphvpxCkrJpJpss8yRrhsml8ZH
         KNVg==
X-Gm-Message-State: APjAAAVJJuNDjQ9TNlavgOTCvNZjrjTCW290FwVVww5J+sH0ZWy9oQ1B
        ZuA60kALjDnQi1uF2QPFkriaojHs
X-Google-Smtp-Source: APXvYqyBYAPlhQ3PmJl3Rjd52cX7R1ijLaQWS4f/eG8BhZfAj+aKAGOzopRyMM2wXgQ8t9I7cmES0g==
X-Received: by 2002:a17:906:c7c2:: with SMTP id dc2mr30156549ejb.182.1553985871694;
        Sat, 30 Mar 2019 15:44:31 -0700 (PDT)
Received: from [192.168.0.61] (xd520f242.cust.hiper.dk. [213.32.242.66])
        by smtp.gmail.com with ESMTPSA id a25sm1851158edc.55.2019.03.30.15.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:44:30 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV
 events
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b2a2b63a-c5f0-5d03-7516-668df6049c95@gmail.com>
Date:   Sat, 30 Mar 2019 23:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------57FE852E33794623DFB17A21"
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------57FE852E33794623DFB17A21
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

sorry for the multiple emails but I have checked again the code and
looks like process_adv_report() reads from ev->data for a size of
ev->length.

I attach a patch that applies the bound check to both
hci_le_ext_adv_report_evt() and hci_le_adv_report_evt().

Let me know your opinion,
Best regards,
Tomas

On 3/30/19 10:20 AM, Tomas Bortoli wrote:
> Hi Dan,
> 
> On 3/30/19 8:25 AM, Dan Carpenter wrote:
>> There is a potential out of bounds if "ev->length" is too high or if the
>> number of reports are too many.
>>
>> Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-By: Tomas Bortoli <tomasbortoli@gmail.com>
> 
>> ---
>> Not tested.  I suck at pointer math, and I don't know why the protocol
>> requires a "+ 1".  Please review carefully.
>>
>>  net/bluetooth/hci_event.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 609fd6871c5a..ee945b3d12e1 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -5417,6 +5417,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>  {
>>  	u8 num_reports = skb->data[0];
>>  	void *ptr = &skb->data[1];
>> +	void *end = &skb->data[skb->len];
>>  
>>  	hci_dev_lock(hdev);
>>  
>> @@ -5425,6 +5426,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>  		u8 legacy_evt_type;
>>  		u16 evt_type;
>>  
>> +		if (ptr + sizeof(*ev) + ev->length + 1 > end)
>> +			break;
> 
> Assuming that per each iteration, the while cycle, including the call to
> process_adv_report() read up to (sizeof(*ev) + ev->length + 1) bytes,
> 
> (I don't understand why the +1, but, anyway..)
> 
> If the assumption is correct, then the if condition should be:
> 
> if (ptr + sizeof(*ev) + ev->length + 1 >= end)
> 
> Because as soon as we try to read from the `end` pointer on, we are
> out-of-bound.. the valid skb bytes end at `end-1` (included)
> 
> Note that also hci_le_adv_report_evt() is likely to need the same fix!
> 
> 
>>  		evt_type = __le16_to_cpu(ev->evt_type);
>>  		legacy_evt_type = ext_evt_type_to_legacy(evt_type);
>>  		if (legacy_evt_type != LE_ADV_INVALID) {
>>
> 
> 
> Kind regards,
> Tomas
> 


--------------57FE852E33794623DFB17A21
Content-Type: text/x-patch;
 name="adv.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="adv.patch"

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..275926e0753e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5345,6 +5345,7 @@ static void hci_le_adv_report_evt(struct hci_dev *h=
dev, struct sk_buff *skb)
 {
 	u8 num_reports =3D skb->data[0];
 	void *ptr =3D &skb->data[1];
+	u8 *end =3D &skb->data[skb->len - 1];
=20
 	hci_dev_lock(hdev);
=20
@@ -5352,6 +5353,9 @@ static void hci_le_adv_report_evt(struct hci_dev *h=
dev, struct sk_buff *skb)
 		struct hci_ev_le_advertising_info *ev =3D ptr;
 		s8 rssi;
=20
+		if (ev->data + ev->length > end)
+			break;
+
 		if (ev->length <=3D HCI_MAX_AD_LENGTH) {
 			rssi =3D ev->data[ev->length];
 			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
@@ -5417,6 +5421,7 @@ static void hci_le_ext_adv_report_evt(struct hci_de=
v *hdev, struct sk_buff *skb)
 {
 	u8 num_reports =3D skb->data[0];
 	void *ptr =3D &skb->data[1];
+	u8 *end =3D &skb->data[skb->len - 1];
=20
 	hci_dev_lock(hdev);
=20
@@ -5425,6 +5430,9 @@ static void hci_le_ext_adv_report_evt(struct hci_de=
v *hdev, struct sk_buff *skb)
 		u8 legacy_evt_type;
 		u16 evt_type;
=20
+		if (ev->data + ev->length > end)
+			break;
+
 		evt_type =3D __le16_to_cpu(ev->evt_type);
 		legacy_evt_type =3D ext_evt_type_to_legacy(evt_type);
 		if (legacy_evt_type !=3D LE_ADV_INVALID) {

--------------57FE852E33794623DFB17A21--
