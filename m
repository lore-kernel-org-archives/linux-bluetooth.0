Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA29239E61
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251173; cv=none; b=tWjRY6YfRo5g26g+puu8GjJ1ZSxvbB5inRbBFN69m8HgeY8eNdeFJ4Oe105qbFOSt/mia+aBK7x+08hWvWJHGqeoSxOhxg3dD7GPReGebTOa5t/EBFdQXPD8h0wiF+64gtVCdReypGjDIw0YmoFyPBxy5C2wyvhdWlI4nGBWWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251173; c=relaxed/simple;
	bh=xp0HD0cVUsGDjndVYnLlOitLWldza7jzkxcb1VDt0EI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XbtOzAcnAmM3gwNhbQAvK3OD34hgytE2LWH2kJDC55k11aj4iWL4ZYzpLQ0j3Nc+bP6OYh/FeeJLbzR96H/2HDl9N+2rYaqh68m0VyPRY7ZOCUSphCNIi4da2rtY9JmObwTzMbP2kT2gZp7mJ12jWa9/YEZnkR83uJO/IeZvjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F89K/7hL; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F89K/7hL"
Received: from github.com (hubbernetes-node-d8a745d.ash1-iad.github.net [10.56.212.104])
	by smtp.github.com (Postfix) with ESMTPA id F0704141268
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759251171;
	bh=ozERtopgHPrP1h7Vb5u4SM4r8zk1CY6mExxSla/I3qU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F89K/7hLcZqtw696D6kTDf4YPEjt566fnNWXY7G1yEtjzTPZb99J4P3vEOZ/x28Tg
	 X3ayyZU1RFS8uNsDxjqPDtLBSBOPQZ6yN7I/E+5p+ccxqNSvOqQaja9h4hceXRGZoB
	 M8YSuNPnsd1Y56s9yehruzLXTvMub7KYD8MA+w5o=
Date: Tue, 30 Sep 2025 09:52:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1004140/d7a7d9-000000@github.com>
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

  Branch: refs/heads/1004140
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
