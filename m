Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AE56755
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790325; cv=none; b=oyOjneWLQSdryleAfF+iblrK7r3a1tn8Lda7Y9rIE1F7uoz3BqeZDWVTVuA1q3rtGV+vsLyBcrQz5gzh1RAW8AvYA5z+8U1Wu/2tkuuQzTXB6o7LvS924e0/bHo9HsYRQq9gBau/Z/tKKgQZonjrCAiGAV/9Kv6WwvuNJlJxP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790325; c=relaxed/simple;
	bh=W4cROJ/vy/r19dUucgvTfe2EtHQQuJVYL2X/tzzMcGU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f/novOtvtwJMQfUa3VNRwJ0VbiLrWhifpNro18NDuSsVi1i1VzgAyeuKsSD4DnORGv0GSjARbPv2WtMRDlSk/WYE9XUI05zAE24LTPg2pV8SC3xjLPOmGMrbJWqcvtx/o3gUBJLJbvpR+Kf+hCe+KDSsqHGOE1bFq0volEqdo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d4Rl0yzW; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d4Rl0yzW"
Received: from github.com (hubbernetes-node-73b0ef9.ac4-iad.github.net [10.52.211.103])
	by smtp.github.com (Postfix) with ESMTPA id 251A6700BD2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710790323;
	bh=b2n7jEPmpi/bSX9579nitRyoIMZNI+bmFhw82v0FRLw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d4Rl0yzWVNS6Od7PvTBWeBeIjbWmmcKCXRDr0vgM9KHa6ZOAocFsTtP3ek/OOB28P
	 d645Z9GFU/4MZyklsE4QzaA5CZL6d7N8xPxFzwuookgrljCdMjEu1GmTrFPx98p0/v
	 l2XmNMOC20PS/R+cuxjdqNIlItvNepSmnu4aCWnw=
Date: Mon, 18 Mar 2024 12:32:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/84628e-8060d1@github.com>
Subject: [bluez/bluez] 8060d1: device: Fix device_is_connected checking for
 servi...
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
  Commit: 8060d1208673826665b7297c27aa75003521b52a
      https://github.com/bluez/bluez/commit/8060d1208673826665b7297c27aa75003521b52a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-18 (Mon, 18 Mar 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix device_is_connected checking for services being connected

Change 44d3f67277f83983e1e9697eda7b9aeb40ca231d seems to have introduced
quite a few bugs related to device_is_connected return true which
prevents proper cleanup of connection.

Fixes: https://github.com/bluez/bluez/issues/774
Fixes: https://github.com/bluez/bluez/issues/778
Fixes: https://github.com/bluez/bluez/issues/783
Fixes: https://github.com/bluez/bluez/issues/784



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
