Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF117390CB1
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679829; cv=none; b=rJqg91YPXLFVcLs9+/W8SJXSu7rQWBAcM1FYaUEVWGaxg0nHWDIc7dv8LGPAw+tnbGfWdlPnrsVOEvjY6NJvwcJ5zX4p/sChP5dOemK6rIVoVbfrskB5aM+OuVJPQTRYYnV9rSDd/F+rQF/OL5SKQOEZFvmJ0NRiF86EKCmR0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679829; c=relaxed/simple;
	bh=keBoE51RM78fDVxZbzlzqJg4QIgevWzVni4NCyG3Nj0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WLRcCiGYfFQILeYivYt99m7CiROh+5NHnHFFJ04R2pe89jeMApawEKnj2dSoeiIw565NYjyoZ/8aLJ/MA8VBgRlqqvAPQKlrAbUgqwVX0QoaPBgZxvIgWKL/bbfTYfKZbPIrzEabIixt4cxhe3x/xxQHY+AGnHUwPNxHCeeYTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JIhb93jI; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JIhb93jI"
Received: from github.com (hubbernetes-node-38f9514.ash1-iad.github.net [10.56.80.25])
	by smtp.github.com (Postfix) with ESMTPA id 0D6961403BF
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775679828;
	bh=c0NMDLho9MPuNpIgw6PGUkdPqOfZ523JPcQX+CuKRsk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JIhb93jIB6uB1VmWIg9jOoOoMNNsm7d3tpk0hhaNUFfiHdaNZLrTKytNEXZYcYmxu
	 j5UYAWByCwN3exOHtS3vLQmdSPPqW3oyiPAglQrdGKgvUpOWDFJCB5gzO5v3vNJRDt
	 y+yRFemFcLo+RiQW+8es6vR13KwKoAqoQAwsXFEs=
Date: Wed, 08 Apr 2026 13:23:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078903/000000-d51fcb@github.com>
Subject: [bluez/bluez] 893e03: shared/gatt-server: Add
 bt_gatt_server_set_permiss...
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

  Branch: refs/heads/1078903
  Home:   https://github.com/bluez/bluez
  Commit: 893e0305e00847439e95840826ab8ec05724b4ac
      https://github.com/bluez/bluez/commit/893e0305e00847439e95840826ab8ec05724b4ac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/shared/gatt-server.c
    M src/shared/gatt-server.h

  Log Message:
  -----------
  shared/gatt-server: Add bt_gatt_server_set_permissions

This adds bt_gatt_server_set_permissions which can be used to
enabled/disable permission checking before operations which can be
useful on testing only environment where encryption/pairing is not
desirable/needed.


  Commit: d51fcbc3507a605ea44e69ccf4bf19352076220d
      https://github.com/bluez/bluez/commit/d51fcbc3507a605ea44e69ccf4bf19352076220d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/btd.h
    M src/device.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add GATT.Security option

This adds GATT.Security option which by default is set to auto to
detect if encryption/authentication is required on demand, but if
Testing is set enables the user to enter a desirable security level.

In case the security level is low it then proceeds to disable checking
GATT attribute permissions for server operations.


Compare: https://github.com/bluez/bluez/compare/893e0305e008%5E...d51fcbc3507a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
