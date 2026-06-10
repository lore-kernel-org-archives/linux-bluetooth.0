Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC85339861
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075270; cv=none; b=GE4NN55WlJorAPsHhA+ZGG0I7lD+HA/LDFlx6fkvE6a8QvpFyQWMmNGQf4PofJIrU6XGQzm+CFJaqUEzaMDl/onvGzApygjXRHA07/T6pf/5VRuOdwqCenBSn7WhG3HPunK6pvXZvDpBZShReUnAwbmoItOQkuJVb9gowcwzYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075270; c=relaxed/simple;
	bh=WC2HgiHNadMWKA/J2f1UCYRD5iXyrcokPN9kxjsuYBs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjgaSH6oJAI9hAuL2SQLfqRKr92U9ASqecklKY1+8GEl8ftyZcpR0NmNX8r3AKorJWRFFe6Nyp0ADDHeUkpNgblQUpAfoI68l/jeQng2wwU5qySkiZpdWUS0gccAyqj2Zo1TGKVHfnpr3kL3E1dIX+n4BYT631KjSOHJt2m5w5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfGbqJQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfGbqJQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41901F008A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781075269;
	bh=WC2HgiHNadMWKA/J2f1UCYRD5iXyrcokPN9kxjsuYBs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=cfGbqJQfXrJX0bwtW1rRrmimrRyiye4GOQvvaW8EMKjl0zTIz1cG5EdmWnoZfC28J
	 bo1038NPzsUu6n1mRwf2fb3afmNDwyH1a5D29TYERYPNnk+wu8pch4lkbynWh9Qvuc
	 pe29Zsizen9Z4iV6M7VT8TWUq+msh7MF4JdkOkT9WAOQcSD0XGXNoVew8ls8OrSwte
	 fdaXQ7aa7r3XMhrIPuy+V2hd6HQySeG3ZHwdKPIaF1PtZ6eKVIr/YiySkDdl/guCME
	 IoK0n9oDycPWIeGiOX5/cgkvhnmiEKvHuBeC2dtmrOgAo1M7ovQAtx3nqCDH1jT35X
	 G8R5pXuZF9HkQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39677234558so65123501fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 00:07:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/uVxe/CIZkZH4VTX9jpLEhEcJCyxmVLt1OSFUWtqgRnP4hYxKFhgZObMmnW6SL9K/XbflbaaXoPzgoAj3XysQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHvcnKVx4rOr/AN8V2JUiude9YEJins49Ai2fT4QT7KatV120
	12+9SdpX/rTZm2Sn0ARBapmK8h379V9IYPNfXT1MKEacvo0gG0QCnwFCVmtdjmRhBYg41wvp6pR
	ltnexDPCCDccPiD1rOiQhqluCN8a9KUE3S+Mx2SHj0Q==
X-Received: by 2002:a05:6512:1301:b0:5aa:6946:6e4d with SMTP id
 2adb3069b0e04-5aa87b7da75mr6052832e87.19.1781075268502; Wed, 10 Jun 2026
 00:07:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 03:07:45 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 03:07:44 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com> <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 03:07:44 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
X-Gm-Features: AVVi8CdfRsoE2VaH3ay6bwgsRO-cbYcktIwDeVADtoZ21l1bi7WcJc4IuV2d_-Q
Message-ID: <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 08:42:32 +0200, Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> said:
> Firmware version is critical for bug triage. Users reporting issues
> typically share dmesg output rather than debugfs contents, requiring
> extra communication rounds to collect this information. Log the FW
> build version directly to the kernel log so it is immediately
> available in bug reports.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---

Please don't send a new version if all you did is collected a single tag.

Bart
