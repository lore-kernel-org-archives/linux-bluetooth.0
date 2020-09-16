Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D1C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 02:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5157F20770
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 02:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HyhmVcTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIPCCu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:02:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31102 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIPCCt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 22:02:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600221768; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ip2VN/FNmvU+7orc2a6pZAYO/+IWNOcQEXEYPx0uFJM=;
 b=HyhmVcTDo9skeQ+KNby4XXVD84qbqxJ2BU554OCr91VuDH5iF8zgI9+l6UCepNpVGN1WQd14
 1gkMPWSFBpWoAUllnodBE9lakTh7t+O9Lfa1QXFSMGMWzoCqGHk+FTk7GUCcy5Y0Ti9zP8b5
 l8UOEkIVq/TyUuq+H7fMUB0yE5U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f617247238e1efa37cf6305 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 02:02:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D02CC433FE; Wed, 16 Sep 2020 02:02:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85A11C433C8;
        Wed, 16 Sep 2020 02:02:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Sep 2020 10:02:46 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
 support
In-Reply-To: <A89496D5-1CDD-499E-B167-FA2064BDF1A7@holtmann.org>
References: <0101017457c6b819-d1292819-1fae-43af-8fb8-3bc572f53cd5-000000@us-west-2.amazonses.com>
 <20200914092744.17464-1-rjliao@codeaurora.org>
 <4FCC6630-8350-4E4A-B156-42B2F3581BFD@holtmann.org>
 <c9912094c4627b34f49458ae36c9cd25@codeaurora.org>
 <A89496D5-1CDD-499E-B167-FA2064BDF1A7@holtmann.org>
Message-ID: <212f6f38e3279dbaa6d5593f2260a0c9@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

在 2020-09-15 21:57，Marcel Holtmann 写道：
> Hi Rocky,
> 
>>>> This patch add support for WCN6855 i.e. patch and nvm download
>>>> support.
>>>> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 50 
>>>> ++++++++++++++++++++++++++++++++++-----
>>>> 1 file changed, 44 insertions(+), 6 deletions(-)
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index fe80588c7bd3..789e8d5e829e 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -59,6 +59,7 @@ static struct usb_driver btusb_driver;
>>>> #define BTUSB_MEDIATEK		0x200000
>>>> #define BTUSB_WIDEBAND_SPEECH	0x400000
>>>> #define BTUSB_VALID_LE_STATES   0x800000
>>>> +#define BTUSB_QCA_WCN6855	0x1000000
>>>> static const struct usb_device_id btusb_table[] = {
>>>> 	/* Generic Bluetooth USB device */
>>>> @@ -273,6 +274,10 @@ static const struct usb_device_id 
>>>> blacklist_table[] = {
>>>> 	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME },
>>>> 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME },
>>>> +	/* QCA WCN6855 chipset */
>>>> +	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
>>>> +						     BTUSB_WIDEBAND_SPEECH },
>>>> +
>>>> 	/* Broadcom BCM2035 */
>>>> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
>>>> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
>>>> @@ -3391,6 +3396,26 @@ static int btusb_set_bdaddr_ath3012(struct 
>>>> hci_dev *hdev,
>>>> 	return 0;
>>>> }
>>>> +static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
>>>> +				const bdaddr_t *bdaddr)
>>>> +{
>>>> +	struct sk_buff *skb;
>>>> +	u8 buf[6];
>>>> +	long ret;
>>>> +
>>>> +	memcpy(buf, bdaddr, sizeof(bdaddr_t));
>>>> +
>>>> +	skb = __hci_cmd_sync(hdev, 0xfc14, sizeof(buf), buf, 
>>>> HCI_INIT_TIMEOUT);
>>>> +	if (IS_ERR(skb)) {
>>>> +		ret = PTR_ERR(skb);
>>>> +		bt_dev_err(hdev, "Change address command failed (%ld)", ret);
>>>> +		return ret;
>>>> +	}
>>>> +	kfree_skb(skb);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> #define QCA_DFU_PACKET_LEN	4096
>>>> #define QCA_GET_TARGET_VERSION	0x09
>>>> @@ -3428,6 +3453,8 @@ static const struct qca_device_info 
>>>> qca_devices_table[] = {
>>>> 	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
>>>> 	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
>>>> 	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
>>>> +	{ 0x00130100, 40, 4, 18 }, /* WCN6855 1.0 */
>>>> +	{ 0x00130200, 40, 4, 18 }  /* WCN6855 2.0 */
>>>> };
>>>> static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 
>>>> request,
>>>> @@ -3529,8 +3556,8 @@ static int 
>>>> btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>>> {
>>>> 	struct qca_rampatch_version *rver;
>>>> 	const struct firmware *fw;
>>>> -	u32 ver_rom, ver_patch;
>>>> -	u16 rver_rom, rver_patch;
>>>> +	u32 ver_rom, ver_patch, rver_rom;
>>>> +	u16 rver_rom_low, rver_rom_high, rver_patch;
>>>> 	char fwname[64];
>>>> 	int err;
>>>> @@ -3549,9 +3576,16 @@ static int 
>>>> btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>>> 	bt_dev_info(hdev, "using rampatch file: %s", fwname);
>>>> 	rver = (struct qca_rampatch_version *)(fw->data + 
>>>> info->ver_offset);
>>>> -	rver_rom = le16_to_cpu(rver->rom_version);
>>>> +	rver_rom_low = le16_to_cpu(rver->rom_version);
>>>> 	rver_patch = le16_to_cpu(rver->patch_version);
>>>> +	if (ver_rom & ~0xffffU) {
>>>> +		rver_rom_high = le16_to_cpu(*(__le16 *)(fw->data + 16));
>>>> +		rver_rom = le32_to_cpu(rver_rom_high << 16 | rver_rom_low);
>>>> +	} else {
>>>> +		rver_rom = (__force u32)rver_rom_low;
>>>> +	}
>>>> +
>>> I don’t get this. Is anything wrong with get_unaligned_le32 etc.?
>>> My brain just hurts with your casting and pointer magic. Maybe the
>>> whole rver logic needs a clean up first.
>> It's not a 4 bytes le data, for example the version stream is 0x13, 
>> 0x00, 0x00, 0x01 and we need to convert it to 0x00130100. So we have 
>> to convert it to 2 u16 value then combine them to a u32.
> 
> what is it then? Is it big endian formatted. If it is not a 32-bit
> value, then don’t store it as one.
> 
OK, let me refine the patch to a more readable format.

> Regards
> 
> Marcel
