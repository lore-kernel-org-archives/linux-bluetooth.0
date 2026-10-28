Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217025;
	b=YyBzKPh3tlmw2UWTg+atXCOAlBGvSVb3F43k1CZafS1rwxxuZLLTzsYL6NjOjKNL6Bf4
	 Wvtk8/u2wYw5/muIrnki+O8PD+ajzwO28Ps/ng+NazlyUoWs14m7UUzSNjipJVxAJXC9V
	 qx1gAwHpp44KQjNgNEBK7d8mOED0lInEeV9wqsCxCjnuW3aWsr/HgXetvNI/oPRtXjjvz
	 2x1e4g3wZ4aEZMlXsbyqTYzQMWR67QqIWA0vvqxDH+ToJcK8vePy7b6QUu3BQVOwbB3MG
	 W3uPxozsyW6HpQM0Y94Tj7fQhyIBWmt/eNpfLh5mNOd6MOUFJHQJBqj89NRym2Z0y8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217025;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rBpT+JQssQ0oplSiJBn6nhzU/bHNe4XYv5w/XMbMTxc=;
	b=iDvVRQTJVCHR5Z0tVzHX/9YQW9p+8wPHq3D+PEN7YNGQ81zaaNrvMB8WyUsV5hPcUzi+
	 DHKab0gonkyCrAvr3Jk/rRA2NtOW4s0tkkWeAxnsjnSVu3JbBomlTLUpptwvHQfY7UBP2
	 zwUDYwwU5B4mc+rYJ7JbuoxTjAsyIHaOY8m+Ah71AN6xrFBVjJpcrpnSh85kpihzYkZdB
	 WK5r4SEsbXA8lalWCG1jiZDERLskeN1/+wypghZQMEJMpHFiNnwebIMjgl08TfkzqqGIy
	 j1s/4i5l8ezFpD/ovPskKxWhAHUoU9MO+/ozu4QX9UmBY1DFQI76I2oB5KN4wAg5Kyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMa4atpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548960A260B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMa4atpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119A21F01828;
	Wed, 28 Oct 2026 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217025;
	bh=rBpT+JQssQ0oplSiJBn6nhzU/bHNe4XYv5w/XMbMTxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UMa4atpwW5y70kOwolm6h5hzrtfaIWgReoVXS6TW4UUaQ93hbQIQOU5nYQww/MqVb
	 lasvJMAAKInZfkoVzf4B2H7n5w8+mCqwZWHMemNV8O2UaX5AD+PKQycKZWhIjkkaSG
	 bR0qqBkrz4/8u53TG/ToaK9PZht0ZtM84mDMLHIAtn2umuqOBWZIsiAsBhIuuSv59w
	 osmFE6k5zRQ57SrNmySZXQp9e2aCew6qINE1VpKVk8S6xbd6R40wkF4QYSOCVUKbSG
	 /UfdopnWShbUSK4ulxgZqIN4r8mbd1jTeAeJJE0Ku0Q8Pag5TpMRGmjoyfqenUGmEe
	 CGPGNkvUoAPYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073093AAA770;
	Wed, 28 Oct 2026 19:50:25 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] ioctl-tester: Fix name of the 3-DH packet type test
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179321702352.1394536.5341195369695217645.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 19:50:23 +0000
References: <20261028051620.3167775-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20261028051620.3167775-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Oct 2026 06:16:20 +0100 you wrote:
> The test for set_pkt_type_3dh was registered as "Set Pkt Type - 2-DH",
> the name of the test before it, so both cases were reported under the
> same name and a 3-DH failure would be shown as a 2-DH one.
> 
> Fixes: 0da759f1a36d ("tools/ioctl-tester - Add ioctl-tester")
> ---
>  tools/ioctl-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] ioctl-tester: Fix name of the 3-DH packet type test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e5b0da969c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


