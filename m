Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3C5540BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090475; cv=none; b=nCUHtKegjizez/xDsPr0nMKE0ivtC2xq7XsBJCwna25gAddrCmSxAkYD1ZHFkavzCBIR9EGp4K9T9wHrUY3T7U7W61E8kaIttIX6ghaRmnAgSq4V9Cazb2HuBc0VSmwDXx+Nlfj+dvsdCNsTERzCIs6Dplk4stu1pUp9b/xAaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090475; c=relaxed/simple;
	bh=At4q7Ysn7lWQXzAn6Jn2+D0h2IjFuT0Zg+i/AxpfYaQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dq4UQG6EXWqOF/MZA4E2nmRqA7kp3fifphXvd7kYT3lySYgtfOXf7jQ9y54Z0+U61T7ThPNl1oMddQFx8KGnmMdSG03PnnMuSomgicZNmKRE9RCGnKZ0jBC6cej8TasJQqPr0bVbKuVJgwPDhArb3BzQhgpFZN/Eryt/EaDrV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1By50Z4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1By50Z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1072E1F000FF;
	Tue, 22 Sep 2026 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090474;
	bh=B/dabwswRNtT8WXcLZYboJY3Hm29Y+YqVjLklPGAddA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k1By50Z4E/mF9G+85D0SEZXRMbMoeP2jbMT8Kj3VHMsOamXB1DurPPwVoYx93XsTg
	 nX4vrxja/kT5bj+vWv5yVea91Y+s0ENxWUgut8AWIiDtWfMwKIicdrM8JR/vo3sN18
	 wmBhdrTLQf+VjrqgT76eabdkv1cyvv2LWEVWz/75HP+xvBoMhFyr+PYbk0tgaP+x7e
	 NC5O1jDNJl/O3v7du+ilw5ESmBl8pnlUFmJriBL5mLg5Ye9gGgtTYxmFYXTo3dWwtN
	 n4P+Srw9eF2BAnp7pbhtpCNml6S84hVZ5hi3eixwRXi9rpPBECMx3YxI3aA1MpO5v6
	 YmPg0q2T2Rm4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699A3811A4B;
	Tue, 22 Sep 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix NULL pointer dereference in
 dev_property_get_uuids
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179009040515.4135593.12444042145585528858.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:20:05 +0000
References: <tencent_27EA4A683B87E3DCF400C26D990DD9364507@qq.com>
In-Reply-To: <tencent_27EA4A683B87E3DCF400C26D990DD9364507@qq.com>
To: Tao Cai <294305068@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Sep 2026 11:10:17 +0800 you wrote:
> The bluetoothd process crashes during D-Bus property serialization when
> the device UUID list contains a NULL entry. Add a NULL check before
> calling dbus_message_iter_append_basic().
> 
> ---
> Crash Stack Trace (BlueZ 5.71 AArch64):
> #0  0x0000ffff8ecfbe98 in ??? () at /lib/aarch64-linux-gnu/libc.so.6
> #1  0x0000ffff8ecfe548 in ??? () at /lib/aarch64-linux-gnu/libc.so.6
> #2  0x0000ffff8ecff120 in ??? () at /lib/aarch64-linux-gnu/libc.so.6
> #3  0x0000ffff8ed005c8 in realloc () at /lib/aarch64-linux-gnu/libc.so.6
> #4  0x0000ffff8f250204 in ??? () at /lib/aarch64-linux-gnu/libdbus-1.so.3
> #5  0x0000ffff8f251c34 in _dbus_string_copy_len () at /lib/aarch64-linux-gnu/libdbus-1.so.3
> #6  0x0000ffff8f254294 in ??? () at /lib/aarch64-linux-gnu/libdbus-1.so.3
> #7  0x0000ffff8f23f968 in _dbus_type_writer_write_basic () at /lib/aarch64-linux-gnu/libdbus-1.so.3
> #8  0x0000ffff8f243208 in dbus_message_iter_append_basic () at /lib/aarch64-linux-gnu/libdbus-1.so.3
> #9  0x0000aaaabe2f64d0 in dev_property_get_uuids (property=<optimized out>, iter=0xffffd510cf28, data=0xaaaac18514e0) at src/device.c:1339
> ...
> #21 main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1456
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix NULL pointer dereference in dev_property_get_uuids
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f26da4389e2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


