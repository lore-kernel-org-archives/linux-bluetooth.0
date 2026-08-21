Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5963AF66C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298870; cv=none; b=M88OOuao2HXbgi2i72J2vYiW0h3Y2I4k/sYk1b28xEyV35VTSbwEnEPrhsM19pfJmNIVxrdmpE2d4FEbzIqSz4Kyb0q6nZzvSooibh3GUBJYpH13v4KbNF4xmielvBe/gf07rranYmK2eN5afT6JeWDTKo57KYF2vXZTh9uMjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298870; c=relaxed/simple;
	bh=dqo3BKckayGivUjo4ib1Fg0QjJSK8djmItHL3DzYjXk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bGbP0QjyYLQx48ygO1Qp2hlhcHWskeEH/rnO4wo3YXPMIEuegmbAOsA5Yq/rwmA3JfXtNTtx0DP2PrNg9vZxlFGatKp/nbX+f9NvNH6S0E+C2wFc8gUeNrE/m+vlMudHdN2z8lp09dxoOpnNEFKuB51Zfst2TAhP122vTemiF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FJd3JBII; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FJd3JBII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787298868;
	bh=b5EPc47g6LSd7728TyVwIRIAWOhrfHLoRG6tVsOu8Dc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FJd3JBIIsZ8i18lyA+Qikwr3Cm7JVAIXfz1dQf/at0rPwil/V6frrbc135eO8OHe6
	 srLUZZ0QcwP55iPAhyxUu8RCce8UipdFum6dZYW5uPi1crQt+XCDoYsIztDGIrmngq
	 aQhdGnUorWMuSqKR8R3v7FI4gvZF7879AAdWuIYw=
Received: from github.com (hubbernetes-node-fbf3d18.ash1-iad.github.net [10.56.144.34])
	by smtp.github.com (Postfix) with ESMTPA id 288D1360795
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 00:54:28 -0700 (PDT)
Date: Fri, 21 Aug 2026 00:54:28 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149533/000000-ce02cc@github.com>
Subject: [bluez/bluez] ce02cc: gatt-server: Fix integer overflow and 3 CI VLA
 wan...
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

  Branch: refs/heads/1149533
  Home:   https://github.com/bluez/bluez
  Commit: ce02cc800e7fcc6cdbc33190c8d329dde1a2f037
      https://github.com/bluez/bluez/commit/ce02cc800e7fcc6cdbc33190c8d329dde1a2f037
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Fix integer overflow and 3 CI VLA wanings

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.

Fix CI warnings: Variable length array is used, use malloc/free instead.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
