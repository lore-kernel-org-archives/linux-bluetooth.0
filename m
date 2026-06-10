Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02075349AE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119361; cv=none; b=Rnb2a07c9vMBaPzadFwRfs23CNrkblDXX5gyvSpGJZVXEMB6dCZOypC5PAJ/QocDD9HeY7787Pm6p/RQB7ZkzhvpNnTN3qLQ5v1ejG1ZKDjlsR3EDVHzqEREvOK+BhbIGrq7AVOZch0qSJieX94ZrObKey/CFQMqswb8ZljpjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119361; c=relaxed/simple;
	bh=SsCWlpe2+P0tHVEQ1PQdNcbguJJpEAlQgaHwWuEeet8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FpZwc625NsVGi/g1rgGqM+8c8ZWKJnaM712Jr1U1RiOCglOIDPq9mNaC0Wtz4+/C6r/emMj54IKPh2JELcCRo5PZyaxx5ggTPgUH7UFj9BXQ7jcdpruY5F6Ex7HWT8pcUcGnpky8kdQlO+qHHIwdR9Z/9GMIwYFk2LT6322uXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BWGjKUdE; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BWGjKUdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119359;
	bh=pjzC00p9k27MtvR4knbsjScjikRen155deBtGcSmxww=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BWGjKUdEj2hOMAzZqbB8X1LaERmuh0es+9/pGs4aHjjQTVAuamb128hGklYwSVYQz
	 CRKwst7OWReB5ZEsCb9M01Zf8k7GXXZ86VGRqVQ2iUa+Z12D0ksIKCV9iY4tGFgKPR
	 dGTmzTIeIV/RrnkJx2iPLky+fM8MCcmPwq6INxHY=
Received: from github.com (hubbernetes-node-771f6c5.va3-iad.github.net [10.48.221.62])
	by smtp.github.com (Postfix) with ESMTPA id 24449500917
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1109089/cc2e16-000000@github.com>
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

  Branch: refs/heads/1109089
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
