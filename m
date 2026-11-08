Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131636;
	b=I8jrQ2RJcJLi4YObJVCln79ZP6YqDVFRdj38Q2jPbtmgvhMNE0sECDbNlfNLdkGP+0ao
	 ibqlsU1UG0kIl3ZVpWM5zv+O/0p3PZjZ6hIoxUwamen7PaqM1bo3Zv5LaSM9NwLy4fpx1
	 Sqz1R7fMUxrQ0ErVmljXL1T3sR4xYHPrHVK1x4AvODENa5UXO1rQOyAMYoCuIVS3GMvZk
	 ys4PaP+1xDUtXhPRrSb73onElemRlILLuepIfjSsYvTUbRnLBOtzCGuT70/WYFJVp6QMy
	 Exbbf4j+c6mX76NsBoFPTumIHa0ndDYXMhmkyzsaFDaBBCREZ21xPB59SFJLzUZGaDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131636;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=xYUHqEdC+dpvDXpiQVAB+ypue4QKrlNxhoc5Z+Agm0g=;
	b=cRYR/GsFq5edUqbR+GV21pLxy3BUG7SeHEZiSodYyqKL7IeqV8vnWWF7unLlGhplQeQL
	 VXic7YW2HfXIRf5+GjF1ozQDa9qBtuzg6/vJT56rRGGSVqNRol0ceVW8yNJMWU9dqusiQ
	 z0DrF6oqvKhkQRYhCKuz0p/hXzgkQk/agiieYbgIdWUm1j5dl7G5Pqz6qsxDIhYWkHSiP
	 hr+nGTO9JltYZtLFSJBCfxGQD8NGY/H/vod1MQ6Mi2XMIkcYOz5FpQXw98Q/rHtsK9YK8
	 y06/nK1jBlM8Jf+5jELhRIcfUfuxv9hHZdpY7mdqkxUSr6g0hY97L32sR8GIex7XOpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=o7OZNMVm;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE27606A31C;
	Sun,  8 Nov 2026 09:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BE27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=o7OZNMVm
Received: from [192.168.2.228] (p5dc55627.dip0.t-ipconnect.de [93.197.86.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 06F024C2F40058;
	Sun, 08 Nov 2026 10:53:28 +0100 (CET)
Message-ID: <e6f7fe6a-28f5-4d31-8f67-c90185a0d5cc@molgen.mpg.de>
Date: Sun, 8 Nov 2026 10:53:28 +0100
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
Subject: Re: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump
 segment data
To: Hex Lindqvist <hex@freenixos.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261108042008.226295-1-hex@freenixos.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261108042008.226295-1-hex@freenixos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794131609; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=xYUHqEdC+dpvDXpiQVAB+ypue4QKrlNxhoc5Z+Agm0g=; 
	b=o7OZNMVmc7pYkBZOla0IL7nqW5q0Wdmq0dHOq2b4biwXz04zUs7dfFXxb0nW/bQtN3IjEYyYHMr4
	974ug0wcgWt6gaeST0NsDN6eT8g+mDLiFO3yihWlugTH5MtNGf98U5FB0wPACGaIGeyBTMpyT9XSQh
	n8lhmItpHkEc2L9XhJ5wSeNeBDIUkDV2929LKtoBwwLAoKYI5nbJS7b7DdLZZTirA4tyHisMnNHgJN
	37BaORm5GUALyV1KbMlFg55FOi3vfM5Fk3CQ4qPJQ0p2imat/5yNr87uUwCCJO+65e+5/I8Qvqy+7M
	Uywvk/0WDhjnbKRKt3461rsmc3nYH0Qg==

Dear Hex,


Thank you for your patch.

Am 08.11.26 um 05:20 schrieb Hex Lindqvist:
> struct qhci_vse_memdump declares segdata as a zero-length array in a
> union. Zero-length arrays are deprecated [1], so use DECLARE_FLEX_ARRAY()
> instead.
> 
> No functional change: segdata is only used with offsetof(). With debug
> info stripped, btusb.o is byte-for-byte identical before and after,
> built with GCC 16 and Clang 21 on x86_64 and GCC 16 on arm64, with
> UBSAN_BOUNDS and FORTIFY_SOURCE enabled.
> 
> An AI assistant helped find and check this change and drafted this
> message.
> 
> Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Signed-off-by: Hex Lindqvist <hex@freenixos.com>
> ---
>   drivers/bluetooth/btusb_qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb_qcom.c
> index cc4cfcde2afa..97be9078e045 100644
> --- a/drivers/bluetooth/btusb_qcom.c
> +++ b/drivers/bluetooth/btusb_qcom.c
> @@ -533,7 +533,7 @@ struct qhci_vse_memdump {
>   	__le16 seqno;
>   	u8     subsys;
>   	union {
> -		u8 segdata[0];
> +		DECLARE_FLEX_ARRAY(u8, segdata);
>   		struct {
>   			__le32 dump_size;
>   			u8 first_segdata[];

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
