Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF5339872
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557830; cv=none; b=rXFxvfy9710Zsj/zF/iWezv9xIWuefLWtHn2SuwFyUJnOjVygY1I79xInhgpswf2gSutGy4zoNAh9NFKVlkqb6lUgRS3xmnLRfX7TU/661LOCw8fDxjTLxQgpP0bYDsQ69eaEQJ1VuWSQranAWA6udRVDS8SBhMnzk7+BjWhTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557830; c=relaxed/simple;
	bh=6kWZmaoLU1nF3B+O9Oe4Fvft+3Fcybwbu6MS7qujjos=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Cp/pOwVrzSC540ZEwQC7c/8OSNUtKgnvhHHI2hyp5QW7+EM+ZBsrPO3Bzn05hL/aUyokHF61T6UF6u2gsYMYhzF6rczi580V6CL9KVGU5+JLtpZLpKYb1eBB5qys+JfUx1vrBk2ry0xlQam/POUh4yRPoc2/RQOEeGfwdE7Ogwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dd2Z7eOL; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dd2Z7eOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788557828;
	bh=ei354oTcMd7IaK4JNYwE9blgNTptjXSe+wvkTDlen/U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dd2Z7eOLmq6IPSmQ2tfGXuqAx0umakT6w+Trji6Hd+Hf21gCUtqVkmMXnWlbCf5bQ
	 mHw7NpkF7/UIUskA4vKQ+IYw5DBGCAt39I364rzwVDX3aFqHdJenAtekYsXq0TiiN7
	 ySdEit7gfqVkDAonQAWWx6WD+JuFi8UYH6Z9xkGo=
Received: from github.com (hubbernetes-node-9201343.ash1-iad.github.net [10.56.174.18])
	by smtp.github.com (Postfix) with ESMTPA id 104451806AF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:37:08 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:37:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157441/897d4c-000000@github.com>
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

  Branch: refs/heads/1157441
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
