Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC834BA37
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827165; cv=none; b=p1lz1h6Vc2++t37FC4ARRfZLIbyYSAF3BI8K/htRZw7++htYz+aRH9+LHXktrg3QBvO599qcYIuoo8bpzKqxDzUe3gxTRXyE97LN/eWm2Unr68wP9CRbwyxoqLLVeK//L1jSgGKtEmdoSaFOf0mhvwHfoi80o/MeXmWHBit1Pdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827165; c=relaxed/simple;
	bh=kwbSp7maLAkLLBLK6KOK1LAGcrs61bpj8V0bnaZlybM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mQt0QK57ddrfV/PQqh35N97tlbf3LT5RWzpFBcgtSaqkK49zqBhA98b80S2XVjM3k1kgje8SXZ1DNq2qknusJ8pZdD2Qt6AuAGxMAsCCWPunsghWw73zTrCjt/Il0jJGjDjA+G2jBihJpoCd50wFwH2g2K/+7nAuuKg10zHWBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hCtq0vXP; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hCtq0vXP"
Received: from github.com (hubbernetes-node-9fae080.va3-iad.github.net [10.48.157.15])
	by smtp.github.com (Postfix) with ESMTPA id 93DC38C0FFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759827163;
	bh=3osMHeYTB+KWeAaXKC77S56ROvDwxXkOv+dp/+tGNwc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hCtq0vXPqo++QngzFbgcuGyGSemRdWXCRafEd+yxhz+dGzYr5630MugbEXJdyMvlY
	 iDQWZZ0NxHWX+XfFJdQRH93/Fdaa+d+FVXdqUFZ1DgysDpm9rZY+4X4ekotYAw2QpU
	 g+32Fg9KoTqjG+VJE0iXH6mjcKzhqSbe97wj+OGY=
Date: Tue, 07 Oct 2025 01:52:43 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008955/000000-c5216a@github.com>
Subject: [bluez/bluez] c5216a: hostname: Remove unneeded include
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

  Branch: refs/heads/1008955
  Home:   https://github.com/bluez/bluez
  Commit: c5216a66393c964a9d4402625e82cb04695910bb
      https://github.com/bluez/bluez/commit/c5216a66393c964a9d4402625e82cb04695910bb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-07 (Tue, 07 Oct 2025)

  Changed paths:
    M plugins/hostname.c

  Log Message:
  -----------
  hostname: Remove unneeded include



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
