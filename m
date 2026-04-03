Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C99625
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243470; cv=none; b=Vu+fsUCq7vKtnevlN7LNPul2Y3mVyM7zn2UTYAmVuENEy4IF+jcHeq9yMjNZhh6og7NDBsPjmEdTlFRf1hb5NWmDRO8nj7OJ8wrgyVLIIMh8yZiaR/fgADn49IYSyL2oJtdv/XWrAbbSGtKG/1FI1TAcu8DM+gIiDEf/AGm78fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243470; c=relaxed/simple;
	bh=k9fjEsHXgldgcqpEthPYp/YIaiczAr5mVPOHSyhi+h8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fharfSr8Fcs2IpunWrwNoJvge42xyypoKFQSZByDLs4RBqwl+YHHhQjMUa5iGu34uwtscQr3tD/0ZDK9lAb7D5Qw9CwoNOwdzI5HQsizSYtNggPX3pNfVyHF/akS+Qb7jtwnM8rzYrPFiRuxyxXCp0tKSFXDY17oys3ogWgJhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XcQnrtaS; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XcQnrtaS"
Received: from github.com (hubbernetes-node-4547c2a.ac4-iad.github.net [10.52.173.36])
	by smtp.github.com (Postfix) with ESMTPA id 4A37A40018A
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775243468;
	bh=4zUeHoQe+j3gKaf5vksaP9F6uk6w7TYvM+PFRy8Bz+Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XcQnrtaSD4QD2gUBRVg8jzculCjTwHeXxqqLjDy2xsgK6vAdY44wxpv3cylzdbu26
	 IP8VDTPnTETvpveClJ5srs2W8XSVql7UQaZnTvn8zYJxusXccQHBi+u8iV0VcssY5Q
	 4oAicm8jdzvmXu9ABtiU/iV8noW9IDQf5I5VPq4k=
Date: Fri, 03 Apr 2026 12:11:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1061476/f1c313-000000@github.com>
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

  Branch: refs/heads/1061476
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
