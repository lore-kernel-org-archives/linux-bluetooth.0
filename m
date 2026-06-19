Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A23B6347
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884214; cv=none; b=kHEkWuvnNCRMzMdmiS9kORSTQ9ZBO5/ts7a67KAzk42kF/wn4ibVLB9bIcgkSokSY3R3Z0kp1tXteC2CPIDJFehHOae0XrCZoXe7Qq/bRIB12lFnnU6ix6pHqA8eYTVbFDv1M5gsuXiAFmECahqVfgOBo+irmrtc7laindzdWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884214; c=relaxed/simple;
	bh=n25T/jRASfUR6ORib2eTNpMgY6sigjk2HULyG7mUtxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3BeF0kbvzKXH1+ava+w15dd57HAYSTWJW3ea0ShKCx+L95zVDxIrEUtzHMlixU2eTb0uDm4/gpXKEJHGWfeXfrxkmZNYX/561KZcFv1sAqMx9oR9K2APX6tEh4oNUmuv4d+FgVC1qqBwRbcJ4m7ja25uhxJiVWFVVVezzyeZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naKq2xix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naKq2xix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5751F000E9;
	Fri, 19 Jun 2026 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781884211;
	bh=q7EvVK1bpSwqak720zAlcj9vdt+SBLFd1STxBmZUWfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=naKq2xix01VxiO3U/IYFUb3gZnB0RFu6ZAmo+4XMlgkcIyWA62ZWnhYRUd0P7fG0d
	 CDzdhL2HMMdm2k6k+u3XXZzFwLKM6Am234W5YzWJkAWxHUTs2cAXeacHo6XXpwG1xO
	 vhI2gnqgdYrj4e0jGD2ihAtnJ7RcUWdliIvitxFe+729UofkI7tVhA7/fwF95SBzoa
	 +EpKO1mPYuXWeJ0gDmD55v8s++c3cxfkxd4JYme/ZS5QP/LhnaORtH7M8Ywl8qrVVJ
	 Ae9c3HwbtrIGOxDlJs8UEdpvHYYVmeqUME/i/GEIjxk5A5S6TmsnHo+PSRZAaWjFmB
	 qoeLx+JiY8l2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09943AA7310;
	Fri, 19 Jun 2026 15:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/rap: Fix Mode 0 step serialization
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178188420439.3964041.17540167005907665385.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 15:50:04 +0000
References: <20260618075529.98419-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260618075529.98419-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Jun 2026 13:25:29 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Replace raw struct byte dump with field-by-field serialization
> that conditionally includes init_measured_freq_offset only for
> the Initiator role, matching the RAS wire format (5 bytes for
> Initiator, 3 bytes for Reflector)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/rap: Fix Mode 0 step serialization
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9305ae767ac4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


