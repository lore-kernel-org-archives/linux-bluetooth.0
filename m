Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9C36F41E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636875; cv=none; b=kKvYMqakq5QVDlcMnY+HMQ+GYwqDjKua/ybPEFpAFCIdFeE4xxkv3hWTMtN0aLP/USTZKq9TaIpdYJf592PhPXFMNK72zMJHwVb80gAOKPnE4Z4vfD4Fwgp2jqYdRyP7MZ2IrUdJMvVCd1dAOWn8gQi0ggB8EzP3WGCp9BOv6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636875; c=relaxed/simple;
	bh=0svfkYq0Zu9GEiXUg4Oim2BN8XI+oxDVGNLEzCJcnGo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXYeEBgE648q+qogm1NncjXL/+qTWD4ZBKQ3Ix1qvaTvrG0U9SQexgZZeDmCol8XTxt6kw3lrXZT/gOeLn2MYv+bwYWWsDz0vDGGNpycdJ7CSG5pQ1xQb9GBzSoYySsMHulPZYxztXomMIS6VTuiT/g0eY3DKXSPh+wyaxt9q1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwSCV79C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwSCV79C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D1AC19423
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770636875;
	bh=0svfkYq0Zu9GEiXUg4Oim2BN8XI+oxDVGNLEzCJcnGo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=qwSCV79Cv3hUzwV3IRAzyju31VF3KYpqVyvyFdhLpMsw259EjNn0m0eeP6TJzIwF4
	 LQ5i+bKpON8T2HyuqJiapXF+oMDPWF8eLXAF9sV1Rgr8fEr6BVLvlbJ6doGfTbVo8F
	 8N5+YEOX3PG23FfeBLodvh380dl0G2X5ERK4nBqswr8wQnu3WtQbgetV+wwMlUAP3S
	 VRtrp/iZWBP+B5rqeDPUGuJbsO+IBCzIrnsPmgaPvNqPLroI8ca8aBY81pFXTXZDl2
	 /atVsYIABAnARwa2fMiQN20Mj9LHgvAmOY10KtJAxbzNoKhNNRsE03w9mdmRq9ORCD
	 BLKIURHDxah6w==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-385b5174f54so30505971fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 03:34:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5qQahPERbiJs8OdquqrX9AkdepaelgLvE3wS6HqoDVV2FEl5WqjWfIw5Vv1Ig3QCv8Bg+5EhU/Za0lZ1bmQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLHdBldqScQ0pP5lASr+UX3Q0EJIVIkQ3hdboAgBkKo5WnOoB
	arGwmO5iOPB+HUDuVoo2N2gMtnM9Ocs1lGPn6YGp7VRq0ASjKhBD9om0S39NXo3kiwgMccwZxDL
	O6gksu8NbiAdmlwcbox/zBDPaFECPqYfXBc25rJb6Ew==
X-Received: by 2002:a2e:a9a3:0:b0:385:f547:184b with SMTP id
 38308e7fff4ca-386b50f88a3mr31521431fa.24.1770636874305; Mon, 09 Feb 2026
 03:34:34 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:34:33 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:34:33 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260209080613.217578-3-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com> <20260209080613.217578-3-vivek.sahu@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 05:34:33 -0600
X-Gmail-Original-Message-ID: <CAMRc=MfT7ourMH+ShJpnBAjv_uOb_ds0rxJOYaz_HsoT45dJYA@mail.gmail.com>
X-Gm-Features: AZwV_Qj0eNqA-uOUImUdwSnSiYzynfvlGGokLBE_AhA6KJWLRXr74D8NdOnlBmM
Message-ID: <CAMRc=MfT7ourMH+ShJpnBAjv_uOb_ds0rxJOYaz_HsoT45dJYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: qca: add QCC2072 support
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 09:06:13 +0100, Vivek Sahu
<vivek.sahu@oss.qualcomm.com> said:
> QCC2072 is a family of WiFi/BT connectivity chip.
> It requires different firmware files and has different
> configurations , so add it as a separate SoC type.
>
> Correct the sorting of other chipsets for better readability.
>
> The firmware for these chips has been recently added to the
>     linux-firmware repository and will be a part of the upcoming
>     release.

Something is wrong with formatting here.

I would personally split the sorting and support for the new model into two
patches - without and with functional changes respectively - for easier review.

Bartosz
