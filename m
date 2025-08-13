Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE52F0C47
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073026; cv=none; b=cbXmGvwhWBSCFbYLvMUiY/Khrb3Caoc2wmD9LZi5DlCwPHsNz3EnzE3xM26/ettUcoyZtFQBMVwbtJgOJjebmxfzQ5QsEQwom/kPh7mJtVXTf99bSer4FmFyJ8/3woVAR6NWbVFACdT5tk2IKDcXAVnStd3ciGlkZLTte9HgQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073026; c=relaxed/simple;
	bh=UxH7DLb1HC9n2SwiiI4IK3TR8pjCNc6/NV1MGY7FRjg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AurMemGXOnb2Qp47CEaAWh02mjHHkfAl+l9f+MEjicpLejcdtTE2s454KDM7s3vQM6QCXDiUIlBdzOMRG9sUnwNN/xf8Bdz5dz57BCgFHZ8Vw77fjenFOUf0KTkMgHfbFYHSDWbtxo0CdfmekZ15JVRhI7JUNgKrNFgXzXRN5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Sl3uWsd5; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Sl3uWsd5"
Received: from github.com (hubbernetes-node-b4f84d1.ac4-iad.github.net [10.52.171.47])
	by smtp.github.com (Postfix) with ESMTPA id 430B76411F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755073024;
	bh=A5sXcn+Ry8f1woZvUPYbnPGPmwcvPXGZ3WGmrYzhteg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Sl3uWsd5HHlV6ewlEbENZCerdmn3EFwfwcYNEYXPtAQ0Zv26Lm2berO2tHjSMO4N8
	 y21BjSjujZsOcEktw5LHy+hhKBy9SwvTyN7OzcJkzxwLjYrouB8GQ+Pmp6lglevH0T
	 UsFSGgAebfoadR/+1joH0jPDMjsyNVWIKJbHv6dc=
Date: Wed, 13 Aug 2025 01:17:04 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990883/000000-2eb941@github.com>
Subject: [bluez/bluez] 2eb941: device: Add SyncBroadcast method in device1
 interface
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

  Branch: refs/heads/990883
  Home:   https://github.com/bluez/bluez
  Commit: 2eb941606af4ac173527cfe760ce37a0bb401427
      https://github.com/bluez/bluez/commit/2eb941606af4ac173527cfe760ce37a0bb401427
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-08-13 (Wed, 13 Aug 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M plugins/neard.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add SyncBroadcast method in device1 interface

As a BIS sink role, BlueZ currently defaults to synchronizing
with the first broadcast source device discovered by the le discovery
procedure. This behavior may not align with user expectations,
as it removes control over the target device selection.

This patch introduces a new SyncBroadcast method to the device1 interface,
allowing users to explicitly choose which broadcast source device to
synchronize with.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
