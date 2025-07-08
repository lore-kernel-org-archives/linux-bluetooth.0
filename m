Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF92DFF3F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985281; cv=none; b=QNwjDJQfRUTs9ElDNoGLe3aR4bmF1N9YWzquxOGNhxoKQi7MFBbKLAJpkARUJ60osJCeQu9SYd+zBaXXN+xibqlGsjrrMRT4SvtFhRUz2bbvzhdF9bt5Wvxk21oHX1n8pFcVpnvVy+2cetUN3UeEvgVFSAyaiTNBRQk/E7i52G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985281; c=relaxed/simple;
	bh=z1uteWtnSpsJpCcCU+Dl0V/+y+Ipe7CIVxpQLh3WXgQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y052Ml5HzLRJ65fHOHeS+8eUht1A9Xxp0AGOMTX9n2cF7JcvJBwmwqSutdhVDqBGd+EwJ8ljI7mQMXvRg6XeCvRjeCHUKMDj1pvsoPI16aDsNMZl9dwrs+K+gtsTXWCDuHV4jtOoeoNXQGj58jOaMehLGyUp7LS+G4nBFrez/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h/zYmv39; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h/zYmv39"
Received: from github.com (hubbernetes-node-fd612dd.ash1-iad.github.net [10.56.155.23])
	by smtp.github.com (Postfix) with ESMTPA id 2EEB214139C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751985279;
	bh=ga3dtSBgSAlYUaJ5FIZY7Qq2MK+tVu6PMN98WKP2GFE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h/zYmv39zOqY5aME6dY80cCTmwaWYV+mgSjyup/sqcM4Axs6KfNl8DyrByhmGUdpn
	 Mha5HOkjIPBvbcZK4MVZ2NlIUucRpmI21Pf90ojayQqfOud9EXoqfPJCGtQONoyRZZ
	 EQHnPyDeeVavJE0qp/sz6/JHWsieBoEShY8zWof8=
Date: Tue, 08 Jul 2025 07:34:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979955/060ed0-000000@github.com>
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

  Branch: refs/heads/979955
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
