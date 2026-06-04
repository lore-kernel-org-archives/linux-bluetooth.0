Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D641B372
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572311; cv=none; b=M8SIQLvGfGGEcoSKa2WlmW1ONfxTz+9K+BFBEbv7I+Kg8tVDK1Lmu504pZ7/72HM9PkgBmoIm8tTvLV1CJ7K47ve0YEfwlVEv7WP+efqZpX7dD51pOhkDmthQRVlqj5mQ4vLwHDrFjsqDatV7TYrsgk9b7154QVvGRkNMlPWBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572311; c=relaxed/simple;
	bh=adLwviq7b87TCoQ9tzlP6k5M2avj1Wn9d4OYMHrb5Ss=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sM9LZJw3THP6EnMyOWXg8qNdOWHj5wwCgCId//nPHcPXw4wNPC5ZTtJRnfgX0nLlJuwHSa7AfRnkMg4OVhwcjCakqqfF23KPEeYnbQh1w2bsyVbsLNg+4Y/n5E28W6r5zjAiqY9xVDIaH0qc4sKdKI9Zi4VjKPwgamHvxQu0/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gpsdryv2; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gpsdryv2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780572309;
	bh=CEsD5TTuPPtAe72kAIs/D7XkOvptFcT+L47JnfCODuQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Gpsdryv2FatzAG5QeeweoZIUBymYI5He7FbSQ5aFa9QfMYRoYlAuyrWjD/ZUs0+xE
	 /tVmfsvgmbtgVeXYAtihw3hJTLjdA3gZJUgzuZUzrknq5B/296XXj1Ta3byjUji2hd
	 sqwvtygTQvRizizDyA9IIjzLqHokFj5YpzpzR87Q=
Received: from github.com (hubbernetes-node-db9e569.ash1-iad.github.net [10.56.200.58])
	by smtp.github.com (Postfix) with ESMTPA id 993E892123B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 04:25:09 -0700 (PDT)
Date: Thu, 04 Jun 2026 04:25:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089833/5e18ca-000000@github.com>
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

  Branch: refs/heads/1089833
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
