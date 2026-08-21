Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730227280A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787285306; cv=none; b=phMh+aQBn9owPihC2ZU0R+CM6ho9e9VzwDVNkYL9TWdlDUtxd4+RwvE1bsQZtM4CT3Dq+FpZ6NoYVchL1lGPrcygDf48y7ae+Yt5LXeURm0BE02L+EZ37mN/KIkpjasV535FGReACzz1ADK3owJeA+zHveLFYgav+tdc1Fe8B70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787285306; c=relaxed/simple;
	bh=nFQPYH6CCJFJHIlAqpwlRDPrQeDAclt/oY1tn9TLcK8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=THrNwoe123RLKQHlKAhMiP4Vq70DCnArW+zuZCZDIPc9PtK2Ppz2eRtrcf2fWdZKROS4lcM9dl5b2ch/+GYQLACY3gC1NR4aRS5TkBVj3gqjKGs2+FZPY1V+aGgNBnT3dI+aHiuOWXv+sbr+eTueLA/b2ayha04FRLTPy7m2WFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gci62KYJ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gci62KYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787285304;
	bh=Jwqig90mUMplKNRubVsXp08uEVYH/qwe0o2U25kE/x8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gci62KYJYzzMQ3azl9gJenx1AT19Ps02asay0squubH3wV2DC+VI/cPiH0n4ZAx+p
	 TKy4A2DpwkVpHpc0SLGGYticObz/5FOwto6l7+iMkkPVcwDPEsCZ8y9b4A4xX7wolr
	 QLUbnHtxnYVfDp5fisja5uMilei/x287cRMpmk+4=
Received: from github.com (hubbernetes-node-d0a4592.ac4-iad.github.net [10.52.162.23])
	by smtp.github.com (Postfix) with ESMTPA id 68C52780986
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 21:08:24 -0700 (PDT)
Date: Thu, 20 Aug 2026 21:08:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133054/e4a8a2-000000@github.com>
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

  Branch: refs/heads/1133054
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
