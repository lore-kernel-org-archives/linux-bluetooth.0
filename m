Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096183A963C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316441; cv=none; b=JY54ePVzqE/pLaw++g1YxJFiWGvPwEBxVXxQRp+EcEU4dL0RFyjCqb6RJrgf1ZfXJ/0665CetRMAWzjvrtBVYF1/n0A2+0EjeOrdXCBvnW8Z1UJgSQnaSLtn3QLTJROOjTFHABDkFjzUFgTGbplP6jejripwh2J2YlyZF5ABhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316441; c=relaxed/simple;
	bh=DDjBg3d4voyD4eKX7h6qtfrpemamRMZ0a15ebZ+Cnk0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T2WM2OFeN4YmJEzAwnUQD5qWstZMIqgaM3Rc8/Q93XV7T4eIzlgNbPw44YWUri+NJ/np8NhdZokkihnEM/MwE797xgPiuBh8GTDo7/LJiRuUfR28i6ebqXnFEINPQQnCIirJLkP1197+ivIrwhmOSeXYSGQoKqWh3Ktz9BSUGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XQtQNc01; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XQtQNc01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782316439;
	bh=kTfSIEc350doKlCdbSyGW8d6v2IIeqiQkd/Ye6Q/KSc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XQtQNc01iBlNAMd7m6ihdIqiTaN/5xKvYMaodOzR5CxhA5qxRhD+LEtdhku14wLaO
	 ximqavGb54n9VAIlDICWhNxVxSJZRvpfvWYXCeRCyJ6sbw3z/ITyEoaeKKVrIjP1zE
	 +Pu2DClwaPKmfGopVk3j+NjtJt1lFnOeiQEOEhgA=
Received: from github.com (hubbernetes-node-5902de6.ac4-iad.github.net [10.52.167.38])
	by smtp.github.com (Postfix) with ESMTPA id 3447578114B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 08:53:59 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:53:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100512/c3044c-000000@github.com>
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

  Branch: refs/heads/1100512
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
