Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894904A0F
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Jul 2025 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753012732; cv=none; b=iIxoGEYpfqiTG/6XDvlw+4ZI2lqoYp83zE0t7ONiktYhFELUVO834PsvEERWwQnyIoeV8nbOv0p21JAdS4YVP+r/TA8bnz/KtJ0uUWMRFysG3AIva2uFMgbr3idqsA7T/rZf35Msm9VMJb2qnxHolBB3IuvauvcmNqs/vNDUJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753012732; c=relaxed/simple;
	bh=iyIkl9PAVbn7qCdEBtwfJLCCaKl1+Uh9ApT1gfvMKGo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UYRncCSdhWqbPZ4L8ly5isLVurMqf/ch0AZl02kC0GBfUT9najeGEJTvuaHqiaTfzr2LC1qU8AHRVPQlew9tCDFbkDrIYc7gEhpc5TUPIAoB3pqxvIiBIAGxFOn3cQT2OJRoFEk1TFpJwkyKIPIzBy7JgLv4QJX20GT+uAxl5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lqXVF9YL; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lqXVF9YL"
Received: from github.com (hubbernetes-node-c2f3284.ac4-iad.github.net [10.52.182.43])
	by smtp.github.com (Postfix) with ESMTPA id 9B3EF20B13
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Jul 2025 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753012730;
	bh=ezf57Uxa8zXGHoB+p8DOsbHBxEos65MI044ZtZyIkvk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lqXVF9YL+LwfTXSihHjLfQn3UaiUrOGku9V99txCf8pPeX4mvMprFCbgzyvbX42Un
	 TYJE5ef+L0dnxZOhdS68cp4FY1baDP89xHgvFrXbRQbCJ0gNMAcBkcCsP2BJKzKHlg
	 +oS9txRRqVJtli7ChfK4JsZaeW7eyEc0lXd2C/wQ=
Date: Sun, 20 Jul 2025 04:58:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974231/514701-000000@github.com>
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

  Branch: refs/heads/974231
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
