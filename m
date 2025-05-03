Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0A4C85
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746257678; cv=none; b=IarqyAVSnJNr5l7EdKLMA9EOiDkFkupw4uVBYmQlAgSHKKsSLDckZHInT0uO1NQArAGVViRZbYZKDQRKVYIusECkbm3+Om+LuZoUmjwLo9BGVYY91NIUs+m5MBq0yzcUuLc9K8xXnjW2QMGVU4cK2Ss8uuQW/SkWFSP0VvMupU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746257678; c=relaxed/simple;
	bh=GIgSPyZxV4yLp7af5O5Dbt4HKVq7OjPnGvssmDkWV0E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fpFMGLT4L5FE0C+5vpgJhDT5RkbrfJVxblnDFGr9gMJUfxh0E6pSXhGM6JCl/VqXbaC4Trzn/cm/b56w4874/B6b+Cn3KHWghJPxFuqBMtWOitzXYekC9fP212ghsJqC8pMhf9gsK+YPM7GVtIVYSEtx1yN2vLyY4k1g/ojN9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZRTG8zlH; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZRTG8zlH"
Received: from github.com (hubbernetes-node-640f864.ash1-iad.github.net [10.56.170.15])
	by smtp.github.com (Postfix) with ESMTPA id 847D71402A1
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746257675;
	bh=7h2QMTexZaG5b0GSzJKASpeYhYC4AkufbEiNUC0vB4k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZRTG8zlH73WlM2IBzPBP9wJijPRt2ajFtvbbqDgVYXHFVqINQGnmwGIAxuqwACf5y
	 vpj0JclIIOKsLSTthGo6i6E9FoY4RKDfLX39FgpKDAn/vZaRVcmMj4tDEBoLwyKfPl
	 X+JHqLd0t+zTYCPsSwSutsJxm7Sm8e34LDCCL/vo=
Date: Sat, 03 May 2025 00:34:35 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959306/000000-9949cf@github.com>
Subject: [bluez/bluez] 24cf4a: org.bluez.Media: add SupportedFeatures
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

  Branch: refs/heads/959306
  Home:   https://github.com/bluez/bluez
  Commit: 24cf4afb18dbae2167cb115d3b05e6d088561899
      https://github.com/bluez/bluez/commit/24cf4afb18dbae2167cb115d3b05e6d088561899
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-03 (Sat, 03 May 2025)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  org.bluez.Media: add SupportedFeatures

Add SupportedFeatures property for feature information that applications
cannot find otherwise.

Add feature tx-timestamping. Applications cannot enable it on old BlueZ
versions without that feature, as it requires special handling on BlueZ
side.


  Commit: 9949cf5df5744541a5324a3ced1e735060be73f3
      https://github.com/bluez/bluez/commit/9949cf5df5744541a5324a3ced1e735060be73f3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-03 (Sat, 03 May 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: implement SupportedFeatures property

Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.


Compare: https://github.com/bluez/bluez/compare/24cf4afb18db%5E...9949cf5df574

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
