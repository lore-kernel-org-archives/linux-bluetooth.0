Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A483A6B89
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337999; cv=none; b=YuTX+l4lxiTQsiKiAQ5p0dx1ACupua1gT5bTdv8XZtU1T19Ddwo2vWBMOmPiN1aownEF9fIL5Vf2F5xsBzhO0YOuCnuNevrRS1KffYdSVAg9bzDwPV02NL5HpOqlKUFGig7JKxhFaZS+iiKTMAj7Szgn6LlxDHiDZ7rkCl0uOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337999; c=relaxed/simple;
	bh=6EZ5hXY/luDCOV5QC5GT5ao024ry1ShPopnB/Y07pew=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h6G6mJ2jNkRUJ7c6qvaYjlgrEHjnh8RctGYQZgC52gLH2s+oDJTqZiXOUstBQs0GeFU4O3VcBq+qz+hpPPPYXIiEsAxhfXHSFDCjqKldusDJfb4O4LwZjH+4Mxe6HS1975Bdme4A59vYN7aEqpSyWG4WQVZf7F05u7WohmlZ3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b1uZ4x5W; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b1uZ4x5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776337997;
	bh=Z6H3Cga1OPDnFh75fRouxoN/XTAimKAGPsmmaC4pTCw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b1uZ4x5WzysqLNcbprfiUYTJzPTG9/dvL2ixJ4Y+uxRzp1pnbo0yM1YNaL0WO9rLu
	 e+augOTcV5IBqBnZscnL0nTVn/UJZ7VkwNxLix8rRdhyR4n3/dTjEh1Xpb2ehl1PHr
	 RnvfOG7wWx2krlJRurlAMMjKKUYChTorehWxjgR4=
Received: from github.com (hubbernetes-node-a53fbc8.ash1-iad.github.net [10.59.99.17])
	by smtp.github.com (Postfix) with ESMTPA id 4F833180FF0
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:13:17 -0700 (PDT)
Date: Thu, 16 Apr 2026 04:13:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081931/b409eb-000000@github.com>
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

  Branch: refs/heads/1081931
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
