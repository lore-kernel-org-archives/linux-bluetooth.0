Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8413255F3F
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433937; cv=none; b=n1ovbDNV3MTeTHqcPp03SMi9hJ9zs8p123QKsxcEnIwGcXR6Rgy4550wQeGwWslO2if/gFc0Ux7HFhWpsItTDbWMuVP0k5kGnl1KG+rIzF3b58Gd8xIv+ce97pPiY4IgKE6fjT7/d+aIZG6yHM9sEAP2kfs+sLtJ4yuvfvJJBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433937; c=relaxed/simple;
	bh=P9x/TvREuxx2Do0z7/pkhQuuwONrbqJKrCFwi5ULVUw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PVfEg8wZ4PgzlYztQFe2/zyefJTEWkwykPH2bVKAbU9ILUpaKvNoycK4BBvbsazZaXCI5Z0s5AkZFUEF+qztDB6ub67ePcmgquACalq19x0IPbgEWcsLX3XQSICTdULY9xr0d6KK75CQijb8jk8vVQzHMaTsymKMZJOAMNVyfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ML5qeZX9; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ML5qeZX9"
Received: from github.com (hubbernetes-node-2512831.ac4-iad.github.net [10.52.200.13])
	by smtp.github.com (Postfix) with ESMTPA id B31F6401196
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759433933;
	bh=MVhBSzHX8i53gmdpJG9MbkVVnkgrEavqb9Do4kPVnYM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ML5qeZX9Vk9tc+3rXhWCfzOwTBCvfM7xwmbD6A8TbO8Fhmfy0uEJeJKRh6pWnEx4j
	 TEtB6l3Mje0l/Wbh/knIOxfdmdKeEfvNK7buoKZMMnB0Z0upPDeV/j0AiovT9gHx+6
	 Za0XIqiSwRR6IPmXXNo8PfRWkTdc0bz9zkg7Sw3k=
Date: Thu, 02 Oct 2025 12:38:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3e5547-f1fb4f@github.com>
Subject: [bluez/bluez] e3a16c: device: Fix privacy
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
  Commit: e3a16c28e4799d53141c9fdf10d248648d560bd8
      https://github.com/bluez/bluez/commit/e3a16c28e4799d53141c9fdf10d248648d560bd8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix privacy

In order for devices to properly be programmed into the adapter
resolving list they need to set the flag DEVICE_FLAG_ADDRESS_RESOLUTION
but that is only done if device_address_is_private return true but
currently it doesn't check the rpa flag which indicates that the address
has been updated to its identity.

While at it this also update the rpa flag to privacy to better indicate
the feature rather than just the address type and then introduces
device_set_privacy/device_get_privacy and replaces the usage of
device_address_is_private with device_get_privacy whenever the features
itself needs to be checked, rather than the current address type in use.

Fixes: https://github.com/bluez/bluez/issues/1079


  Commit: f1fb4f95f49ee4221aa8352bc94cd53f06407953
      https://github.com/bluez/bluez/commit/f1fb4f95f49ee4221aa8352bc94cd53f06407953
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  core: Fix not resolving addresses

When using the likes of btd_adapter_get_device the address can sometimes
be the so called RPA which needs to be resolved in order to avoid
creating duplicated objects of the same device.

Note that normally the RPA are resolved in the kernel but there are
instances like BASS Add Source that may attempt to add a device direcly,
bypassing the GAP layer.


Compare: https://github.com/bluez/bluez/compare/3e55476bf6c8...f1fb4f95f49e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
