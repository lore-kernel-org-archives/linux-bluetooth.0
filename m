Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775922;
	b=mYVZQoL/XX9afYZqF00tfTJycIBaY8moJle5l3h3aAxHhBjmkRMO82dR943qrFu6yMCC
	 Ij+HLDe/k+aFEgY/R2ufg7+2QgFWKn0JAw8zUcMrKfyJg3441EUZVet5BlA2ZwELa0fyG
	 CnUIbUr48nDIE6I/BqMZyj8Z8Jwo6cejMnIVFzJRX+WQaZpqvruwY9XQkcU2QlcDrrAyi
	 lLSHBB00JIE8GyDn/oEQ0XyT/JH+9If1EmG/crtIc+Qnu/BobN1jSA1jyWWH0njeXFGf8
	 nWqZ5Lk9JLtkc5n7H9tI4CDmF0cm32TCuuTvWRIX+/ZoxBi/MTlgOg3HchUBDH3HXZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775922;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=oenNNRA/kAJF0ZcvOKKH4DQyOpOhFjLGdgBqfsCTK9M=;
	b=E6ZSPRSQ4BMwJl5rrhTKfKXtnqMOz8y6fUASzjZJoNt76MrzEdTY4yobN001+0jkk0ot
	 unk2w7iHxdjetBBe2q+rJmuj0vxsWIExsT/sczXk8SX8SSSKnlUQUNa2uEunbqKTTyt/o
	 nyh0qYa4H4xn1eS3/vjBPcVsVCx3c7UGORIcgZkiHGd+HmJOAMPPWsYpMnWplrPbqIO4V
	 32AUljz/ihtBlyxyDNSgZyxEeO7ZXeyxLwBzdwVGqNFKq6acMEMZsqfdLMfXWlGdhHsWw
	 +IoKRu/aYYGymZkk8ZujIWv4pjKh0MBAg5/orgmT1+x4mHrI5qen21p4Fm80wcoC9cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=iZcE6JIO;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624D606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6624D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=iZcE6JIO
Received: from [192.168.0.32] (ip-095-090-242-213.vkd79.pools.vodafone-ip.de [95.90.242.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 30E574C2F40059;
	Wed, 04 Nov 2026 08:05:06 +0100 (CET)
Message-ID: <eb3eedc6-35a7-42ff-abce-b5a3fcabcb25@molgen.mpg.de>
Date: Wed, 4 Nov 2026 08:05:04 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix SCP DBGC base address
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com, Sai Teja Aluvala <aluvala.sai.teja@intel.com>
References: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1793775906; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=oenNNRA/kAJF0ZcvOKKH4DQyOpOhFjLGdgBqfsCTK9M=; 
	b=iZcE6JIO912+P9oB76OKzZnGTS7ysuKhG/vzDfv4yFrre9wpxw1gFja9S+iU6axTZnDAFsoLiCNb
	QzZ8HyKlSZPfthtqciMDMpDcOHDtDhA3OrkPcrrkgs33Qa6M6K84fdLJKUmX3F3W08pU95iTai9pOP
	LbsJvdK5SraBH81ISnoBCIdtm/NTS2cpFZUltywjsHJuT3ECZ8/117X1jXgX6eeWDH/zck2H5Olqbq
	gPsrT5bclFP+jbVLIa5QCVVlMACZ5v0BDJFe9Wfw9DN4mqnOcmgbaid5oLP8a4VCYs+DRql4owChQD
	1Vm8eLXoojxlS/jR6CE1GVv1Gpe23PDQ==

[Cc: +Sai as the author of the fixed commit]

Dear Chandrashekar,


Thank you for your patch.

Am 04.11.26 um 07:45 schrieb Chandrashekar Devegowda:
> BTINTEL_PCIE_DBGC_BASE_ADDR_SCP is defined as 0xf0d5d500, one register
> row past the base of the SCP debug controller.

Please mention the source where to verify that? Was some typo in the 
datasheet corrected?

> The status and
> wrap-around registers derived from it at offsets 0x1C and 0x2C
> therefore point at the wrong addresses, and the debug buffer status
> and wrap-around state read while dumping SCP debug traces are
> incorrect.
> 
> Use 0xf0d5d400 so that the derived offsets land on the intended
> registers.

Please configure your editor to use the official line length limit of 75 
characters. That would save two lines here.

Please add a paragraph to how to test this.

> Fixes: e43b33bf8d67 ("Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant")
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index f04dfb0b30fa..c11620dbec46 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -82,7 +82,7 @@
>   #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x1C)
>   #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x2C)
>   
> -#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d500)
> +#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d400)
>   #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP	(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x1C)
>   #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
>   #define BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET		0x100


Kind regards,

Paul
