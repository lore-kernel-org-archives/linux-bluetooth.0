Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40261EBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213753; cv=none; b=eJUHiKYFMpt8cHCN6OKI4diyPE3UHQx0efXTe8b0yHVHTNHM9J2zlcqxVtygj19KhiIvIEXQpPHaqXbgB79tjhaTvtCdzpFqvFjY+tkUKw3qZeXSsLRqKqRgRkpcCZ7tUG2Co60jANX6QkgN7OlhDuuN5+LIIT3CRfst9YH/c6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213753; c=relaxed/simple;
	bh=08W8+E9ijFSSyAKmNBrshn08LLDb/74vLEvYS3Mfe+E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sZJ3fFhY+oOL7osz4XmkRaDE6ptshJxhWYJXBKf/D4B9wS34I3JyXxL9EJcWe/IeMZARF/q1VhexJmyEeU+Cj8RRiRgyd3ZDaxmKCf/R07QKT/S3SJpy4ko/LMjJhkWn5wFj3RKq9FaU4Jvb3JTyZMF1z8V2tgYZFaB7vFDlIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OaLOIGUf; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OaLOIGUf"
Received: from github.com (hubbernetes-node-653e59a.ac4-iad.github.net [10.52.162.17])
	by smtp.github.com (Postfix) with ESMTPA id 68F165E0815
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718213751;
	bh=sUSNeKyIAgfyfZ2dmp4N2NarYeKOxBUWOeWzmpJKyLw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OaLOIGUfkMP6tc2D+mPBoP1dPoeuIvgO8d032ejNYAcq62Vht0UriqaUq1z4l68yU
	 QVuw2AEmO7g2yeqOzd0pCl3alCmNuxGdmwmp2MPVDACTSIoSxtRvrXSffo/SRLluiq
	 C/0YiD2yTe1z+wUJZUOInLZQOKzUEoEuWZa1l0t4=
Date: Wed, 12 Jun 2024 10:35:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/272d8e-891552@github.com>
Subject: [bluez/bluez] a37e47: shared/gatt-db: Fix gatt_db_clone
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a37e475f7252858832d5a1b1e100beb21a7c9a4b
      https://github.com/bluez/bluez/commit/a37e475f7252858832d5a1b1e100beb21a7c9a4b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-11 (Tue, 11 Jun 2024)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Fix gatt_db_clone

The process of cloning an existing db shall also clone certain values
that are considered when calculating the hash since the resulting clone
shall have the same hash.


  Commit: 891552999317014a7053c83b81355d35654ba839
      https://github.com/bluez/bluez/commit/891552999317014a7053c83b81355d35654ba839
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-11 (Tue, 11 Jun 2024)

  Changed paths:
    M src/settings.c

  Log Message:
  -----------
  settings: Add more debug logs

This adds more debug logs to indicate exacly where and what could not
be parsed.


Compare: https://github.com/bluez/bluez/compare/272d8e8c9599...891552999317

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
