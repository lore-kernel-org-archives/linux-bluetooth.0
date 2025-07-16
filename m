Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D327261D;
	Wed, 16 Jul 2025 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636375; cv=none; b=lrf0Ftf6ZzWkKw12I2m6dJ6s8qfjG88o/n/J5V26d6MDXKIsHe+I+BwiNuQ39n8wTsqQq4KIQbHCD79Cf7ra5pcWNK4ekZDHHEIYYGvMgzbj2ZDh5PBETpxvN5omWBr1nZmAiRW0N8fCJj91/NNt9ijUhree8nCMfqmrmU/TfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636375; c=relaxed/simple;
	bh=h8NxuTyyqvPmA1Oiab4UpjfjwGlgCel2hu+Qxaf2RUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PXAm3RNERfPup2wuAmraXqgAv8p4TA1aVBvZdjh/Goy8BMLA3Vh/7JnCV2GuPQxU/Wwxg8OO62f0r9IK1if1AnyWakSWlmDgcN/sT8Y8uaDgj8uIB+4AS7mkp+fFdcg+1Q73pSBNC7wITM7BGEZ3lt1qw0kIZ00cZrzmKhnbw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.196] (p5b13a973.dip0.t-ipconnect.de [91.19.169.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 69AA061E64847;
	Wed, 16 Jul 2025 05:26:06 +0200 (CEST)
Message-ID: <4d79d6f7-5648-43fc-b321-ea130a2fd713@molgen.mpg.de>
Date: Wed, 16 Jul 2025 05:26:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] Bluetooth: vhci: Prevent use-after-free by
 removing debugfs files early
To: Ivan Pravdin <ipravdin.official@gmail.com>
References: <20250716004252.125466-2-ipravdin.official@gmail.com>
Content-Language: en-US
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250716004252.125466-2-ipravdin.official@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ivan,


Thank you for your patch.

Am 16.07.25 um 02:42 schrieb Ivan Pravdin:
> Move the creation of debugfs files into a dedicated function, and ensure
> they are explicitly removed during vhci_release(), before associated
> data structures are freed.
> 
> Previously, debugfs files such as "force_suspend", "force_wakeup", and
> others were created under hdev->debugfs but not removed in
> vhci_release(). Since vhci_release() frees the backing vhci_data
> structure, any access to these files after release would result in
> use-after-free errors.
> 
> Although hdev->debugfs is later freed in hci_release_dev(), user can
> access files after vhci_data is freed but before hdev->debugfs is
> released.
> 
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")

Not important, but I’d put the Signed-off-by: tag last.

> ---
> Resending because previous patch got archived [1].
> 
> [1] https://patchwork.kernel.org/project/bluetooth/patch/20250614235317.304705-1-ipravdin.official@gmail.com/
> 
>   drivers/bluetooth/hci_vhci.c | 57 ++++++++++++++++++++++++++----------
>   1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index f7d8c3c00655..2fef08254d78 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -380,6 +380,28 @@ static const struct file_operations force_devcoredump_fops = {
>   	.write		= force_devcd_write,
>   };
>   
> +static void vhci_debugfs_init(struct vhci_data *data)
> +{
> +	struct hci_dev *hdev = data->hdev;
> +
> +	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> +			    &force_suspend_fops);
> +
> +	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> +			    &force_wakeup_fops);
> +
> +	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> +		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> +				    &msft_opcode_fops);
> +
> +	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> +		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> +				    &aosp_capable_fops);
> +
> +	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
> +			    &force_devcoredump_fops);
> +}
> +
>   static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>   {
>   	struct hci_dev *hdev;
> @@ -434,22 +456,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>   		return -EBUSY;
>   	}
>   
> -	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> -			    &force_suspend_fops);
> -
> -	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> -			    &force_wakeup_fops);
> -
> -	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> -		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> -				    &msft_opcode_fops);
> -
> -	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> -		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> -				    &aosp_capable_fops);
> -
> -	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
> -			    &force_devcoredump_fops);
> +	if (!IS_ERR_OR_NULL(hdev->debugfs))
> +		vhci_debugfs_init(data);
>   
>   	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
>   
> @@ -651,6 +659,21 @@ static int vhci_open(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> +static void vhci_debugfs_remove(struct hci_dev *hdev)
> +{
> +	debugfs_lookup_and_remove("force_suspend", hdev->debugfs);
> +
> +	debugfs_lookup_and_remove("force_wakeup", hdev->debugfs);
> +
> +	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> +		debugfs_lookup_and_remove("msft_opcode", hdev->debugfs);
> +
> +	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> +		debugfs_lookup_and_remove("aosp_capable", hdev->debugfs);
> +
> +	debugfs_lookup_and_remove("force_devcoredump", hdev->debugfs);
> +}
> +
>   static int vhci_release(struct inode *inode, struct file *file)
>   {
>   	struct vhci_data *data = file->private_data;
> @@ -662,6 +685,8 @@ static int vhci_release(struct inode *inode, struct file *file)
>   	hdev = data->hdev;
>   
>   	if (hdev) {
> +		if (!IS_ERR_OR_NULL(hdev->debugfs))
> +			vhci_debugfs_remove(hdev);
>   		hci_unregister_dev(hdev);
>   		hci_free_dev(hdev);
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
