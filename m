Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925F33120E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780167; cv=pass; b=egpxsp+MQbPZZZ5XAwgyHSoa/ivA32ml+bmOwdLU60jDO1vB9/bWDNSxgzLgbGaQvnvUo5SWoMCTwWupOM6LlJGIX+GdpTFtl+vQq1xddBBsAn9yNEKVwzKnwrvvByBTULDGSJif3tUcPQb4RdaySXbDkghfgKuyX6A3vUdQwug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780167; c=relaxed/simple;
	bh=3SA5XxObW+CXDbnmsHJjXkPh+navSFbin+FPPF9SL7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/0u61/dDg2G41Hi0vxFvFiUHL27IkAWX83UQMyfFd7teYG85G3W2L3XHIcVzlp5BtXqKhM3eLY0DxSbcfepPIqHGrekQkJ0H8B3GufjLeU5HfJKjhLavC1KZcLbVarZhDswQDwJovhy9lP8PH6XxOVXIBhC6yJvfKRNhCjH8Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpDTboA/; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpDTboA/"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65e15fb394bso1263365d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780164; cv=none;
        d=google.com; s=arc-20240605;
        b=IhH04VMfWV6BrAa5+31Frduk5nwUYVEKXq9hZgd78WSYvQ3YpyqLJKNUSzR6nKcsAr
         yF2shNLJfqlHBS/I/WV7GGSauQGBvIs+vciPsNt4iKFTQC4nRyWDKZR4LMv4z76khYmD
         UwacKQ9f580DjCONlglpfPoNyGC4DLPNXkwGJIQQJEd0AmBttg38smesLso2zo2aBQK7
         V5g4g3/firAPX2UyD73xv8sqsEbliHaUQykRFopCLrZ8PjS/Yun1A5rBtFYSU/aBxGZh
         StnJd0flYkxJ6HEP1oWeiiqUpFGYP+4VG7ZKnAPKgv7+cjqWCiSHC4l7rnFkmBybQwSV
         W+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yV6OZc/yg9w50Z09VZfQDJlVJUab6QsNfGEhw7xziYQ=;
        fh=B2UDgDEIiQklVr4F5mosqBE/TrQw4Eh5fAS12/LQFos=;
        b=hLx20vFnpI0amYwn98oX6CxDMeusNWhZnDXCS4YgDUIvGPwkWQZCGhFnVyTAINRR8R
         EXZjGfbTwO8pR+BHUj70Jid6Ws17Twepf/TvTyK8STiF8KwittEEzG2JhKh5/WSJn6Zw
         9QUa88nOmsm1j+L4zaQDkW8S2pEAXoNSJY1cTbAcFWxiLAM2xHCaQA9j88L6hVVGDbxN
         5oqWwr+f3OzDkvSCgAyurzARU4zF1ThNFiyS2e0kqb+yz7Ud3l25zOwQLGIdIil5Dc5Z
         EstEu4WoxB2kNRuosyiFqLigMk1SfMbX/wcWlTNjNMQZE7UqyTsry+5+CYtnDwZreaeq
         VnNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780164; x=1779384964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV6OZc/yg9w50Z09VZfQDJlVJUab6QsNfGEhw7xziYQ=;
        b=HpDTboA/A11W9aP1xMXcdS81bXf5wOgm3xEIRCvswbjc+5WbnbYnDubaJujK0NFvEY
         Mpu2/ZtT0s3TaOU8+PIXQHS9WaJ+Y9N+XI+jkijoClbxvz2gtrKmf6AmADPsbxIoXU8+
         N5OMoFFY2kXBto5JdmEWupJYTDS40meS01LBJULnh6C9X96hMYbMw/lZ/kG4n6ZDacUQ
         OV4q4DiXa1SNsCJ9ZC7eqsfVbFBc5wAPq8GTFPnHVHeL0G88PcNF7iXjujgdsIhhTVAn
         aff+CAWuMHjleAQvSYxFKwE5d4WlnI0nNdk8/9Khpe6UcMEjasay0dEKF0DsDEC6Ora6
         lRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780164; x=1779384964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yV6OZc/yg9w50Z09VZfQDJlVJUab6QsNfGEhw7xziYQ=;
        b=k693NIysjbpaDbqBH6ecPtjw2C35t2EuG7VE1NxjAoQlVuL78MZq9rDbDcVSzLzx0B
         8GYkL4zwY0BgGG2996ODDVH9tzuB+PrC4IN7xMg8uM2zmwCeBlX42HkzjLMseJtwHMF6
         8Ag2wrXXC8NwV/7lEGCAro9UzRO1QcwPxYsH6rhQ+28mZyv0dGn8TMXnyVSWdy9cjYkE
         neugYgLfP1scF1U3Rth008G3PPYKpxQz8UmIyXw/DLo7iG7ssVfyIQ/wtXBzFt3XqEui
         BI7/0H9yWpjG2V3gNfl7/6MAcr9hkXjxgFL7mQQ8Iq791TIHdruv8ekCFzG+kzvdSFnl
         7oww==
X-Gm-Message-State: AOJu0YyVEEFykY3VP3AHj7njuB6FyF2ljznf2huLTMJ87SRDogzEiI97
	s9mI/EZDLB1bbNV/X4CLVaMQo8Bqtf7/Z+++Vwc+X+nrMms1tGp/8XJPo1uOo5TdTyWY7GdXjIu
	0jZKIVB05rqGTtQRlX0ylUo3fcpnc9Mn0Mx/QOZY=
X-Gm-Gg: Acq92OESTsbhCntPXTW9m9zFhIeAImX76lqyNk5tI0YZY2OPtF8NmOe/h0WrTiBl5xr
	NmjS/7Sa3bs74Yt1QeVd1ixsBOrcaeHdNwOcJMDqxuG0LxX1a4B6BejVCa+TpeO0Nqlj5pYWSLt
	iOFsP+tE8RYmZz0SvD7wm0nqBj+vzX10tQiN1tllyW6UMHziDMH8+LOYaWrjSQak4o6QBi47ble
	36QdPaTAM21zGUQB3tnWhCL2nhmxLqyxwows6Z+2/v2wJ3zORm6AT2PwuiaWRM7RoVWHFn4bWiU
	RMEFARoKgWVkHwMQQ5K6sNcW1JwonnNxzmsDwXvLBD1PKQdN/iaq+ul4CCZyX2gxdd13eg==
X-Received: by 2002:a05:690e:148b:b0:65c:7306:e17e with SMTP id
 956f58d0204a3-65e2283781fmr234493d50.44.1778780163787; Thu, 14 May 2026
 10:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514164913.3123671-1-2022090917019@std.uestc.edu.cn>
In-Reply-To: <20260514164913.3123671-1-2022090917019@std.uestc.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 May 2026 13:35:52 -0400
X-Gm-Features: AVHnY4JjrM4Wnr83VigxvwJA9bSWkTC6kBEuw7C93Kf3Zo8QuaJEmUiQSY2M6KU
Message-ID: <CABBYNZJ+qJ4RfRz3W9Uf7Rs5kmyJfN_oqD5o8B6_eLLja8nXpg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel: Fix insufficient skb length check in btintel_print_fseq_info()
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2026 at 12:49=E2=80=AFPM Quan Sun
<2022090917019@std.uestc.edu.cn> wrote:
>
> The length check at the top of btintel_print_fseq_info() verifies
> that the skb has at least 66 bytes (sizeof(u32) * 16 + 2), but the
> function actually consumes 74 bytes:
>
>   2 calls to skb_pull_data(skb, 1)  =3D  2 bytes
>   18 calls to skb_pull_data(skb, 4) =3D 72 bytes
>
> When the firmware returns a packet of exactly 66 bytes, the last two
> skb_pull_data(skb, 4) calls return NULL, which is then passed directly
> to get_unaligned_le32(), resulting in a NULL pointer dereference.
>
> Fix the length check to account for all 74 bytes actually consumed:
>   sizeof(u32) * 16 + 2  ->  sizeof(u32) * 18 + 2
>
> Fixes: a7ba218a44aa ("Bluetooth: btintel: Print Firmware Sequencer inform=
ation")
> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> ---
>  drivers/bluetooth/btintel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index dcaaa4ca02b99..114a8beeab92d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3356,7 +3356,7 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
>                 return;
>         }
>
> -       if (skb->len < (sizeof(u32) * 16 + 2)) {
> +       if (skb->len < (sizeof(u32) * 18 + 2)) {

Or we stop doing this manually and the check the return of
skb_pull_data, that way we garantee we don't use its returns without
checking if it return NULL, which is the whole point in using
skb_pull_data otherwise we had just used skb_pull.

>                 bt_dev_dbg(hdev, "Malformed packet of length %u received"=
,
>                            skb->len);
>                 kfree_skb(skb);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
