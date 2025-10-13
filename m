Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B96194A73
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372179; cv=none; b=mpRm8JeaFl/BkXhXIQJpM3aZhy+jZDzSoaDc/cg9iX3L4n1qgCverGrltDVl68n2yFT71ELW8mA6LC6TOEn3XXowGPLDKZJjobng/9kl/1EKPMpAXbQPbiGIr0tpQSi/3Ur2x/u0cTkUxcaVy0bgYOJ6SuY6VrngNuWixpZhiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372179; c=relaxed/simple;
	bh=UmVGRQpaqjauKY7UVEUDTJkvmtb9j3Z0uL695Wrf7r0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i32hURiIbqtqQ+d0QmJmJ/JtIllQZT6MQusjiTcDSdNjbSL03gMwRlBtQ4Z1Ftyx4D6TprjW2HKshh4pRRqzzgXVFOXn3iRoT8PDDZIfXuycSzcWEaedu4+4MW/v7l7jC2vgR7VQLkfcJLOCvR583Xo6sKatnWpHy94uHw6iFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DswEj2zb; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DswEj2zb"
Received: from github.com (hubbernetes-node-8a429ee.ash1-iad.github.net [10.56.15.72])
	by smtp.github.com (Postfix) with ESMTPA id 8AB2192071E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760372177;
	bh=DWgC6WzLuKl+rUg4ZpTCceLiun572Hdt6EAFKkCgxW0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DswEj2zbV3nqO4yuYmcbrYSLI+CGHgXsjfucwSeWg41A3QDKtFfchJrWQr5aarM7N
	 a4V+4aQZNLEdR9YmSk16qp+GVJPANYcKGUGbMmMTbp5EwuW7Zn0Nb6qeEFB997Ytp7
	 vKArNb/wGy/bgISopF3rm2hTqFllWapnFLJ/BfF0=
Date: Mon, 13 Oct 2025 09:16:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010380/04d044-000000@github.com>
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

  Branch: refs/heads/1010380
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
