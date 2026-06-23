Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04813CF1E0
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204647; cv=none; b=AABBwvYf/MgILBQY4AWGWucoFdaufx/4DY5crx6rGDzGGAB0FbspPTE2kBZvvoksJBUVVaHyj5WdiXgis7+k8CoxqgZxdADYbjqZzZK1plmL/9wRO6Cl16aMCGGTGxeEnBULVCGkW1EOL2/j/byA1XxSfrqBNxaVG9DX/NHl5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204647; c=relaxed/simple;
	bh=lQrJMG+oRjVwEKTOgm0bJKPrf+fIaCAydYqGu0p806Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAH1whgn+bp6uIEhyGQcdrWAUS4KScXLIzk0oN8UAIRYQHgRpBj4IXyY5MHeuEUWiDX9wnMJIm5Tgh2ft1Dr5cOJqMajRByTFA8rn3BQPVYdxNdPniDPNgrQ6BjlxTByTutBPNuZq1flUIYZJ2/7aFJiofaT77RjOBgh3cCPE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW/woD4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW/woD4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACD81F01559
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204646;
	bh=lQrJMG+oRjVwEKTOgm0bJKPrf+fIaCAydYqGu0p806Y=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TW/woD4iyjWoTNoUb7QmAM80IQq7ZQlz0eo9cOCoBooSI52XotZ/Wiy44SPqlF1QU
	 +E1v9uiIZ7qOxzMFnX4LU/9keo+YWHaJmugkSI257POPrP2XCOtNcPKHFGA0rjo1wi
	 4GSB1p0w3OK61cV7UaCstXO3J0R8qlpAduujf1Pn0oSl+YLmL+i/Q9NsF4QDAysWVF
	 /kG778LGDUzWY9yBl5o7a5KGWEzvflqCsl/bSRBSZrpfq0XWRO/k1SEij9TrG4jMHI
	 qQ7GFELbQoCBmxdK9UNj60Jj01tgzOEDiMr0FqIF1Fk8PBoD851CpFgF8+HBIrt3Q4
	 +F8+uOr3AQ0+g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3998c6e6921so37649191fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 01:50:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/C2YHvdpvrpg1iCE5l/8Ck2+ho0wUVQV5wu79wjW8QL9VdzlNPwMfahgCJoOxjzYkVMRWWMFxXxo/aK4SS2Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEifBEkFZSf9TiKlHROC3klGObhnwJxIgYfe31IoOJUh0GYO35
	yStek1lag5RF/bwDO/GSFpHC+DtmRFi4B6P/C/njIXK5vsgF8NuohhYl0BoLaXhOaweCYsgfd5u
	jV7ZscWwZ2+08cYMUBg703O1FEAayREFdHSRfe5Lj4Q==
X-Received: by 2002:a05:651c:985:b0:396:71a0:7753 with SMTP id
 38308e7fff4ca-3998bc2b449mr48824751fa.5.1782204645067; Tue, 23 Jun 2026
 01:50:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 04:50:43 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 04:50:43 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <xzps6lqo2k2w2onzleg4baycsnzsejiwhhefilk5rt5e547u6y@orl7l3yklhuh>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com> <xzps6lqo2k2w2onzleg4baycsnzsejiwhhefilk5rt5e547u6y@orl7l3yklhuh>
Date: Tue, 23 Jun 2026 04:50:43 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdtBEzmyYfzSwEdB+98AYU3U0doWEGrMsh9TqZ4wLXu9Q@mail.gmail.com>
X-Gm-Features: AVVi8Ce6muOBExY_sx2VA0iK617KV5_AeHGJxiAk_NT7sUmW0a6PpDxvimltQj8
Message-ID: <CAMRc=MdtBEzmyYfzSwEdB+98AYU3U0doWEGrMsh9TqZ4wLXu9Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] Bluetooth: btusb: Initialize @priv_size at
 declaration in btusb_probe()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 17:30:25 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> On Mon, Jun 22, 2026 at 07:52:14AM -0700, Zijun Hu wrote:
>> Initialize @priv_size at declaration to reduce a redundant assignment.
>
> This is obvious from the commit. Please tell us, why?
>

I think this is what "to reduce a redundant assignment" says.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
