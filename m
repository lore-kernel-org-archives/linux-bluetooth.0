Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4C1E4A4
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603415; cv=none; b=i5hKM0Tvhdm1IOFHZoIv4PbxQNfYJn4LHz2HstlMjZ5LU5oza41+KRhdEwqPOfFNaeJz8smHD5yqoJkA1B+ENNnCMkZRRRhjEz8VIaQc7ghVSm1Hu88xua1hGeylXDjcGwuh4m/+T2kt7lRXATIaBVTDXzyTpTh0EnOtKuWIda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603415; c=relaxed/simple;
	bh=MQErH4tC5cXz8Eac9ZRYG6w3dy6UZbTfqj2SPH1JT/M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mGPbTHbD4eJxq3S2HgrKWC6bbsgEYhjf4kgiB745dBmI6YElh7SK78g/NCgqpbCJUmzHNV9ZezbsgWH3YDAz7NqR6htwoisq/RwsVTll465u3PVUtwhixbqv6QerJWhFDDsxzV1tyzaziQkOuMZde8eD441Tkq8AGkU1sVBJ/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jSId0gPc; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jSId0gPc"
Received: from github.com (hubbernetes-node-3827642.ac4-iad.github.net [10.52.152.37])
	by smtp.github.com (Postfix) with ESMTPA id A7EAE5E09F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1719603413;
	bh=pED1U7g8rfLFWl+ieXf/ipm18pcZhWAxN8oDGWDCJUk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jSId0gPcSwmAuiRPdZy0TYoTqdbalB0NxusHh2OTCx+FYkMJKLcGRQUs2TnaG6hPD
	 n67bbvtm/aVd9dJglHiP4u2t9xnbDqRlOGr9SkPIkSCWB4HOlkTbQ2Ge4Pj1UigHeR
	 D+B4Gf67kYpgh8KqRLD33zalCRXH3rpQGz9w7/aE=
Date: Fri, 28 Jun 2024 12:36:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0ddcfa-7e0282@github.com>
Subject: [bluez/bluez] 1a5125: org.bluez.LEAdvertisement: Promote experimental
 pr...
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
  Commit: 1a51250a7ea53d3a7729c9b49d42a712205d569d
      https://github.com/bluez/bluez/commit/1a51250a7ea53d3a7729c9b49d42a712205d569d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst
    M doc/org.bluez.LEAdvertisingManager.rst

  Log Message:
  -----------
  org.bluez.LEAdvertisement: Promote experimental properties to stable

This promotes experimental properties to stable since they have been in
use for quite a while without any changes.


  Commit: 7e028287ae1a94b47093cfb328645ae1c74a2ea7
      https://github.com/bluez/bluez/commit/7e028287ae1a94b47093cfb328645ae1c74a2ea7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Promote experimental properties to stable

This promotes experimental properties to stable since they have been in
use for quite a while without any changes.


Compare: https://github.com/bluez/bluez/compare/0ddcfaeafad6...7e028287ae1a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
