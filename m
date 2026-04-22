Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D4273D77
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876104; cv=none; b=GmN2RcClsG+EvNShkxN2if59CgqkLzxgDT9iLXnGzCRg258N0etkNxnxyqWxebOM+qMR8sztCUmz7oKqJeVhpHH9znLg3LIPFVZHl8shw/DcVJVXKcOMGaTWJ6tHqfUeGEzkYLcm8dz7jX0LAl8TjMPhHZg7CforviE5N4tR5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876104; c=relaxed/simple;
	bh=wYfyY62kqvdiqzI1RG4WJGeSIZqc/7R7SRR9Eri4CyM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HsX6vox+m3QOiRRkQtUTqVE+WfT+5SvubRy0s0QZoAhBXIFgpPLxJlY2w0AN+mkw+k2v/pErSLwaWHaUXwbO9eqCzKLbp2KWUMxiR3UnJKZK4M8oxELKzT6R1co90hFqzhHPcfr2oqSeiU7WNktjcLEWQddkUn0vU2coU49y52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HxT+Nw+a; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HxT+Nw+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776876102;
	bh=0Ud2Tr9KYv6vhYY8mst/nIvtIcxAFF9cko2tO6UTo2o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HxT+Nw+amD8qn1nV7itOxN92XVFYzAjoNvSeP2FuKmpIWROC8ErwJnmFBMnCxx8H1
	 vq/iwNf0GWb9u+SMf/hQr+tHWNrvn+DrDLt+htifRMW3bGv+Rbg6d0y3tc75U9KhMm
	 8GjSpBCP+PU8fsTQHH6ALBIN5J6x32jHwEf0WOnI=
Received: from github.com (hubbernetes-node-2246883.ac4-iad.github.net [10.52.13.72])
	by smtp.github.com (Postfix) with ESMTPA id 41C2A210A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 09:41:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:41:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084033/fc03db-000000@github.com>
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

  Branch: refs/heads/1084033
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
