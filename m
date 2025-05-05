Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC723CE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477219; cv=none; b=tQIvzQE6mOwjlF9rgtEtYytHnA+TMyni+ANMVD8BgMp38x3OlVYO/cfOxsPPaqY1RGeDxoeRuDAmUyKHNioJ//yXK0rtbzVyL6GGYfz772ZWRRfWA80+l9jp983qigKDluQ3mw1WcA6igNeSoag4fSYfhNo3DU534kCAFjk8hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477219; c=relaxed/simple;
	bh=tWdmS5ewZVKOiVjsWjTPv0LcCK7jhLXx8+wrSZvXxkU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F2YCCmfYK1vTnv84oZIGlLCUTdmkN7RyPkb77OAlo5xEjspIoPHTiS57Vh6t1EDDrB/IcM4ARHiJHAyTY5P2kcGqFaL1DlvUCJzvht2fTj/Pb+0PvTt7z6C0POiVXxRD4aCbBX8b8TOV6dgTx8ulHa+jkH4VHRu4XjOisZ85Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I3R9cR9l; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I3R9cR9l"
Received: from github.com (hubbernetes-node-cb53705.ash1-iad.github.net [10.56.202.67])
	by smtp.github.com (Postfix) with ESMTPA id F1874920AA8
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477217;
	bh=wJEP9EVd83Fm17DuIdhWvQgUCr53qhcQmKERnJLLpV8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I3R9cR9lxRTtwMknzu2zsidOALK/4TbkqgQHtkm9aHq3336ruqVdsxnEQutubRQ3k
	 gYYTiAepue9LLRYVhUbYAiNnxBfup+SyA6sHon0Eo+Zy3jiu39PWgiDS7sSeM+oB3b
	 WgliCadsIfjF2ocdV8L1t8lmbdVunwzMAF9+pkoo=
Date: Mon, 05 May 2025 13:33:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959755/e28486-000000@github.com>
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

  Branch: refs/heads/959755
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
