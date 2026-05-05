Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59A355814
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985521; cv=none; b=TcGhE88TKBKq1QbYX5E4JOf6lkjF//cC/tSzXfxd2iQHgV4Tn2z+u97GEy/2gRp0ge5lsWYf9+6nz3q3Md3oZ+hdggHALDJzhBx1+gtujrL9/hqKj1ubJvJ9NKwquPVih9heva8pUhI/w4tN5rqv8ltvWQtUXC1QcZn34xRAELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985521; c=relaxed/simple;
	bh=0lWz0SytTU07Kgo940rLiKABmKkakesv/q4fEspm6SQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qIXc1cStHEJQryXk602H06wwXuVt6lQtuBLRtyCvNVWPkB83vOk7ymbfTFVwA/ZBvlG7QRfTgFmVGge+ikrilcfKyBfg/RsTNpejeqfIbA1aswoGT4uJ+F5uor7cNy/9HoHQKAZqrojLhWIgn1YiiVR1OnUPptFevJOAfnaswzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LwQdSsVG; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LwQdSsVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777985516;
	bh=ZWbnuPdwR1cShO6nMZJ2PJCyPqFoACtECVBnG+XYgYE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LwQdSsVGZe+uZSbKz8WT/joS/2bKaTAl9pW8gDuu/9WAYFDc4UUtyHx22mpVunS9f
	 RB1mnxXLuG2Upt2WhiYat1zkBZSjcc95GsGRHnAkYCv3jldOrtMxETwXz+ZzpdbKoW
	 n1kN81ZtNtIyW7nBn1dMV3UGWdM5xnvAsnWNynGg=
Received: from github.com (hubbernetes-node-51e390d.ash1-iad.github.net [10.56.182.36])
	by smtp.github.com (Postfix) with ESMTPA id E73A23610DE
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 05:51:56 -0700 (PDT)
Date: Tue, 05 May 2026 05:51:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089698/79975d-000000@github.com>
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

  Branch: refs/heads/1089698
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
