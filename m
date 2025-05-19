Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8421D63F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747683845; cv=none; b=bQAqGUc9Sye/FwvfKCi+YTCoBC7cFLNd/YSjpmkVsavYfDyaeGEMr6zIIcR2IE5bCFYW4KNLiwHy6lkNoCZC9fuHCWRyF8BcSvBjbx4U3NTnENXhFDVacbRa0lcSJNDDGEkP6p9vf5YnRS0MYvT21RY3QWqzTk6ZhPxjv4W/FBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747683845; c=relaxed/simple;
	bh=IWyIi5ePN02oQ0gUvu43ivphw9FjQptLE/AGgD+ZZU4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F8yvTHAkEZPuqcJ5VHP35O4wmAoLPeBjQJSxOHPsiBZpRaQRyrcP9l5W3Bj2wjJcYX7xOVVPSIzczDn0Dg+N4CLtTChgsHWTkyqPsSn96v+J4LulWeWFlVAurEaNvEYtYEbyriTZs4dy+aBcHrN59//rDOuSpjDzGuF5GxxmU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k1ucJaTO; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k1ucJaTO"
Received: from github.com (hubbernetes-node-ec1602c.ac4-iad.github.net [10.52.180.34])
	by smtp.github.com (Postfix) with ESMTPA id 2648F7010BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747683843;
	bh=1jzaUr6NA2U3EFFhKaWK9caMT8YBTiFLIPo9stI3YFw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k1ucJaTOIGeYY2GPj6+n3d5RbVqcUVGgfGF6O27rU1WvszGVaoVjdfxiB/Y30I8Q0
	 N7OF/6RyfzC4ivP6zsnWoSYv+6dCEr+ZFcU3Rvbjb88n1umtOfoptEKpm8vaF9cXVK
	 24hGOdtiykBWrYRe+BZ74A/+FHVSlzTkrvVYbxcg=
Date: Mon, 19 May 2025 12:44:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964317/000000-c3826f@github.com>
Subject: [bluez/bluez] c3826f: doc: Convert mgmt-api.txt to mgmt.rst
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

  Branch: refs/heads/964317
  Home:   https://github.com/bluez/bluez
  Commit: c3826f537e73adcea58f5ba7a9391d8535450a89
      https://github.com/bluez/bluez/commit/c3826f537e73adcea58f5ba7a9391d8535450a89
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M Makefile.am
    A doc/mgmt.rst

  Log Message:
  -----------
  doc: Convert mgmt-api.txt to mgmt.rst

This converts from pure text mgmt-api.txt to restructured markup
language and then use rst2man to generate a proper manpage (mgmt.7).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
