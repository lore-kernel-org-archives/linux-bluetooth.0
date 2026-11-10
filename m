Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327008;
	b=gS3T7rJRzgf75ZJ+VYHWD7ASbVtmW0qciTKZk85a+X2b0Ah524B2PinxSMjj4Ct35+UU
	 KX+glJZHFZAUl8UMMfGtV3YK3qMg6ywmxCvs3B5RAgP1DUHsFfOuP0Cfn5HkKYKVDS4GU
	 uNXfeGaRv7YQX1oQNt6OG0CI9GTuru+eoqPAcJR3Op2vcgbknlB+N8NmhSbvlTTqqyKvr
	 5oEufY2JCtJLOa6utU0hlkcA60yyFCZSVYVVWuLy09ENp6zzQjc7++fsDo6bjVDiXV++v
	 DbvB0eCE8lPRnmyW5BR/tD2ZwFSV+7irLKR1TjbT73BDSCGVYa7rhEilULRh9A6xr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QE0akMupOU6kvmoPQWpMe8qJ3jt3YgwRHPsEPnaHOYo=;
	b=oePZIss+TdZ4FtiM6QeScdU6I+alUwiT5Q7Ilk24UsgDBGwc4VWD1pZIWwZ274XXj7HC
	 OLU32kEcOPwyg3yAzor5ZUfX/ImLgzQ4GPZgmU99jJlQvMtp7XkUUITFb+eBRXuvnA7yy
	 85Bh9MUbSaGaMOsYqwFIv2lhN13PgpcwUZBW9GLbBufbwIcUc3zPh0yZt0YOdFhem/yXt
	 97bHMm0TQ6Y2QP1+4af3GFJNO2lwdwAaBrf0U0vJg/0Ns4kfUejqzwMqaq8mkW7djiLPc
	 RmnyhqWz28XvZKav81IHOF6n0j3fZ1KelMadTg446Ex77hZCZcaqFvRQowoSEeNPZdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVnxVKX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4F606A31C;
	Tue, 10 Nov 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVnxVKX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310671F0089F;
	Tue, 10 Nov 2026 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327008;
	bh=QE0akMupOU6kvmoPQWpMe8qJ3jt3YgwRHPsEPnaHOYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RVnxVKX7TB0CtmbUpXpo/tpUsnICUXHpTwg/EVcRkpLdfLrNo7m2S+WpLS4C7uCQF
	 Q/XJ7uenR6n2ho+HvSI9+y2R049tUNAd7kvlTO1sN8cBIpTbg1ol9ialWKbk+ob+Fs
	 08shlqJKnCmHZ6SG+S8iv3uKh7NgGSHBEz6FB3/VqZGxi8+9eWss7XklH9s/KJ/can
	 h7/IBe3uScmw8V56GxoaewtXMgRMfalQ4kvSjkAYaUqecpNp86Q1AgG3dZzVXML+va
	 lL770Pa9ebXbKzMzMokOnKxGPFuiIpl8jGSkcoM/6HRmscTfMPirRReOc6Ge3tOYse
	 uCN8pTHCogHQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2102839D267B;
	Tue, 10 Nov 2026 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Bluetooth: hci_qca: Reopen port after power on for
 QCA2066
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432700692.4062787.5940023737695374841.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:06 +0000
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Oct 2026 19:18:37 +0800 you wrote:
> QCA2066 needs the serial port reopened after the controller is powered
> on, otherwise the host and the controller run into RTS/CTS
> synchronization issues.
> 
> Patch 1 reopens the port in qca_power_on() for QCA2066, as in v2.
> 
> Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
> port which failed to reopen is not closed or flushed again.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: hci_qca: Reopen port after power on for QCA2066
    (no matching commit)
  - [v3,2/2] Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
    https://git.kernel.org/bluetooth/bluetooth-next/c/45e28b01e4d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


