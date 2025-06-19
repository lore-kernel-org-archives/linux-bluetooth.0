Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360628DF50
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345105; cv=none; b=SUAbxtvxjThO7fNGkG7N08JnqWOueWmIMOHEv+BDcuURm8cwTltUwjUc8/75rtunaZZh/R2LYiaVqzdEXy2hmH5hoCYX2jJavb9N/cu5PUwHRukjMskC0VM7qcmE/NK1N/i+GHpdWn6C7bkcMMk71ndCspY0loS9ZUVTcAg03VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345105; c=relaxed/simple;
	bh=NLYxMe+Ev5SE9Y36pbvGokYKld/JHhRbNyh8KUGg59M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JSJ6038ea66R9ooFVlsq0QWtjhcC/U/VfkR3mqsYG9EH9CpTQMkm9M3alu1Tzf8292sLhfRiLJqzC/ijBEnfP2PKryUX/FKwb/QrnNSqBWPPW53+HxVX7eXngRWtcEmh+nww3U/shu9IWbXrd9zf7E0HtI04ZJKVGB/lbdMCuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FF419GMg; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FF419GMg"
Received: from github.com (hubbernetes-node-58caf4e.ash1-iad.github.net [10.56.168.37])
	by smtp.github.com (Postfix) with ESMTPA id DA8D0921297
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750345102;
	bh=/duvoYt2l8uSWo8kEBpzj/ULMLqtUZ1anxwCPMWCdhI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FF419GMgdvuX2+OzrN3K6sQX59vRKIvbkcMmuKRAZH9lFyQbxVO6/ntksPuPNio/a
	 vrKaJe/EmfuRU3FU+dxySvIvpEj0qPFJik1QDioOvg0EmbVYrcJQ8M1ZOc/Uheci+u
	 OZ3vObDqtiAr326s2KWPm+DPlq0e4d2QfdPiIEq8=
Date: Thu, 19 Jun 2025 07:58:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970691/7d1b3a-000000@github.com>
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

  Branch: refs/heads/970691
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
