Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988B2F5A0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808933; cv=none; b=mrq5BBDQUlj0WpPXCKmAya9jFkinjIc5XfYQ4iTWw9zOvHxCYssGpP5ude3MFfWbf7xVFSK7uI/DyLl3EBOnV570KFzE8tuuOQlgacuRnKwMDiopfPU/Ya0HFi8PIF2t6z+3vVlF+EucdXvZs6YgKkkkNraljijt4TJijjSAyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808933; c=relaxed/simple;
	bh=m1OMvisNKnprWaHTiNnr9qMNCd0ORYF8ud7uZg3pV3Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uq258vmHOe+wXTCYfd/HLSyB84cmSvx2HVXfIMrbPIORcWUbJ/vxL9vQbuJ9SLSUgBnZLcADIhC/bSFkPXnCoV6PBMI4PNfaeAJm64BPfpSm9UhpVZ1SIFE0IgERPlGwp3C1dQ+41pYpq7XqmcDflFMepwaIuXBUUs/PsTGSrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PBasXBhY; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PBasXBhY"
Received: from github.com (hubbernetes-node-95c5780.va3-iad.github.net [10.48.168.39])
	by smtp.github.com (Postfix) with ESMTPA id 5875CE1034
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762808930;
	bh=yc+6rpw4qLdRctULfv+UvYR2Gl2IxSFSOKQZ/6uLyCs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PBasXBhYEwvcDFRLPmLcUEdKi+omO4H7IlSmqYLAZqsbDcqBDIaJuCe0NidbkbsuV
	 PGaM50kZAQAfwTRA0o/0NcXA0WrOHNhdncmmIYR+VwEwlHOOejf2Q/qjJXzXSGwMfr
	 U8tKbthS0iF8dVNuyLl2PW6S62mRi9hpLgkgTvlA=
Date: Mon, 10 Nov 2025 13:08:50 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a7b0f2-5e41d1@github.com>
Subject: [bluez/bluez] 5e41d1: The GATT.Client option is in the wrong section.
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
  Commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
      https://github.com/bluez/bluez/commit/5e41d1e1d361e7288964e4c2c5ed90736025662f
  Author: Pavel Bozhko <pvbozhko@salutedevices.com>
  Date:   2025-11-10 (Mon, 10 Nov 2025)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  The GATT.Client option is in the wrong section.

GATT.Client is currently in the CSIS section, but should
be in the GATT section. The bug is that
setting the Client option to false has no effect.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
