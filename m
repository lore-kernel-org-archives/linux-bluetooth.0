Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB81C4727E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 09:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BA9221E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HYBvt2eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgIYJCD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:02:03 -0400
Received: from z5.mailgun.us ([104.130.96.5]:55958 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgIYJB7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 05:01:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601024518; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ihGr2/1LQtp+XJ1GkpNMuUiHJdP+XuIzVWyhGGC9mkg=;
 b=HYBvt2eNKSPGIWcPEdd46tawQ6skiAit2gSC/WNDdqkIhGaglTZoqtdXbJufFgw7tMRLnaMS
 AHnobST0VJ6Yhn6qfgDQnpUgMgPijjqHIGoISFa1QdeBQIl9FWrFoNEHE7lU3SJKcWgiPccd
 v0BTx5rHxaGrA99XzdUjcXxAz1g=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f6db1bec00ccaf02885fd80 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 09:00:46
 GMT
Sender: rjliao=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3905CC433FF; Fri, 25 Sep 2020 09:00:46 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F88BC433C8;
        Fri, 25 Sep 2020 09:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 25 Sep 2020 17:00:45 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        c-hbandi@codeaurora.org, Hemantg <hemantg@codeaurora.org>,
        mka@chromium.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
 support
In-Reply-To: <0C779191-3BD1-40BF-83E6-733F9C78EA03@holtmann.org>
References: <0101017457c6b810-cb8b79ae-4663-436b-83d0-4c70c245bd25-000000@us-west-2.amazonses.com>
 <2E48211B-D62D-43D8-9C97-014966FBB2CB@holtmann.org>
 <c177f408186da437db722d855a01c846@codeaurora.org>
 <0C779191-3BD1-40BF-83E6-733F9C78EA03@holtmann.org>
Message-ID: <7482e21cb10a7e73dd9a9f784e2e5370@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

在 2020-09-14 21:25，Marcel Holtmann 写道：
> Hi Rocky,
> 
>>>> This patch add support for WCN6855 i.e. patch and nvm download
>>>> support.
>>>> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 42 
>>>> +++++++++++++++++++++++++++++++++++----
>>>> 1 file changed, 38 insertions(+), 4 deletions(-)
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index fe80588c7bd3..e51e754ca9b8 100644
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
>>> What is wrong with using qca_set_bdaddr() function.
>> WCN6855 is using different VSC to set the bt addr
> 
> int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> 
> {
> 
>         struct sk_buff *skb;
> 
>         int err;
> 
> 
> 
>         skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
> bdaddr,
>                                 HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> 
>         if (IS_ERR(skb)) {
> 
>                 err = PTR_ERR(skb);
> 
>                 bt_dev_err(hdev, "QCA Change address cmd failed (%d)",
> err);
>                 return err;
> 
>         }
> 
> 
> 
>         kfree_skb(skb);
> 
> 
> 
>         return 0;
> 
> }
> 
> EXPORT_SYMBOL_GPL(qca_set_bdaddr);
> 
> I see that the other command is using HCI_EV_VENDOR, but is that on
> purpose or an accident? Might want to confirm with the btmon trace.
> 

You are right this is an accident, this command for WCN6855 have command 
complete event return. I will modify this in next patch update. Below is 
the btmon log:

Bluetooth monitor ver 5.48
= Note: Linux version 5.8.0-rc6-hsp-upstream+ (x86_64)                 
0.729933
= Note: Bluetooth subsystem version 2.22                               
0.729934
= New Index: 00:00:00:00:5A:AD (Primary,USB,hci1)               [hci1] 
0.729935
= Open Index: 00:00:00:00:5A:AD                                 [hci1] 
0.729935
= Index Info: 00:00:00:00:5A:AD (Qualcomm)                      [hci1] 
0.729935
= New Index: 00:00:00:00:00:00 (Primary,UART,hci0)              [hci0] 
0.729936
@ MGMT Open: bluetoothd (privileged) version 1.18             {0x0002} 
0.729936
@ MGMT Open: bluetoothd (privileged) version 1.18             {0x0001} 
0.729936
@ MGMT Open: btmon (privileged) version 1.18                  {0x0003} 
0.729945
@ RAW Open: hcitool (privileged) version 2.22               {0x0004} 
122.556176
@ RAW Close: hcitool                                        {0x0004} 
122.556200
@ RAW Open: hcitool (privileged) version 2.22               {0x0004} 
122.556219
@ RAW Close: hcitool                                        {0x0004} 
122.556223
@ RAW Open: hcitool (privileged) version 2.22        {0x0004} [hci1] 
122.556242
< HCI Command: Vendor (0x3f|0x0014) plen 6                 #1 [hci1] 
122.556643
         01 02 03 04 05 06                                ......
> HCI Event: Command Complete (0x0e) plen 4                #2 [hci1] 
> 122.675312
       Vendor (0x3f|0x0014) ncmd 1
         Status: Success (0x00)
@ RAW Close: hcitool                                 {0x0004} [hci1] 
122.675545
@ RAW Open: hcitool (privileged) version 2.22               {0x0004} 
124.528658
@ RAW Close: hcitool                                        {0x0004} 
124.528683
@ RAW Open: hcitool (privileged) version 2.22               {0x0004} 
124.528703
@ RAW Close: hcitool                                        {0x0004} 
124.528708
@ RAW Open: hcitool (privileged) version 2.22        {0x0004} [hci1] 
124.528760
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0           #3 [hci1] 
124.529024
> HCI Event: Command Complete (0x0e) plen 10               #4 [hci1] 
> 124.530311
       Read BD ADDR (0x04|0x0009) ncmd 1
         Status: Success (0x00)
         Address: 01:02:03:04:05:06 (OUI 01-02-03)
@ RAW Close: hcitool                                 {0x0004} [hci1] 
124.530509



> Regards
> 
> Marcel
