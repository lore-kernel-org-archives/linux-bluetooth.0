Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC643FA5C2;
	Tue,  9 Jun 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001018; cv=none; b=nEnq0ddtz9ZqRAh68aDGx2ap/7Az6nJKt0B0ux9uORHhgc+vgHP+pimiszF0wxHo6ko1Z6vtoJ1Ia9S2kTYF/XGetaOFVTWceEWsn4RAawxJ3wzvPPnDaGQ/FS4JecMsVmRfxGuNVFh2bxE1V9hq3C+I6jBut45a7emZMW7e7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001018; c=relaxed/simple;
	bh=s53SAJtHuBUVpY8zPjfmpKd9CFnayosK2jBCutWToPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3yzkoPPkHGylme2pLbvBsQXUCQLSgZsyaBtPNidV4fqVq2wCdtNz5Ubrnnrte9hh3bAo2vSh+cYfAhM7iTo7u5E0WxTYIDQnwXZmC/jX/XVOLGXmxgwR+0LMDp3VCNSQQ6I8I6anXNQN7T8EHyrgltVdI8NP/NjVy5SX7oJkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.25.4.255] (unknown [192.12.81.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7C3444C2C37F09;
	Tue, 09 Jun 2026 12:29:42 +0200 (CEST)
Message-ID: <8697f148-5e21-44b4-a949-9d348e39c2ea@molgen.mpg.de>
Date: Tue, 9 Jun 2026 12:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Add BT FW build version log
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <CAMRc=Met_U-1gDmGFM9hSWFc5vvs4SuRQOa3hZcfUo190rh59w@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAMRc=Met_U-1gDmGFM9hSWFc5vvs4SuRQOa3hZcfUo190rh59w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Xiuzhuo, dear Bartosz


Am 09.06.26 um 11:39 schrieb Bartosz Golaszewski:
> On Tue, 9 Jun 2026 09:54:17 +0200, Xiuzhuo Shang said:
>> Printf BT FW build version log after BT FW downloaded.

Please paste the new lines, so reviewers see how it is going to look 
like. Please also document a motivation (answering Why?).

>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index dda76365726f..04ebe290bc78 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -143,6 +143,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>>
>>   	hci_set_fw_info(hdev, "%s", build_label);
>>
>> +	bt_dev_info(hdev, "QCA FW build version: %s", build_label);
>> +
>>   	kfree(build_label);
>>   out:
>>   	kfree_skb(skb);
> 
> This string can be read from debugfs, do we need an additional message in the
> kernel log?

In my opinion the firmware version should be part of the Linux logs, as 
that is what users share with bug reports, and you do not want to have 
several cycles collecting information. For example, currently for 
QCA6174 it’s currently:

     Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 
0x302 build 0x111


Kind regards,

Paul


PS:

```
$ sudo dmesg | grep -e ath10k -e Bluetooth
[   17.880668] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
[   17.883428] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 
irq_mode 0 reset_mode 0
[   18.138972] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 
chip_id 0x00340aff sub 1a56:1535
[   18.138977] ath10k_pci 0000:3a:00.0: kconfig debug 1 debugfs 1 
tracing 1 dfs 0 testmode 0
[   18.139068] ath10k_pci 0000:3a:00.0: firmware ver 
WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
[   18.206593] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A 
crc32 d2863f91
[   18.221145] Bluetooth: Core ver 2.22
[   18.221802] Bluetooth: HCI device and connection manager initialized
[   18.221807] Bluetooth: HCI socket layer initialized
[   18.221808] Bluetooth: L2CAP socket layer initialized
[   18.221813] Bluetooth: SCO socket layer initialized
[   18.258187] Bluetooth: hci0: using rampatch file: 
qca/rampatch_usb_00000302.bin
[   18.258192] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, 
firmware rome 0x302 build 0x111
[   18.301557] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 
cal otp max-sta 32 raw 0 hwcrypto 1
[   18.381567] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
[   18.619003] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[   18.643646] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
```
