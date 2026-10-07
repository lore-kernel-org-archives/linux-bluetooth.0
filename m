Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4D34B40F
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398409; cv=none; b=XWrHU2krg9I01RsnYrIb0F7jFDoAX7L6m/af184EcKld8ct5u1YrHZiq+R9w0acGsbppYSi7vbnyUzrBmYqfZjW0b7R1MoHJzzv2Zk2UxuZWeLF0VU0QPgDPbN4MUMWbHf/CVeFHT8pGfArJd2u+vRNf0OqxPdZ7jtmX+tKaPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398409; c=relaxed/simple;
	bh=QiAKCtOYN1T4J0wLFPEdoY6gFzJqFex1LfLSd/jEsQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xm3NgJ+/+ldESj4c8U5PY65mUldB2vUbBNyiTB9+uFhXc69/Bi2o7RVAhkT/+JJcUoF42fiPvCydaKNoL5fhaSS+odyBywdMgAApOYIrv4wuyozxXUqNiR9+jrJMGYt4znwVyYxvc3wlvhbv4PlNE/qCgrQ/ku6FGS8i9BgSZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkaxIrgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkaxIrgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1FC1F000FF;
	Wed,  7 Oct 2026 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398407;
	bh=kIDQFEmo6HjBPNtyIuOcWRfVi0N5VEM7Yuqhxt0nvKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JkaxIrgOX9Ur5PAQMBxMpDHZWAcXeHmzU2kJ3uqstBozmeFSPVWzIEt03BOOg5fdL
	 DQ4zkLjsVXxc7vKQxMslHwr5whsd3ZpQPD3jz2SpXjWXSwoKFj/aVVC9MhhvRfnkMm
	 0Du84DfNWEKcv+zSNtH/OLfvInGcjvkxoKrryUfDxA+tPTx0laizgHyFJfiGCxc05O
	 Q0sI3JfX7bTdNmnq2l7GXMJsKvSGYoyVd8NW5juc7K+IAEqcnmIGFMA1BN7y4J9iFw
	 FoFC1Xhq8Kp3i+Xj71Zizl9DwP3/5lXkCFRxEubImJcRT1k3YbRDDBik1mcFFkgJQG
	 3qzdQD/ycX2iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43013808209;
	Wed,  7 Oct 2026 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] emulator: Fix extended advertising report types
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139840653.3650240.14235783377943488144.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 18:40:06 +0000
References: <20261005162117.4606-1-kevin@simpleble.org>
In-Reply-To: <20261005162117.4606-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 09:21:14 -0700 you wrote:
> btdev sends the wrong Event_Type in two of the LE Extended Advertising
> Reports it generates for an advertising set:
> 
> - the scan response to non-legacy scannable advertising is reported
>   with Event_Type 0x0000 instead of 0x000a
> - with more than one active scanner, every scanner after the first gets
>   the advertisement reported as a scan response
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] emulator: Remove unused le_ext_adv_type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=28cfa93135d4
  - [BlueZ,2/3] emulator: Fix extended scan response Event_Type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11f99edc26c7
  - [BlueZ,3/3] emulator: Fix report type after a scan response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73d7f86a117a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


