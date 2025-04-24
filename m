Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02227F73A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509530; cv=none; b=YgrmetQukQk5iSVa90B7M0GpcktctoBT9WlcBY92ctJvVNkp4/tFCpoelxzHLiUImojWjOOie+Rz9E8EbczAiObXXdYAFCs4oSajWiQSJHcK2O0T5+c83cpm3uXoRe0E80AsD/UT9P36CAsgoTWg5HNmDp8jVsi54R3Z3pkPovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509530; c=relaxed/simple;
	bh=9rL4FQnPkmCyP8Zu0CsHvqDUVyySgiKlMxIlVR/KJvA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=n4XHHyYn+LU33tSrsx2ZyOKFj+KL+jiMGOr8jFcDaUSsCF3OEDoC2QgURBWX6BVM6xVQjvdH4evxHLElHIeRpKIBARzUzwpadu1VoTYT+s+gwPZPOnBq7Roz9+gusrn2tNdIIjsnvdQyDJTtT57ITDjmM+jUlYi2En5fBruLV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kw7KJJox; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kw7KJJox"
Received: from github.com (hubbernetes-node-c191d69.ac4-iad.github.net [10.52.205.75])
	by smtp.github.com (Postfix) with ESMTPA id 3A1E921014
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509521;
	bh=Tm5Z0B4MdnmXmlYWZOXYnYLL7qdob+5gF2BeyCWH/IM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kw7KJJoxe4yTYgw+F4KoL+QgU0y5Z3W0nxse3+zDXYv2qnuQlNQ3qKCEUmCO7dha9
	 ovGhYZ3QSb3j8x2W4IXhHYE8iCZCmpxwhHObBgPIcKqmfi61PtB19Jlf+iBR5Y0Q/j
	 C8O+I5IQaPJZ+++K4zhYMpFUsgkH8AFsWX2hO6xc=
Date: Thu, 24 Apr 2025 08:45:21 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/955284/000000-6ae7c4@github.com>
Subject: [bluez/bluez] 1e7f2a: org.bluez.Media: add SupportedFeatures
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

  Branch: refs/heads/955284
  Home:   https://github.com/bluez/bluez
  Commit: 1e7f2ad78caad4c096cdcc5a565cac68733ad6d9
      https://github.com/bluez/bluez/commit/1e7f2ad78caad4c096cdcc5a565cac68733ad6d9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

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


  Commit: 6ae7c4ed188dd06423d26a480dbad895b71e2298
      https://github.com/bluez/bluez/commit/6ae7c4ed188dd06423d26a480dbad895b71e2298
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: implement SupportedFeatures property

Add org.bluez.Media.SupportedFeatures. The value tx-timestamping is
hardcoded as it is currently always enabled.


Compare: https://github.com/bluez/bluez/compare/1e7f2ad78caa%5E...6ae7c4ed188d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
