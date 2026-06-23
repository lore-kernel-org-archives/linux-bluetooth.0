Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869E3C73EA
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204664; cv=none; b=FCorLgZoRPGATs1uvDdh/dAW9gbyLd4gFFwQeg7qfoRuFPkvNQqt8oDZbRea7TpzeXlgPoEkbISu4SmTQ6cBKGbChw/66Sci08nGBNaMTI0CUcxs2n0QhI8HsKVxDUKbaAevDG7GPYvPsBtNVNt3oMfSLvFHGt0DsceM64QkReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204664; c=relaxed/simple;
	bh=7ZBFU3s+SJ4w03nt7VS5gUqwdF2fD94T1TmJ+ste/24=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnF0YmjNOYFjwHLLzgQ1EPQAjbo4fUYra+13RhgDQg7oUl+NbuJS9uw956b6ibFIX2cE7jx0MquRiWl/ezgakGWIMqF5CzmJzPJ/r2GP7WUHIva5VRqpw8FukR4iO/ROUv45w+tibYKnfybSa5Z0QczrkVqNUHBOnYpGl0WipNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7BK99NB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7BK99NB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6C11F00A3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204663;
	bh=7ZBFU3s+SJ4w03nt7VS5gUqwdF2fD94T1TmJ+ste/24=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=E7BK99NBSFfoDgEi0+E55/Ugq/nkSsLV8Xjm0ISBg1JrWBeR2qOexlHtrnpOv8HJh
	 5TurA1aAqcBA9C4dATWPFSGbQDF/IE8dgXjkIBqNG+0DfeZIW9jGg8qvBbR2gdiW3w
	 6QVb4A9CjJx7jOhPGY5KlCZOwDGZOD5OZttOKVXsPrPgx5LkGBNNT8QxQoCNUYJIrO
	 yqOopuNeJxF//C/8KtmWrnMjiwMX3qSMWfBeXtnH34YF/yr/j4bu6NVOsEQsABD8y4
	 t4a9c/SJztGpvT/qAOz1NqjPLVG5lCiCwXW0ClxQamomYEuPcLBUidskDPcF5zsrR1
	 OkvAX1zIhtybg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39983214844so47643211fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 01:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ChRuwzo/tfnFVqfaAKd++WlqK+u/hLq2xg/ldkygDh8l/KBMYnVD9WBu8cqHMvLa1KLYcPQvgMP3x0DG+7ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsRygP6CtEBCJlyfqP79/bRzH8FFDF8jLgHHFphJT46bB1jMS
	T23NPydTZqAcSNWvvXa6FlY+a0OJrSUUEeeNtBQ+PBQnWALldMC/9sYXDR9lil75zazPRbQxcSo
	iOLWGltmMG+FXaHM+LVDlsD7mUZ3735yKmiTJCQiAaQ==
X-Received: by 2002:a2e:bd13:0:b0:399:775d:b249 with SMTP id
 38308e7fff4ca-3998bf1244fmr52245381fa.25.1782204662152; Tue, 23 Jun 2026
 01:51:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 04:51:00 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 04:51:00 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260622-bt_bugfix-v1-2-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-2-11f936d84e72@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 04:51:00 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdipmXHoY3eHF2dOJdV=vEqs4y+CZhY7-0mifHGpn3+8A@mail.gmail.com>
X-Gm-Features: AVVi8CeuJ05lk535AklqocMHC8EtaS5j47PFCbCdDRGTLtXXToW267cIszot7PY
Message-ID: <CAMRc=MdipmXHoY3eHF2dOJdV=vEqs4y+CZhY7-0mifHGpn3+8A@mail.gmail.com>
Subject: Re: [PATCH 02/13] Bluetooth: btusb: Use & instead of == to test
 bitflag BTUSB_IGNORE
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 16:52:15 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
> The driver_info field is a bitmask, so use & instead of == to test the
> BTUSB_IGNORE bitflag against it, which is consistent with how the other
> flags are tested.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
