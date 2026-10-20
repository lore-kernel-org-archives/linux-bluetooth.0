Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520411;
	b=mo2VESAR0HrIMzurISIwqYJbb34ChOZByhnxAX1b9RfaJlR5EOzyhcSGC3/c6gn4FuHW
	 OgUqAnfMNYK8uj6AzVCe+s05hk92pe8UKpM7iviG+TgYpdghuyg24A0TPxdW6qp9fGk8+
	 83RqpRxXIuEsr+in2R2FNSt4AFEmtkZxn+LPwmaCJWd3y6eT6xSwphjwjyHyI/5vrsKjt
	 UOVe2+kCI0RIleZEIKMoK30L2byUVqCVu3wAOQ/HjKhl67jGRQSonkhOpfDGo4234Ln/Q
	 XC38Rnu6XcaDxnqAEx8bEj+62421rAet5EYNnfVwGrqjrhIMKN95qTJULWdqNDjOaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Yjp+H2L7H+fj/YOvF5WOv9qkc8C+9A5sMaiEB8P23co=;
	b=PIrJMUSoLXQGeGLRAk/puSxgvm6ngKHccK4+7hEEF2aOQGdBNkqPZcT79cfWE6K6tHGK
	 fJEuWI/VsbdaR6xU4+6sy5k72mC6fdFbeP2JLu3Wo8Ha/hvxXNzfuk8WPLfwMQnE7+DLK
	 TRPZtTj87gkaK1LpW1vrmNZNmaevHPsG1m+EEJrRAhH97sRmemRMsLem0eH+CL+ujFWGL
	 DWLQFI1sblRDVGuDwE9fHzo8BBHF0+TqwEHKVjN9oM0NAQkdqSsd8NxcOZ/1tZWqaRL4e
	 xP5zdqC/HdbsjeedQ+eOfLmB24MBJ4/VfBXYF1hW+a8IfctLLyEzbJGOtYxhZJQW8eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RR7TXJPh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E3606A327;
	Tue, 20 Oct 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RR7TXJPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C0D1F000CD;
	Tue, 20 Oct 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520411;
	bh=Yjp+H2L7H+fj/YOvF5WOv9qkc8C+9A5sMaiEB8P23co=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RR7TXJPhemeFnVc9sWySlM7a2kWII21o6HCZn3DeVfqj5ftoj02wH8HyAkDqtEyMa
	 eTeAMnesIxjB8yenHKyE9BZE11Ea3jeCN/clI3I/MZUMhpSxXY1NF7pebu33vWU+Ht
	 TFIatTCnBRlch0yrPtW1NCcaYVBIgvXdZb+5AJz35lQlM5twWj4OU6+cRaKIRu1jwQ
	 Bts4w5Z5ks9wqWpuvzb/Ld2sH+46QmxW79ppEL6LJ4zninIBssnRXxmkCzCuxrpe1R
	 XOSp3f7wz2ehmf8ho1VNGXFYzJZTv3JeKdHLc4ztepwy4DwAlfY2f9C5o00bqOIELa
	 hE4geocBOylgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13503808209;
	Tue, 20 Oct 2026 18:20:10 +0000 (UTC)
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
Subject: Re: [PATCH bluetooth v1] Bluetooth: hci_core: Initialize LTK before
 publication
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179252040952.143064.9151877128900606863.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 18:20:09 +0000
References: <20261019105624.489859-1-18983559317@163.com>
In-Reply-To: <20261019105624.489859-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Oct 2026 18:56:24 +0800 you wrote:
> hci_add_ltk() publishes a newly allocated LTK on hdev->long_term_keys
> before initializing its address, type, value, authentication state,
> encryption size, EDIV, and random value.  hci_find_ltk() and the debugfs
> long_term_keys_show() traverse this list under RCU and can therefore see
> a zero or partially initialized key before those stores complete.
> 
> The race is reachable by racing an LTK addition with another CPU looking
> up or dumping long-term keys.  For example, userspace can issue
> MGMT_OP_LOAD_LONG_TERM_KEYS while another process reads the corresponding
> debugfs file.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Initialize LTK before publication
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd0191d9375d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


