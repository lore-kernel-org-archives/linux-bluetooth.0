Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41C1DB37B
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163378; cv=none; b=Quf9DjMuNO9mta1qxIzpu2x3dcJS9jvXswjkI1hl29pO77WnAOHpate9gfQIAmipTw18qN2XBdcRC9xP184pVTZX8r7VaEi9Rr0eksgoScyvueIf+ZHtIyVThUxdjHy5xBRtEYs91a4qoLXU88gHKm9hOp2aDEq4ndRqO07GU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163378; c=relaxed/simple;
	bh=yZ5hqhhRUk1fDhkk9dlivHFXtnsaJptI3ONdhQ0dGqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvxWnRdpW0BfZ6uiGTSlbW0fD78mOlFInapAf80UNwjSAoRhxaLne0sSRarkQSDSyDiKCHnRXIfr3j59Ba0yx/1/muV4wAnvA0ayZeIRwsB62xH8MdbDvwOnzJpfY/B6hoBZv/RneIdxHbrXSGmC9PnXz2oV80JyeU3THRoWYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af745.dynamic.kabel-deutschland.de [95.90.247.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E760861E5FE05;
	Thu, 17 Oct 2024 13:09:10 +0200 (CEST)
Message-ID: <0e3f0b14-00a2-428b-a673-eed37f628c17@molgen.mpg.de>
Date: Thu, 17 Oct 2024 13:09:10 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth:btintel: Do no pass vendor events to stack
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
References: <20241017102236.729685-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241017102236.729685-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch. Please note, in the summary/title a space is 
missing before *btintel*.

Am 17.10.24 um 12:22 schrieb Kiran K:
> During firmware download, vendor specific events like boot up and
> secure send result are generated. These events can be safely processed at
> the driver level. Passing on these events to stack prints unnecessary
> below warning log.
> 
> --
> Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> --

I’d remove the `--` and just indent the message by four characters to 
follow Markdown markup style.

On what device did you test this? Are there open reports about it?

> Fixes: 3368aa357f3b ("Bluetooth: msft: Handle MSFT Monitor Device Event")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c      | 6 ++++--
>   drivers/bluetooth/btintel_pcie.c | 9 ++++++---
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 2be6d48a2a65..e122dff855ba 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3395,7 +3395,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>   				 * indicating that the bootup completed.
>   				 */
>   				btintel_bootup(hdev, ptr, len);
> -				break;
> +				kfree_skb(skb);
> +				return 0;
>   			case 0x06:
>   				/* When the firmware loading completes the
>   				 * device sends out a vendor specific event
> @@ -3403,7 +3404,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>   				 * loading.
>   				 */
>   				btintel_secure_send_result(hdev, ptr, len);
> -				break;
> +				kfree_skb(skb);
> +				return 0;
>   			}
>   		}
>   
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index e4ae8c898dfd..deed8052b482 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -551,7 +551,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>   				if (btintel_pcie_in_op(data)) {
>   					btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
>   					data->alive_intr_ctxt = BTINTEL_PCIE_INTEL_HCI_RESET2;
> -					break;
> +					kfree_skb(skb);
> +					return 0;
>   				}
>   
>   				if (btintel_pcie_in_iml(data)) {
> @@ -568,7 +569,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>   						btintel_wake_up_flag(data->hdev,
>   								     INTEL_WAIT_FOR_D0);
>   				}
> -				break;
> +				kfree_skb(skb);
> +				return 0;
>   			case 0x06:
>   				/* When the firmware loading completes the
>   				 * device sends out a vendor specific event
> @@ -576,7 +578,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>   				 * loading.
>   				 */
>   				btintel_secure_send_result(hdev, ptr, len);
> -				break;
> +				kfree_skb(skb);
> +				return 0;
>   			}
>   		}


Kind regards,

Paul
