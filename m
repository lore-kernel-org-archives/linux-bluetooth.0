Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802C2D97B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973576; cv=none; b=mLPJZGNbpN6XoaVIDnEDhiuugEoGvLKw9Y4OHOkS0XD7c/TlhSrWoPtWFmKKb48S0AYjw+CWVk20rE//uqFuYoSUn6Bn4HULrrACbXHZK5txIU934yXtH0AvE6DCx2vJ5DMemHgzSppirGWgc7RvT9n9MpdwO1siqsa/dLlTMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973576; c=relaxed/simple;
	bh=+venTFQrse2i1sERI6nBgEv9+7BZHuxq6RtAnE52kz4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q18kVmUXCUp3/VPf4j5+hudUCbnaUBGBWgFdPkgqmO5/3wk/HEzl3SCW5JO+PTS8pyPk8ntxS73mE/QP+TAMH+aoZk+AM78sZR5aJJNw/veRrEBe7AtQSHcpiY2zxon+RxAmx0nGwLekG9EXPyz3tfg4haA+aUdOCj3GPERyDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Yq8BF9aP; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Yq8BF9aP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783973574;
	bh=/Cj4wLSMjm/xvuRfvuDZdDkIsfvTJm5MvA848trgMis=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Yq8BF9aP+mfi+M9o9e3gqEzCJTg6oTKd4pU/kiWpbuSFDnQT9949FPRne+nwkgwH4
	 skYNvEh+mOSzTYK3jPkNtLUBQXyL0mTX+3bkqRTg0/wS67sgGra8ZWa5iSeNkyjMWm
	 WCnJjV4+W2rIMAyvth09SVqWvfH6iN2hWmm8BMkM=
Received: from github.com (hubbernetes-node-57a02d1.ac4-iad.github.net [10.55.90.46])
	by smtp.github.com (Postfix) with ESMTPA id 4C3287812A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:12:54 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:12:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125740/c8a8a1-000000@github.com>
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

  Branch: refs/heads/1125740
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
