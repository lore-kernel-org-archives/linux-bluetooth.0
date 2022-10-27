Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140AC38A2D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Oct 2022 09:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiJ0Js5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiJ0Js4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 05:48:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6E3B96E
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666864134; x=1698400134;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rPZmwB9aQXTbd9zczolSgIRlrQjqSA/YF54vKKj6LAs=;
  b=ijprOQRPZCtP3UQsydozqqzYnkwhjnHeSdtKBEbbIi9nq58AWJUxwLkD
   B0Umj8cEb/qeT205hbP4LPlLKDc8mv182nm/KlUGY2/KV7a8RQCB8BegN
   jXk8Rsc5EWN+OzdvTebFRIYKJNPj0OYv2LhGFOaHs+LH++w5R28mVe5eW
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Oct 2022 02:48:54 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:48:54 -0700
Received: from [10.249.8.186] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 02:48:53 -0700
Message-ID: <1f6d5fa0-bd99-0a01-51a9-247f329e82aa@quicinc.com>
Date:   Thu, 27 Oct 2022 17:48:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
 unusable again with kernel 6.0
Content-Language: en-US
From:   quic_zijuhu <quic_zijuhu@quicinc.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jack <ostroffjh@users.sourceforge.net>
CC:     <linux-bluetooth@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <ab082d3c-9ba6-b1bd-a895-65ea58cec926@molgen.mpg.de>
 <O224FXKX.42565NIW.L5YD2R5Q@C37RPHFZ.QBNZTYLX.ESJXSIHV>
 <CABBYNZKWc13qGDOyhPZ9wZcTaK+Wg0LUycsKX58w7wEjTaGS=A@mail.gmail.com>
 <e88e7e6a-53bd-e621-08ea-d264bbd8665e@quicinc.com>
In-Reply-To: <e88e7e6a-53bd-e621-08ea-d264bbd8665e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 10/26/2022 11:41 AM, quic_zijuhu wrote:
> On 10/26/2022 3:38 AM, Luiz Augusto von Dentz wrote:
>> Hi Zijun,
>>
>> On Tue, Oct 25, 2022 at 11:08 AM Jack <ostroffjh@users.sourceforge.net> wrote:
>>>
>>> On 2022.10.25 03:02, Paul Menzel wrote:
>>>> Thank you for your work on this driver.
>>>>
>>>> Am 24.10.22 um 23:11 schrieb Jack:
>>>>> Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001
>>>>> Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had
>>>>> historic problems, due to various bad behaviors.  See [Bug 60824]
>>>>> [PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
>>>>> unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details
>>>>> and background.  The patch in that bug was initially mainlined in
>>>>> 5.9, and underwent several revisions since then.  It has continued
>>>>> to work through all of the 5.19 series, but it does not work with
>>>>> any of the 6.0 kernels.
>>>>>
>>>>> I have made three unsuccessful attempts to git bisect using vanilla
>>>>> sources.  All settled on totally irrelevant commits.  These have all
>>>>> used v6.0-rc1 and v5.19 as the starting bad and good commits.
>>>>
>>> Before receiving your reply, I made another start at bisect
>>>
>>> # bad: [5030a9a03f0107f645772450bcba521b2ec19a51] dt-bindings: net:
>>> fsl,fec: Add nvmem-cells / nvmem-cell-names properties
>>> # good: [8a958732818bc27f7da4d41ecf2c5c99d9aa8b0e] tls: rx: factor out
>>> device darg update
>>> git bisect start '5030a9a03f0107f645772450bcba521b2ec19a51'
>>> '8a958732818bc27f7da4d41ecf2c5c99d9aa8b0e'
>>> # good: [7ca433dc6dedb2ec98dfc943f6db0c9b8996ed11] Merge tag
>>> 'net-5.19-rc8' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>> git bisect good 7ca433dc6dedb2ec98dfc943f6db0c9b8996ed11
>>> # bad: [e168f690087735ad12604ee6ee2db1b93e323072] Bluetooth: btusb:
>>> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for fake CSR
>>> git bisect bad e168f690087735ad12604ee6ee2db1b93e323072
>>> # good: [5fb859f79f4f49d9df16bac2b3a84a6fa3aaccf1] net: ipa: initialize
>>> ring indexes to 0
>>> git bisect good 5fb859f79f4f49d9df16bac2b3a84a6fa3aaccf1
>>> # good: [ec2ea5e06c67f85c6541a74b661722a176be086f] net: ipa: list
>>> supported IPA versions in the Makefile
>>> git bisect good ec2ea5e06c67f85c6541a74b661722a176be086f
>>> # good: [df332800a914e9fd97b83aa63832979227fd8a8d] Bluetooth:
>>> btmtksdio: Add in-band wakeup support
>>> git bisect good df332800a914e9fd97b83aa63832979227fd8a8d
>>> # good: [6f43f6169a8229bb6ddbf483d3be760d48c4cdd1] Bluetooth: clean up
>>> error pointer checking
>>> git bisect good 6f43f6169a8229bb6ddbf483d3be760d48c4cdd1
>>> # good: [46459cb6d4e63066e227a496ae8af35ba8c0b23b] Bluetooth: hci_bcm:
>>> Increase host baudrate for CYW55572 in autobaud mode
>>> git bisect good 46459cb6d4e63066e227a496ae8af35ba8c0b23b
>>> # good: [0feb8af0275d196a29e321bedc15319673923cb6] Bluetooth: hci_sync:
>>> Correct hci_set_event_mask_page_2_sync() event mask
>>> git bisect good 0feb8af0275d196a29e321bedc15319673923cb6
>>> # bad: [1172c59f451f524a14bac5e7b047781883dfe441] Bluetooth: btusb:
>>> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
>>> git bisect bad 1172c59f451f524a14bac5e7b047781883dfe441
>>> # bad: [766ae2422b4312a73510ebee9266bc23b466fbbb] Bluetooth: hci_sync:
>>> Check LMP feature bit instead of quirk
>>> git bisect bad 766ae2422b4312a73510ebee9266bc23b466fbbb
>>> # first bad commit: [766ae2422b4312a73510ebee9266bc23b466fbbb]
>>> Bluetooth: hci_sync: Check LMP feature bit instead of quirk
>>>
>>> And 766ae2422b4312a73510ebee9266bc23b466fbbb does make sense as a
>>> likely culprit.
>>
>> Looks like we will need to reintroduce the quirk then since it appears
>> the LMP feature bit is probably set in those controllers but the
>> command doesn't work.
>>
> no, that issue is not caused by my change
> it is below HCI command error which is not related the quirk HCI_QUIRK_BROKEN_ERR_DATA_REPORTING
> 
> < HCI Command: Set Event Filter (0x03|0x0005) plen 1                                                                                                     #23 [hci0] 5.316838
>         Type: Clear All Filters (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                                    
>>                                                                          #24
>> [hci0] 5.319751
> 
>       Set Event Filter (0x03|0x0005) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
> = Close Index: 00:1A:7D:xx:xx:xx
> 

Hi Luiz,
i find out it is a new issue. this device is fake device actually.
but it is not detected as fake device.

i will submit patch to fix it. the fix is very simple.
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
old mode 100644
new mode 100755

index 420be2ee2acf..727469d073f9
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2155,7 +2155,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
                is_fake = true;

        else if (le16_to_cpu(rp->lmp_subver) <= 0x22bb &&
-                le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_4_0)
+                le16_to_cpu(rp->hci_ver) >= BLUETOOTH_VER_4_0)
                is_fake = true;


