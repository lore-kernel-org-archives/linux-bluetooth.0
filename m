Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64C12E5B
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124991; cv=none; b=Fv9Si+cDePzg2Eer4/Hb6QaMKRH1PFvKSA3DkVm0wltlh+PKWd7qMHp1nT0gSUihkPplrh05srj71X5dJJS6qcsJW241qqaAU0MJiH0sAy1Mjr9gey0bNRfuX+qEUpiPB6YMivtYhKqB8R9ZutymC/s6TLlwJA+OTGaJyurv0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124991; c=relaxed/simple;
	bh=ERONsp5zQaLiLZX16lWCoIUP6NdPaqdiwgAqC6vm7Fs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S5Jk0H0XitogAXAZHdHM5g8NOh7J2OLlOV08/hMCQ45kErrAEO+osuDaoeluoy7Kg0WvgOtVM5BSBal/YeF3VEH1cjJXQo/d/+ZS9Buab60XMc9RfHzat7HMRBQ0QIZQNFQPvNi52XRDkzVW/B8U0SZvyuZ35K7+EjeH4VGR0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kl7dwWW1; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kl7dwWW1"
Received: from github.com (hubbernetes-node-640f864.ash1-iad.github.net [10.56.170.15])
	by smtp.github.com (Postfix) with ESMTPA id EB76692071D
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754124989;
	bh=EoVqwHTyWX3oUMdH4prZPcS1sUeouO7cSrFClxa9Ntk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kl7dwWW16rCeHoPV53Dy5ZXrrwU1rg2Cp69sEJNVPZNejO8ZsPPmzimwYDpBgvu+6
	 71TvSwPWFgiC/Ys4fH8pVXw0yk4q3Cy2giFfmpQpSHuNsQaiMl9xCNJYd7Ma7VYFB2
	 acyK81ETLKO0w5Jx/e8rTHT+EnmOT+aL/DTI8Tls=
Date: Sat, 02 Aug 2025 01:56:28 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/978522/c171b4-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/978522
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
