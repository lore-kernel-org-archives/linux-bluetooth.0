Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C872C1786
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166068; cv=none; b=iKh8eivW2cvAJqqlJ1AZE5c0wdD7HJw4QrefL0p2KZ+FkFrMFJA6coCFiZEuGg+bL8gTeshON9+FE7e/D+rX5hN/nnmaVkrewwVNrRq/MyXjyA+XM5O1KXuOTnwfu1spc4hzbPJkqyde49RY3gQx9pCO2ZO2TNpZSn5VnsioiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166068; c=relaxed/simple;
	bh=ty/aqY9up+Xb8mXco+s+pehsl4Z6h0RFZPC7Nj3p8SM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GptDcoyR5ylV9BizSNcJoP41fbAOtrl1fYdSYq9TPiLL26/n324opIu5qWSY7iLVA0YpuuEJUY5fi35yEA96VagB4cX4ujBx/0SSLWaS5Ci1D+2MEQUletpgeGWtk0xgHjvRPSWFcSm1THs5EOCOHeSV0r4yN6+zjf3PlljFKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Np5wyLCc; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Np5wyLCc"
Received: from github.com (hubbernetes-node-9edabb7.va3-iad.github.net [10.48.219.77])
	by smtp.github.com (Postfix) with ESMTPA id 34556E0BC6
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769166066;
	bh=tVaPRoHhuqEmkc5nPBvZIhGxvYw6vT8Ai+YaFl9y5JU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Np5wyLCcW5fCjIFvHMVTkNwcGfe7ji73n9/KRTdXLO1GgUXbTXzya88uIOky7dBQi
	 V3wgGyhWvX+NWOfSS1/VkYIyt3glltdt4YOktAoUbz+skwDxAD8OC/zed/yELehsTp
	 nn097Rs5RLxzJaeYseC2mvtqBBN6x7H4wVsfQ5+w=
Date: Fri, 23 Jan 2026 03:01:06 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046203/000000-3283ef@github.com>
Subject: [bluez/bluez] 3283ef: doc/qualification: Add PICS and howto for the
 GATT...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1046203
  Home:   https://github.com/bluez/bluez
  Commit: 3283efeb4120304864399e81df3613c14b438491
      https://github.com/bluez/bluez/commit/3283efeb4120304864399e81df361=
3c14b438491
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    A doc/qualification/gatt-pics.rst
    A doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GATT qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
