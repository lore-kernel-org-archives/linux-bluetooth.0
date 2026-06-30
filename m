Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA3360ED7
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844500; cv=pass; b=qeAuIjd74Dx6KBL6GiwS37/wxawmLgByXaN/EF8Wc6A6UCc/Jlqe+fKi6sb825/zUy1ViyBjwFKUcs/HYtqZqUt1Xwpw5vUSr4vQRZn5imbx7mcjfSgw4PrN4EM4pmPnr3hgcCkaJ5WK/GfEar8MfDU0CNJZqKqezs3w36M4k8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844500; c=relaxed/simple;
	bh=k/kJK+A0ar7zlgz1BcIV+iIoRKBUnXRWdLpvqIcWvUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYfeBYza3SXAeKzZlWWNFaazw4hw3uF5w6PAI8jVvpVJbzTLMWiszUhUjEKubTp1uW1XLhvssdLOJr0DY5S98xCQgU100UovGbYkvK7NW05F2n2ecMJmq+LqRRbMtFPMUrDQjc0pJPLxadQQ4pAy/jmyFDVwnG1OVd2CTeIz5hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYiXf8Zx; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYiXf8Zx"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664c4a04081so1772398d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782844498; cv=none;
        d=google.com; s=arc-20260327;
        b=IM3twZj7T4Pc0N7STs5Pgph/vXJCbbx7OQq8f2jd0NkFAyCJeFzh0qzlTPlYQuM3UD
         1ep4nvK3sS5rWdSDK8V9VZOD7USfO3WdgLniAGfaghu3YtW0x8yS9C//7Afl+1MnKDG6
         f3l1fvaGjIk5YfQCniHYj9K2WvlZZRy9m+cn5FQdQuJkZ3lFa6o63O+okfMrVhFf9Hvj
         Dby28egCH5BEI6xT0rxgLL+rVH80RofMmX9U7ioAjQUPz1yxW8MqPgsYTgEzJMq+ABN9
         Hm73/AbBS7pU+2nL+YgQOAeJ3M/v38jFgiMWZEX/2AoAGrSZYu3ChSrLfNkIMo0TiP5F
         RrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0P6V1vru/BpZh7+3bOaWUN1FziQljT5weXXg8OHLxPc=;
        fh=TxHmgKhQfYbogoK+vmJQIDCo2t34N8xamZxfQlSL1ls=;
        b=S3k0nNC1RlN2kZK7157zHrbSKfaQENHEIpOsVr06IuYmV+I5aD8uX6r45p0xibjRA+
         FLwkKlA8X0ku+eIh9JbOhDBa+eM6wXzJTjWwqgXt5SpcSEYciQ5HD4O92KPooVXtIwy7
         ENvwshDGHxgzKqy4qmOm1udjvvUgESLb1r/E7ZIiJXKPEJ2ooYKm+67uJHZxX1XB9dwC
         RDN8SECuk7CkvxurRAnFs35HoFo75cvQcw+h01zjXc3L7wlgkjOr5BWqe1d4F+BfuS8I
         m6HCbu+dSIasdJBCxODK159tPcLmHU7a1l/v8P3JQG/UnF7Qx8MDgLqClm9DhOa0WHpd
         H4fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844498; x=1783449298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P6V1vru/BpZh7+3bOaWUN1FziQljT5weXXg8OHLxPc=;
        b=cYiXf8ZxgJ26h6xaH0LqqgpdbGuxBsadWcrJTO37bt93VA2k/OvYWv7+JLBKcw+Hsc
         eDIWK1RVyl9BMGLOdHx4sfadF7rsMFzBEvdKYLeRRe+WTh3UL+dKwVR88ftho/4cPYec
         +Yr5+/T9k+QAXORrp6ILcvZfTDkOUy1v8sDjCWZKQjes51f57OM3YC97hK0poV2uIcDS
         hjZQyqVCxrE3Uw8GoUUorZT4lvtGMOTSo1C5YBtTtToNqecqrX9FhakUQuKBDYreDCXL
         FXLOJqeEoTipwRo7hQ2IdKZwyD6gMh+jkFxAl0aG1kpKLO1oyNoNjEemB4Rbg9vL6iUk
         D5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844498; x=1783449298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0P6V1vru/BpZh7+3bOaWUN1FziQljT5weXXg8OHLxPc=;
        b=k9JykabcE5v8OXaotw7v+AYGL5qVunSlGeURODIGdK8iQHkRAUgPhMspX6AqeKJKKg
         Lw8h9yY4800OzZvK5BhEhBZCIf8EvqLXNQb+pE/gSutFzIJqWtxRFOHZaAtGVcl2d7bu
         6oRR2Cfg19w07mLW3rRAlQKVr366kZE8Ofyy0B/xNRqa2af3MPVsu7EfhlJAPDoQPugK
         mtWkc6lsy4j3vPFuRl+R8RUIAW0AqBsJ3+uzdfT+UNSrvfkqd50mBnNF1INCaHbc2RYc
         7mLFCyDrDB7zL/BYy7ZKC1ny12XrdPMeddJcYo2fydkjyrRJki2+syzT8WGV5XOWNSHu
         4awg==
X-Gm-Message-State: AOJu0YxV2+gI4HiUILcJh11IJazMZCYoSdAr5xu9gmx7ThACGIJJW20S
	2P2mU065aZmMGufyld4DV774T1QEmUHhlhEhca4BbBvBSo0B1rI+Uw0xxR7KMrMj1dbbL5Zb2+q
	2AwjW99WL2DfuZ12gVC9W5GNJQpYMkoM=
X-Gm-Gg: AfdE7cnbu4RQRciEBacaXaVr2xfNVnFbC/WBSeIB1FVAoVZc5UNm+lDpwt4JZfacrlC
	WDK/BP1Vq7ZBCPdVJw2zYsAwrxJ6K2vOwqguxGUySyo31YDMKwu7FPb4TKHg6/V3aFc07za9r98
	BTcVIPUkkQNXmtaI7CuPphbSgr7k+uxW6196N2dGneUuc3SiMsaHiR8SbJgvtjkEzvNA/GIwLfS
	pmKY7xnTTok0oJi9KQ4wCoqg81VnTWu8b4hTEvluOuxVS2twntSUlARNdvxHtukXioJyNhX3/9Y
	rNoUBtn4ghgAgy6vE2rFPbFe5YnUahaZo8o8dXI2mD8XRw/vErJjwQHlGVA=
X-Received: by 2002:a05:690e:1c1a:b0:664:bd5c:6e63 with SMTP id
 956f58d0204a3-665107731e5mr1578434d50.46.1782844498357; Tue, 30 Jun 2026
 11:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Jun 2026 14:34:47 -0400
X-Gm-Features: AVVi8CeVAU2A7qwyR3k24hLptd2td1q1UUe24TEg6oUnxgyFHnfvEubTdbgZYT8
Message-ID: <CABBYNZKFO-6XcDa5AVxybcGx9-f2egx98UdAk3dprnnQV_kLVw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/6] RAP: Move CS default settings
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Tue, Jun 30, 2026 at 9:39=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> This series removes CS default settings (role, cs_sync_ant_sel, and
> max_tx_power) from RAP initialization and configuration paths where they
> do not logically belong.
>
> These parameters are measurement-session specific and are already supplie=
d
> through StartMeasurement. Keeping them in main.conf and passing them duri=
ng
> HCI attachment introduces unnecessary duplication and mixes per-session
> configuration with device initialization.
>
> The changes in this series:
>
>   1. Remove CS default settings from main.conf parsing and configuration.
>   2. Update bt_rap_attach_hci() callers to stop passing these parameters.
>   3. Simplify bt_rap_attach_hci() by removing the corresponding arguments=
.
>   4. Remove wrapper API
>
> Changes in v2:
> - Change title for patchset 2 to reduce length
>
>
> Naga Bhavani Akella (6):
>   shared: remove default settings params from bt_rap_attach_hci
>   profiles: update bt_rap_attach_hci call to drop def settings
>   rap: remove CS default settings from main.conf
>   shared: replace the wrapper API
>   profiles: replace wrapper API
>   shared: remove wrapper API

Why were these wrappers needed in the first place? Were these wrappers
necessary initially? Are you trying to avoid making too many changes
at once?

>
>  profiles/ranging/rap.c     |   5 +-
>  profiles/ranging/rap_hci.c |  27 +++-----
>  src/btd.h                  |   7 --
>  src/main.c                 | 127 +------------------------------------
>  src/main.conf              |  24 -------
>  src/shared/rap.h           |   4 +-
>  6 files changed, 13 insertions(+), 181 deletions(-)
>
> --
>


--=20
Luiz Augusto von Dentz
