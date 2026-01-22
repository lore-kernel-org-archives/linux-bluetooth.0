Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE62773FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769065382; cv=none; b=QmSjvvcdhGr3ENZjNX4xZDdn7ukdn86yD/eWh4Y5heaB+mX6mG5QCPfTjgAoCEb2exGRm3NHVneqhSr6T3IBElay59dszyMIdZBiVUHQ+Y1YCxURTsAw7CLbZwif+pMpBIVasxGIN85MtZdX7mT6n/pO48mObT+AEgkiiKYV9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769065382; c=relaxed/simple;
	bh=8W4q3QMrvL56hXY1UwM74dZQM0jyGidrFoZFsA8oLJc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KMCDQciEJYUg0uS9vciHT59awjGLI8rfkcNqqWJhE2A0VJXFuKq/xBcgYxgsLtKNpl/1TtLbaUc4GEILOerx7xqNgBcYGacJgDfbZvqIBZn2ttYvLEa5VEqF7eFIZK5Qm1MtN0qFZ+6VtWk+hmRLZP9J27FguA63HdEz/iPDVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jRymUHAe; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jRymUHAe"
Received: from github.com (hubbernetes-node-0389366.va3-iad.github.net [10.48.15.50])
	by smtp.github.com (Postfix) with ESMTPA id 8DCFDE089C
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 23:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769065371;
	bh=Mmu8gZV9zhQSZHOeECXYvuXN67GVnIn0RZFh73xBonc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jRymUHAeMA647FKkJa45ejmT/7oAEOZMZapKM4kgPTAqxFWhfYAcTpkljcHjORAzl
	 icsuYWsTX+Swu99L8gsp5XH1QqtyIAfLrAA329qbFB6V3lHMgpoNTYaX37s/BwPJA6
	 GnmqXUmrlxfJ944MTfd6Yxv4pNLVdOoMQHvyhw9o=
Date: Wed, 21 Jan 2026 23:02:51 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1045489/000000-986b05@github.com>
Subject: [bluez/bluez] 986b05: device: Initialize device volume with a valid
 value
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

  Branch: refs/heads/1045489
  Home:   https://github.com/bluez/bluez
  Commit: 986b05c0be675126da8b9c290ea33d3325b8a9cd
      https://github.com/bluez/bluez/commit/986b05c0be675126da8b9c290ea33d3325b8a9cd
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Initialize device volume with a valid value

When AVRCP is connected earlier than AVDTP, this invalid device volume
causes the A2DP sink to reject the peer's registration for the
EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
set the volume fail.

Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
