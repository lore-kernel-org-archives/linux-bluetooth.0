Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858221B9F6;
	Wed, 10 Jun 2026 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124887; cv=none; b=Yw0So5qgQqBcM8k+pA3S8o6hKk0u4lALHXwf/ZZ6IyQrxzlQuoaHNZtPvsJ6u9fMOqyu9XaeUym43rfXM3obI+OnZyAHU7wKG2SUjeuHxhn4nGTyjViGjAnEU/lUHul+YsnssgCtuB78Z9GjOvWr3pxToOsC85DTKzJX2uqr/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124887; c=relaxed/simple;
	bh=q9w410uDOKOfIU5gF6ENnANOSBygwJhHeqUuFLtHdHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vk/MHfcxSvJFR+PDk6gBudCu06Ohru/DRTFITmCFLBQJjox+mYKS8ZWGwQgb2fwdrzPVQjZE+/QconFhZ159z4r7bEuxW6VeqxVrUeC8jkS7C8u+gwFwvzVPpBV25W+YNP7ssm/hrLTb4qTj0Zig3UKLzPyd51kT1nt1G+vAQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.202] (unknown [185.238.219.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3952E4C2C37D7A;
	Wed, 10 Jun 2026 22:54:08 +0200 (CEST)
Message-ID: <809ea8e8-c95e-4200-8d2f-1a0354cd523c@molgen.mpg.de>
Date: Wed, 10 Jun 2026 22:54:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Xiuzhuo,


Thank you for the patch, which was applied today.

Am 10.06.26 um 08:42 schrieb Xiuzhuo Shang:
> Firmware version is critical for bug triage. Users reporting issues
> typically share dmesg output rather than debugfs contents, requiring
> extra communication rounds to collect this information. Log the FW
> build version directly to the kernel log so it is immediately
> available in bug reports.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
> Example output:
>    Bluetooth: hci0: QCA FW build version: BTFW.MOSELLE.1.1.3-00106-MSL_PATCHZ-1

Please put it in the commit message next time.

Also, just for completeness, could you please paste all the 
Bluetooth/hci0/QCA logs, so that maybe a more condensed logging format 
can be found?

>   drivers/bluetooth/btqca.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dda76365726f..04ebe290bc78 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -143,6 +143,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>   
>   	hci_set_fw_info(hdev, "%s", build_label);
>   
> +	bt_dev_info(hdev, "QCA FW build version: %s", build_label);
> +
>   	kfree(build_label);
>   out:
>   	kfree_skb(skb);


Kind regards,

Paul
