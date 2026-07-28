Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDA368291
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254938; cv=none; b=le+O9QwfBrFzL/o7d4LIQ5e4D7XzItck6pKtt+o2mx0MpN3wylCWWtE62iI0yW/LtkIa+C9WxYCgTUM7aKtwSEAsYMKatioJbDPHNrERSXqHFVE4CXoK7aMKB4OVJF/dE6UEsUpn2xJNhjNq6dYPlJz7AaePpZcC4IXiWlyj9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254938; c=relaxed/simple;
	bh=M5kzdAEoPc5rbNRA4KFaC+3yUnwETH5W42yryDQOE1E=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=sTLHQffy6mlAK9+V7DzAvqvHxmZA/xUWc6XrzlezPbKwmvGe+i0bv3Ay8d3SakPWPaFdwRXGyGQbZZnU4TVPzQKRFAn9ojs8uxhvur2mhO5LB+KA8+bIA2jNoegcgSWvc/dFi8MVxHKqI13ckF1HCFY1oioWaesWboz2LCxmWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=l3F46aSm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=P5zPGlB5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="l3F46aSm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="P5zPGlB5"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=l3F46aSmkFjbDMkvZyRLDqImJ+0Lly+fJpq91VYTlIdfGTGI3T3JkVCrm4zLtacaJjjm3Qu/8whd0mKQVnwORd58j/qc6fJxA5+XLExezed9tsmmD74uGbs+8OtTe+t0q3wivfKLXiatDHJgbxa5JQoUxIDX8dpwDmDOXF+isKhbzlj2HIZIrJOJF/tbZ1q4/1nHWo7D4sn9nT93M8k4AivQkUQbbpFjKXWeY/KQIuAzdK71t6NuE3+frkOZyt39DcRrolBf8tB9b847THB+RHxrOUIH9UmfOPMfDXKVITjgg7W6trM2L1zF5YTTn/F/S8L0c1t6SIyd8ogHdNpDjg==; s=purelymail3; d=rcpassos.me; v=1; bh=M5kzdAEoPc5rbNRA4KFaC+3yUnwETH5W42yryDQOE1E=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=P5zPGlB5yHHFcn3IccLp9PNbpyOLLiRLnkBkOfCwxBebxPWXMhDF824GmHB3kh0mYAKqnuUh2V2z1LNtYgjlm6GrzH/5awBF4ueoGX2ZdnGJ3AZ3KiPr+e0Zy3l1XjMtNBMe7vRNaKtdpK6mReb8hBbuJIreaUDAOQ9EWE0vIotUnSVj9R7YNm3HYKRwwX04c8YjB/utJpD8nrjkuaxIbsGixf2otmkbWYseXM4p+XB3d0GQrf4wbil3ET6/ORlMSfEE/jINnjGdUTMgXyRjJTpyJfiNt6Ft/xNzM6CVc0YvQRnda3Aw5uMwlTwlTsBl5dJCVc3XQIHWxr53q5q62A==; s=purelymail3; d=purelymail.com; v=1; bh=M5kzdAEoPc5rbNRA4KFaC+3yUnwETH5W42yryDQOE1E=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-bluetooth@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1239418384;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Jul 2026 16:08:37 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 13:08:33 -0300
Message-Id: <DKAC1T7FWOBS.15ACCNTX4EOFA@rcpassos.me>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
 =?utf-8?b?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?utf-8?b?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?utf-8?b?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rong Zhang" <i@rong.moe>, "Rafael Passos" <rafael@rcpassos.me>, "Marcel
 Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
 <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
 <79D5F3E6-8F40-4422-BB2D-16691E377394@rong.moe>
 <DJRP3YO7Y0WK.20KNRZIMX1CYK@rcpassos.me>
 <F16A2A9A-A43F-45FE-8CC0-44A129360D47@rong.moe>
 <DKA8F33O8HID.2UV2DWTLE6S48@rcpassos.me>
 <133c4858657c55b31affd4bff1cbd68f812de5e1.camel@rong.moe>
 <DKAA9VN5E4DS.2U03T6V5HEAAE@rcpassos.me>
 <1ba1545c318214d988e899a95279b4b0f93bc24e.camel@rong.moe>
In-Reply-To: <1ba1545c318214d988e899a95279b4b0f93bc24e.camel@rong.moe>

Hi Rong,
On Tue Jul 28, 2026 at 12:38 PM -03, Rong Zhang wrote:
> You snipped too many lines. There should be a line similar to
>
>            |                               +-0c.0-[0d]----00.0  Advanced =
Micro Devices, Inc. [AMD] XXXX [YYYY:ZZZZ]
>
> which is the root hub.

Indeed.
+-02.1-[04-0e]----00.0-[05-0e]--+-00.0-[06]--
|                               +-02.0-[07]----00.0  MEDIATEK Corp. MT7925 =
(RZ717) Wi-Fi 7 160MHz [14c3:0717]
|                               +-03.0-[08]----00.0  Realtek Semiconductor =
Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125]
|                               +-04.0-[09]--
|                               +-05.0-[0a]--
|                               +-06.0-[0b]--
|                               +-08.0-[0c]----00.0  Sandisk Corp SanDisk E=
xtreme Pro / WD Black 2018/SN750/PC SN720 NVMe SSD [15b7:5002]
|                               +-0c.0-[0d]----00.0  Advanced Micro Devices=
, Inc. [AMD] 800 Series Chipset USB 3.x XHCI Controller [1022:43fc]
|                               \-0d.0-[0e]----00.0  Advanced Micro Devices=
, Inc. [AMD] 600 Series Chipset SATA Controller [1022:43f6]

> In the foreseeable future I am not going to have a desktop platform ($$$)
I was lucky to upgrade before prices went up.
> so I can't easily debug the issue myself. Hence, it would be helpful if
> you could reliably reproduce the issue, so that we can have an in-depth
> debug. But let's forget it for the time being since your device works
> fine now!

I wouldn't mind helping debug this.
I will look into buying the M.2 a/e -> USB and the PCI -> M.2 a/e.
The bug first happened when I switch from Arch do Debian, months ago...
If I can reproduce it, I will reply to this thread.

Thanks,
Rafael Passos

