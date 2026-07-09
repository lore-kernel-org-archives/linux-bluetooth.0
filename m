Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803B320CB1
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627535; cv=none; b=g+0ckDa9715ldtuvYa9DNP61cD/oBeTrVhMP1UHk1yj+By+rXL2qD5Zm3k3rIaodzf0tZ5w6tAmneLTB59gxoIx117pm/LpyNW6muNCOKhaPevotQ5XQyv6uDODSr4AQkG1JBBnlGS/aHUHDRoNIX1w1ZO87Qt4FXGN3QX14YAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627535; c=relaxed/simple;
	bh=UXPmfTNM3yRVHp5oYyEWpxLXgnZG1e0wlczuJD7PEzc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sipcY8byU/E9EOq6gvXbNxBBQbuYbEmYQx/GNaAkB+h5FQHh5FGefgC6GyUO95wF0jSOQosV64cD9z1adyLWhdbvufqYU+egHbyd6X/JCoKT4mExfnV8jTV1sE9CbkpyZB0l3Gvooyng59fOlgZEK757srgDVzkFOvs5jXYP6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N2h5JC7n; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N2h5JC7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783627533;
	bh=aNXoPQUTRevj1OFHNYQvx5s/2IUuVYgQSBAmX5uFedc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N2h5JC7nVVJNUjE8RwRdUQ/ML8c9gkDTQZvkb+CwbGcO/iNsW8pMH3q5RAze9ZXfJ
	 BBjDP/Dum7C8fxusAaAu6yWe3zmJ9M0v6V4n1F3Q/XuhSD8JJQvCE0oNDh7+diDaoP
	 ysrfmk3Nfm4ihuU4bgkpH4LIqQjodh0K2XZziq4E=
Received: from github.com (hubbernetes-node-cb7a443.ac4-iad.github.net [10.52.141.21])
	by smtp.github.com (Postfix) with ESMTPA id 7C04E78E2D4
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 13:05:33 -0700 (PDT)
Date: Thu, 09 Jul 2026 13:05:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108770/c01f9b-000000@github.com>
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

  Branch: refs/heads/1108770
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
