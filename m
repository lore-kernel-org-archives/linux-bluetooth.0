Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BC342C9E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056646; cv=none; b=Uq8HJc7L7xk9JXtDoU0GKZ7RUS5FZL0eNf3kbDMAqMso8eJeWciY2cPfX6eqC7N86CLbm/4OLAETy6+jngOhCqsgP13hWhx8ybU/qZxu3PHTu4Hy40yqgqgZ5tnJwYW2GzFmFFN1RZpMJBOLGkNc9yswZ3AMvLYKVmDmhrf3rLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056646; c=relaxed/simple;
	bh=o69B+fXurMklueArkIW8wxDmKmAo+KpxoH0wTV2I5lc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DqXlc67y+2QZGYjlI5uZ46xhvowdpAHvgmtvjLB2fLBo0HuTfSPe4jL9VdQo3Pozq94MKxDXRunktMWDz4bEvBQUqw3CftFptxy+WO+EShWZkPnlDsy2L8UgiFm024/41sSbwt+ro14lzNjtX/UX1Ph1xfpZlqXO0fdx/bNwsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocaaNTBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocaaNTBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39E4C19425;
	Fri, 24 Apr 2026 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777056645;
	bh=o69B+fXurMklueArkIW8wxDmKmAo+KpxoH0wTV2I5lc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ocaaNTBNQGqMRPmW92DEEz+zagDLReYnpOv9QgAexAyT2ViGd6QQcFoiKakBN+U3F
	 zITaX8s64GSzyqUzSg684l7WGBIDb/JfHJNekB5CCpw0KzfAoD7fqPd2NXvKOwzkfM
	 DSYVIH3MnIXFD9MJTH3xd774Ib/4vdLmsJmd85wxNxwtgTse6Oi3M1Rcq0K22sE3Kp
	 1ZCFLLIapSNSbMYaun8evZ9Yk9ZvT93TrigWW2cAI1BxG7/XNg3897LUFfWBU9p/ot
	 EdDmLDZPAbcTa369LnpvxPzMrgaT3WnIKW4OyYec/qpPo5jn67CiHaoD7QAoOFkw1j
	 sL5Gg5v62XgwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD1738119C3;
	Fri, 24 Apr 2026 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Realtek RTL8922AE VID/PID
 0bda/d922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177705660605.1662901.2731594831207171980.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 18:50:06 +0000
References: <20260424120928.397758-1-zhangchen200426@163.com>
In-Reply-To: <20260424120928.397758-1-zhangchen200426@163.com>
To: chen zhang <zhangchen200426@163.com>
Cc: luiz.von.dentz@intel.com, chris.lu@mediatek.com, pmenzel@molgen.mpg.de,
 floss@jetm.me, sean.wang@mediatek.com, en-wei.wu@canonical.com,
 Zijun.Hu@oss.qualcomm.com, chharry@chromium.org, ceggers@arri.de,
 johan@kernel.org, linux-bluetooth@vger.kernel.org, zhangchen01@kylinos.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Apr 2026 20:09:28 +0800 you wrote:
> From: Chen Zhang <zhangchen01@kylinos.cn>
> 
> Add the vendor/product ID (0x0bda, 0xd922) to usb_device_id table for
> Realtek RTL8922AE.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
    https://git.kernel.org/bluetooth/bluetooth-next/c/0cbf9408fe30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


