Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF33220F37
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255478; cv=none; b=PYMT7oeZp2BZy+6C7GhqMts2ZHh/AFBVfTOEDH9kylCF6+Q607TuL4VBDj3fGBdkl/FQFALjB8LNemVR19BzgCB9R88SFdw4xNo0TFVs/EwPyY7cVF1XgGlvL08OI1poUXjtECE2P9pPbxeeHyjA3ytgjjAOv9IWb3WgBnzuUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255478; c=relaxed/simple;
	bh=NARVj30R+egEYZsesDucKpX1GVWaSo7RgwxKShWj21I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M3tyImNdO2YZHoPoLhuayvEvF6ZaAjxi4E+YxtkvYEeC3seFk8ywn5ck1AuLl5BHLqeVtjQiMw94VPcy1KZSc/zoL4qByahPkHnpknBMNXD4Q4VD65nVMPVNehUT0VD7T9A0/FI5qt6XEe7czUM4IeBhss5oLllJ4cN/c77gqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SWMGAq8y; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SWMGAq8y"
Received: from github.com (hubbernetes-node-245c001.ash1-iad.github.net [10.56.14.37])
	by smtp.github.com (Postfix) with ESMTPA id 7E9AE92032F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755255475;
	bh=oXCRU8iuVKPQEL1Y1yLLGF0JjbBMg1tF3rDdQzpG0Vg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SWMGAq8yHOjdHmCs2wxtd81fmrdV2hgHaTsFhYqGIgS2Sf+HIRpzX5LDnzozSSYbf
	 zg/9euEG9j0jiD3MF3nxvEWX2HAN/AsEGq0wHLOH9GKVwiD2LtFLl2R3U23v+bolvc
	 vD/K0kXmlRPug/jEBlzRxIYZTL0GN++agOdH0bs8=
Date: Fri, 15 Aug 2025 03:57:55 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/991899/000000-5773fe@github.com>
Subject: [bluez/bluez] 5773fe: device: allow selecting target broadcast device
 fo...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/991899
  Home:   https://github.com/bluez/bluez
  Commit: 5773feeefb4f772ddc5f5d0a22411cceb7dcf93b
      https://github.com/bluez/bluez/commit/5773feeefb4f772ddc5f5d0a22411=
cceb7dcf93b
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-08-15 (Fri, 15 Aug 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M plugins/neard.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: allow selecting target broadcast device for synchronization

When multiple broadcast devices are present, bluez currently
defaults to synchronizing with the first one encountered during
the LE discovery procedure. This behavior may not align with
user expectations.

This patch introduces a new SyncBroadcast method in device1,
allowing applications to select the desired target from cached
broadcast devices according to their own criteria =E2=80=94 for example,
choosing the device with the strongest RSSI or one matching a
specific set of UUIDs.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
