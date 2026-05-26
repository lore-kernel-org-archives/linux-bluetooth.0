Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E999376494
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810001; cv=none; b=idxhd2DY0ou29ddoSgsRYU5fB5daUoWqdInm87jJiY8dcRldDI+V+rpl2AQrGzTKmcgpPFAm+DuzWT1i/ZvrhzsTkXmtpgTuuYcMeJ++WSRFgtCkhRCoQSblRpcpy5ZPXafWWqXhdFR3ZqaF7449axtLOamF5nS4gyqtvlD6m1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810001; c=relaxed/simple;
	bh=K/sqeHuTc8Csl7L56/I4WNejEzg6If9cJM10MHHCBsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YUMI/5JBjFEn9jwTHHAlHOlLyLvI/98SsCSH0NMyjNxC3dChNboD2z0MPuZiSWwRVS5SC21qos0pEUIupdEBzIz0S4VlcXrmnOBocV8eQrdVmLCASNwpGbvFNQ+Bkj6gsM++P/9AODPwjKf/GiILk4PJ4yfqxHAIANDyu27LaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGg6GWrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGg6GWrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B11F1F00A3A;
	Tue, 26 May 2026 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779810000;
	bh=f28uvSQvjei7xIPLPtxL9rwv4gBUK8gUBl+VKMm6Xng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BGg6GWrphH41Q5ypSkhEVArub+Ifw+yUGDZa1FAF9ztSScIdiiSBMI8+t/mUv7fCh
	 u4hAVEvqnFCqCuMAzVJ8zVy6tjyOv6daWQzLji5sMS7BBQ7Z6a79lR5AQJmUeUsTwi
	 leLn/qcb9zB5SsNVtFAygChZbjN2YHFODGpFfX+zCUG3kC+EZPFx9vlojE4a+juCcg
	 dGls0DPCCUvhS+N5mB6l+z4JSSv9spjpw4iMAxnb8UnbvBLCkJVWnlytCVnutoGpxe
	 qLMoZSZlR3qZoGg6HyIQPvEXhvjEK0kVi37b61p19hP6On+9PTePJchrzCaTBSZNjA
	 u+AS1mTz7ZkiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79335380CEDF;
	Tue, 26 May 2026 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Add support for HCI Event Encryption
 Change v2
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981000613.3867281.18131405745411383647.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 15:40:06 +0000
References: <20260522111540.581113-1-apusaka@google.com>
In-Reply-To: <20260522111540.581113-1-apusaka@google.com>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 May 2026 19:15:12 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> > HCI Event: Encryption Change v2 (0x59) plen 5
>         Status: Success (0x00)
>         Handle: 256 (BR-ACL) Address: 00:11:22:34:56:78
>         Encryption: Enabled with E0 (0x01)
>         Key size: 16
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Add support for HCI Event Encryption Change v2
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b493164ffbff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


