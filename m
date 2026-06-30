Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441521E4AF
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853550; cv=none; b=qAxdcg122n4vyNqRny8CL/7HHK9TStHEVHQV+OMvN7Ae38/1qT2qGq5CnkYZKfw2KAJ5eWiadEHIVbjZ2yBGtP6RQ5B2tY/XUqxdMO3mfrl/EbK5x1kOGMy1nKGVhDzWcrBHtKm8mvBN8x4Ji5DBCWLbLlTlmKRqZOjRwjQeVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853550; c=relaxed/simple;
	bh=5zePaxQScbFhKZhkQioGfvD7Y1PcHne6+g0n+2ZjnMo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aXGpGBe+y3hZ9G0/0LCIsi2Ux6hyO1m4ClrKt0zTSiRfxJ4Vn/nu3y2wgLXC3dgOCA+RRZLWg+wZlajXTjRnRWrJ1nVkc87CVmXbIECozezCO89gWrk36FqBPElWa6oOCxbJlwBVXPE8SybRhclyyNGz6N668TnwYq/lg1CF6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Uf8XdZGj; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Uf8XdZGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782853548;
	bh=H0Pa77dRKCQptq4i/IubX2hDDDRdSXOJpeuQcaL83MY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Uf8XdZGjFmc5kX3sy0I1aPcaaOIFel236uVm9lg9qBNdQWtcVG4qjJKLrOB548dJn
	 8QcMHx3LW61x1MWbWR4bRH/s393xoDHbNP816dtPAk9pROzXTYr8924YlAlO6SRbAl
	 CH2eq2Cs0D5QwHh4AzuynTA5wHO6Z3C0nr3O1soE=
Received: from github.com (hubbernetes-node-d3e81ec.ash1-iad.github.net [10.59.98.27])
	by smtp.github.com (Postfix) with ESMTPA id 7005852924C
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 14:05:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:05:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1117539/92a265-000000@github.com>
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

  Branch: refs/heads/1117539
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
