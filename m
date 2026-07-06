Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F19371885;
	Mon,  6 Jul 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350544; cv=pass; b=VAYZ4Ou7FSc6bTd4Vnuxxcyt1GTTbAJlk94k2xtGjlEBBpG4GFrTON2KBTLuXDg5X6q47ea+CQGRFlySBxzPzLCUdhjf7kjDckJ/yMkUaA6TIkAUwvLiynkSagWdd0QOjglrS3oLROg7aODy6sA8aSCwjJZbkF/lcJ1heq5vfl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350544; c=relaxed/simple;
	bh=7uGc6qOcbWaZba6BNWE0w8BupLDIVpLKSnAAYXy5/LA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pxWAOh+WlcI36m9DXQbWqwLhN81+v3FbwA1/ZtiLg7vWZPfA4PGT/QpI0aBWXH2mNdeTfmfK6d044xtQM8RVhQP/T5Qbm1D3LOp8OQONlIWzdU0eUyAfZRHCqVKp7hXdtqn/XK03099M3pe4ZhZHvc6YwuTg171G0yyfWgYluac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=q3eQUZ0I; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="q3eQUZ0I"
ARC-Seal: i=1; a=rsa-sha256; t=1783350530; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KPsfhiRXCf62s1OD5a77dlrT765LM4geTQwnspwwaF9iA/UClFJYyjZUR4d3iN/yC6N2YWJRetoZuZE8jlBLA7N094NXjiAbQhoNzY0YflKhrKmEBhCAjL8yWZpCgRjFSoMrCapRg26glxeeXxgWPXSIn2PPSz5Uj3qjO2qzYnc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783350530; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7uGc6qOcbWaZba6BNWE0w8BupLDIVpLKSnAAYXy5/LA=; 
	b=jQGUTSXzm8Mz6Xjfgj9ThaozJ27mZRqyH6el57aksBAjvwtN8IIXkXd1MrtGY4+l5iLjw3siFb+ydDfXTMXXt/f0T7FOqN2Wqr/D9Q1zir5TAOocBimrfMx4nbyEjkIkrvFHwaVAD9mNNx7kvkfU3gDtgClNmbWVbECcRv3hDLc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783350530;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=7uGc6qOcbWaZba6BNWE0w8BupLDIVpLKSnAAYXy5/LA=;
	b=q3eQUZ0IqazpyaqParrDoAt0z0vmwXbsUOt4onTMMj6Nz4XaPBzoBWotFlgj3u5k
	qqWOzGVVOys8PF+9feZuAG73he9MsoxJKSIvtPjqNpYfnVbbZ7TxfHfBloIQsU7Q2BT
	lazx5YDOFKqXDLxtdjJzna5ZnoTtS3q90/iAtcf4goTXwUKUj4MS2uWLsswNXJg3+YO
	2yyu/R4QwqZcYD7iuP4QrpnQxXBI99yY1VCSSnm7hE2FP6PlRs+j3HiHJ9Mki0c1eAs
	vh2XGViNiGsIzurkI8O3MR2Vd9pqXfn9TYDU1JDZxYTcZC194hJbNRAL6tdu925HPGG
	tB/6zmwXHA==
Received: by mx.zohomail.com with SMTPS id 1783350527830956.3838171300544;
	Mon, 6 Jul 2026 08:08:47 -0700 (PDT)
Date: Mon, 06 Jul 2026 23:08:36 +0800
From: Rong Zhang <i@rong.moe>
To: Rafael Passos <rafael@rcpassos.me>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?UTF-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_Bluetooth=3A_Properly_disable_rem?=
 =?US-ASCII?Q?ote_wakeup_for_MT7922/MT7925_on_Ryzen_platform?=
User-Agent: Thunderbird for Android
In-Reply-To: <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe> <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
Message-ID: <79D5F3E6-8F40-4422-BB2D-16691E377394@rong.moe>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Rafael,=20

=E4=BA=8E 2026=E5=B9=B47=E6=9C=886=E6=97=A5 GMT+08:00 22:53:17=EF=BC=8CRaf=
ael Passos <rafael@rcpassos=2Eme> =E5=86=99=E9=81=93=EF=BC=9A
>I was having issues with Bluetooth on the ASRock B850M with MT7925=2E
>I tested this and other patches in my investigation process=2E
>My issue was a platform bug causing a failure in USB enumeration
>before the driver path (unrelated to the patch)=2E
>
>I can confirm this patch does not introduce regressions on this platform=
=2E
>I tested system power cycling and suspension,
>and also BT/Wifi adapter enable/disable=2E
>Patch applied on top of mailine (7=2E2 rc1)=2E
>
>Tested-by: Rafael Passos <rafael@rcpassos=2Eme>

Thanks a lot for your testing!

Your issue sounds related to the remote wakeup issue I am addressing=2E Af=
ter triggering the remote wakeup bug, rebooting the platform without a powe=
r cycle [1] always causes a failure in USB enumeration before the driver pa=
th=2E

[1]: power off, unplug AC, wait for a while, plug AC, power on=2E

Thanks,
Rong

>
>Thanks,
>Rafael Passos
