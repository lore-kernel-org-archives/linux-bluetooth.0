Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881F3D6CCF
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932759; cv=none; b=jrdR4Hmj5jpv+ZHq4+vfT4ZBOK8M0Gi5WNZJ+MyovL0GUJJAKKkQ2eUy+p44jT0kydjxlUoiLmqyinGsWV8elqgzRhWoIHyqvvATMuQNLCks8oFw9OrwpCO0AhQs+VsErNrdiL/smmJyS0cCWjewtfz5HJCloHyq6znWgqd0vBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932759; c=relaxed/simple;
	bh=6AobL7js4gYzd7t/ArD2DreMwdWnL1/B0K75z9+P5UE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=o4IKDmrCPufj2gC+HsUSa7a6dbd6gLOzNhFhuMcsxq+Pt38IZb+ZxIFmMaZe/dfZrGqibGcp4+ZmXhhjm6W0LNdjYbpzGWOo2LTDd3phUf7YV68YsJW+vK/QTpGVcYq3GafRs2hNedKZszDQmJpwmlPZOIslX+/sNw2ZnBICeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=YcnaeAzh; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="YcnaeAzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791932757;
	bh=Xdz5lA9rNIVu4BH3R4LWI7i3QGm2gt1nWO/qKp76jPk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YcnaeAzh4nVyIRXO2SEeEEm4ICTPo4d6XaU5XCE36hrM1kvbTeOpha38PlIoY+Zr5
	 bb554gt7m9nqqInToKkoa3LDZP80yEOy7ymrOE+pxfvlT4YmrMtZqTjyRL3z4oSszr
	 f4M4h8VeJdKtMHjhici0ACkFb0uWgUicD50kSflI9qH3FqUUj+eOP10tkQGh9nJuD8
	 lQpui2L655tnbjGY18LtcAlu1eSTN6DBmkrogGDF6Zy/uG3Cr2p5gCgqw2/N67Jl51
	 c6M0KpHNPrkOXzlb3k6nRhmv5LGhqfDk1e0JXabT1lv/gJJdbAxNW3a5ZEbbQItxUt
	 i7wxjsYoSQA+Q==
Received: from github.com (hubbernetes-node-1a3c992.ash1-iad.github.net [10.56.146.37])
	by smtp.github.com (Postfix) with ESMTPA id D108D9201EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:05:57 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:05:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184360/9bfa8e-000000@github.com>
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

  Branch: refs/heads/1184360
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
