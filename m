Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6033067F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866925; cv=pass; b=opuM1M+fxwDhtYE/kIg15EJqBmGfwg+CwU66LRhVKDpv5N5nhTBcFel+9e1hJMx+ym5xb80+yIRcbFMW5VwwhwyPzvGvT6d+b2C8H8R4wiL3B1ASloLoEq0SV853qTCdJkPIDPkZeh9YVUAP+HvoiXaCgHNpz5TdcqjAmuq8jfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866925; c=relaxed/simple;
	bh=8LBpJUX6sqfl8pjZj4Eze8zvI8svMmsISofMQpIeJS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvEUKhp13PTgJG186SXtKFngpZlFXyCNGxcnwZjAUFGRuXAF1+cZ2D179Ces7R8KqHAhucM7Ysil+92uYVZh7lk6z/Y+gNbDec7jgUGXjbbFVImN2zLhnTRiyiylKsfb1aOn4bCtC73E54/XjhIU0GffuPFJcESyAj/v0aqe1xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INu4H3CS; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INu4H3CS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64aea64bf15so4375428d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 09:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771866923; cv=none;
        d=google.com; s=arc-20240605;
        b=g5wb4vlOn6IBYig0TYAK1UC0oClAWMgFYTPlkllJ5CFtSqD5MaD4VkOLmWBggH5ZOI
         5anAqdNIXhXePxdq40aQLCkMkP6a+gPAZXg4G0yCIupCWu8ZpuG38YrrpR7AM0DuRwUq
         u7+ouwCB5kEVwZjucLzBgN6CR8QUWPSIC4nX3sSs/jluZO54pcxlW4MJqboI0CYINBAS
         sm0Y4n0gdt99/3KC6FTn5hToSNX/RZZbArw6sP4E6R5ihr7309JzzDkKzFcNVNtlDJN0
         VWx0YBH9JvDISCmMImKN1ufY8NuxBW5qQOrU7qhHXdqP82HjmlNGkm6sNrzKYrE13JKP
         frkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RKw9FpYNJc9uXgQymDa8IbRRJjWafX+WP6kcs7dQC/k=;
        fh=9gkv1ylc8Kr7SGdXa37vqx4HvMaOCKwNAYgxumIeplk=;
        b=laBpfof2Tv1R+kXJ3fIYB7rh4FTBgRWD2Dbol8jtp5SifVDHI6sxq2E9UmbIyZWL9f
         CnmsCx0PHExsGNMMuN2eB46xd9NGHZZeoQ0vi+y3Ops6KQVT24RK53YHZ7s6NqaKRd6p
         DIxUSjLp0mFj3DoikanlvMVEyKSF+SyJArQcfhs6x9Q1JNUJhOpt/vCeTAs5XYrcDPKN
         weIK5rAPp4La0wyTDgBcLh7rWjSU3VvlwQPl4rJ/R7QGJPr/11qmeYO1fIvkX31mGro1
         S2rmuTzUySwSz6wrti01X65T+XqWawVLN9D6/1kwer3C6yVSlHHXvmq68isGolmbB5vp
         azdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771866923; x=1772471723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKw9FpYNJc9uXgQymDa8IbRRJjWafX+WP6kcs7dQC/k=;
        b=INu4H3CSB56bfLrZM/GmKdsyMrboqTueNjyGgnziEJRyJU6bmHhC6CZ+BONFOA6CTW
         z4no6WxpNAJzPqsObpnBRVuWveztosDl+bJXfxDDylMKOsgfMEf1qcU9Tjk6/KavCG9y
         5TGb0L47TNu/LpP31I/xg8mRHrSZya9PNjhgJCcOxVdrqXCm6ufsTd9o4Lfhecf9oiUz
         4xcSFP8OFfe2h25ZVyLdZcBF6NrcvliO9WgD57tSLcKj4D+8iqUfQsOTyBjYhSdzAED6
         4TirsMRYuz97EowrP0Xg7HqlZxsQg4OiBl4SQfwSrM8eDgimd4q+TBszKpBExf0LStTl
         iWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866923; x=1772471723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RKw9FpYNJc9uXgQymDa8IbRRJjWafX+WP6kcs7dQC/k=;
        b=HScstOBFta8ZO2rVxrWSb8hqhBpeAROuuR8wIXkleA5B7GdGNL2zctcLKl2zwE+O3Y
         epwZd6x6+FGUqCJE2AUOO4uhn44WeoQIKL4AHKwSNaQb3gnmFJVKhG+PJZIxVKSVyV67
         ly2AW/b7vI+BwxnFZ1kN7P+LdI53rYBl3WIupQcjFT+qMoPVr3wyqpVmd1S7T7p/SbkQ
         U4Cg7OXQFN4B10Ttt/jUDGwenHFpdRLHXgntRYk9RNx1Rg8tRMritlenO4bj5rXfw5OF
         SR5lQqWdzJE/l+8gLUHtZOHQ8OAjyDrT+jfJQl0USxn3W7Vef6ntPEYfloZdgbDeGIM0
         vt2A==
X-Gm-Message-State: AOJu0YxtIufSOcjf4nQZgSPcvzT4Mb0vqkhHdlTaTh1g4Dc1RM+/LLht
	ZjbRLo1j95TvDuAOSLmQHGV4AmVlN5NkkEeJPgg3yKT0OwgQB/Zat414jP48CgmydhSt6m304Xt
	qEIvz6flIK/FJ6XPXHynRz+67uQ3E278=
X-Gm-Gg: ATEYQzyWZFsSm8fFuIz87Aa4aXu5lZ0FQW4QYYAWMBk6y+WYN4C5uUsPPVrKdzsWpcP
	Q2uK7xY5RIcW/lY8/XWRe444LSa55Ky1qMwd0ppaEC0zbN08PGD/nz2PmI0WOph5Ws5oP7MlAAb
	DhFVP1P7adlv8Zw5yRumtTgC3ZxLfwbBvs6gKrNoU9Lt8Gd3aqq9dqgfOdAD/73PyOGxRtOg3Wg
	SdtNUCyyRIP367sXTBVkbi3s9GGyzJN1CKdcKSy8rEsg1IiGWzBWbZHnnDRRLhtuEcbV+N9zc8I
	BcMIOBgmLSRCzreV4A/chDNAGBW9e0UpNsjYG6yxvfzMgN6lFTjFFbJpfDLKjvzCNp2hjQ==
X-Received: by 2002:a05:690e:1653:b0:64a:db34:8506 with SMTP id
 956f58d0204a3-64c787d6f54mr5993715d50.17.1771866923359; Mon, 23 Feb 2026
 09:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223172104.167471-1-kiran.k@intel.com> <20260223172104.167471-7-kiran.k@intel.com>
In-Reply-To: <20260223172104.167471-7-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Feb 2026 12:15:11 -0500
X-Gm-Features: AaiRm51kMOhNf3ZSK1yWK3wudoNh7thGWglJvoB141gVbQ9wrvjnCuOlFT8_GhI
Message-ID: <CABBYNZLa+=ynikAJ3ivM5c-Gu6zbg0MiiSuFReGRL5hTSu-ExA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] btintel_pcie: Add support for exception dump for ScP2F
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chandrashekar.devegowda@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, Feb 23, 2026 at 12:02=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> Add device coredump support for Scorpious Peak2F product.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.h      | 1 +
>  drivers/bluetooth/btintel_pcie.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index bef7ea84b1e4..b5e7f0aafb4c 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -60,6 +60,7 @@ struct intel_tlv {
>  #define BTINTEL_CNVI_BLAZARU           0x930
>  #define BTINTEL_CNVI_SCP               0xA00
>  #define BTINTEL_CNVI_SCP2              0xA10
> +#define BTINTEL_CNVI_SCP2F             0xA20

Let's document these definitions with Marketing Product Name/Platform
Name e.g. /* BE2XX/Panther Lake */ to make correlation easier.

>
>  /* CNVR */
>  #define BTINTEL_CNVR_FMP2              0x910
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index d0cabf4df7c0..d903460bea76 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1234,6 +1234,7 @@ static void btintel_pcie_read_hwexp(struct btintel_=
pcie_data *data)
>                 addr =3D BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
>         break;
>         case BTINTEL_CNVI_SCP2:
> +       case BTINTEL_CNVI_SCP2F:
>                 len =3D BTINTEL_PCIE_SCP2_HWEXP_SIZE;
>                 addr =3D BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
>         break;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
