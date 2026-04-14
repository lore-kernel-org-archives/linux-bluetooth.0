Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35243EC2DE
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181508; cv=none; b=KpbJPah8612ms7vrxtLFTpDPITLYN8cxVvTv8inzKHmTGYfYCm0oZOwCkrL3x2otnvfWHkofSE7cuFTAwdgLJLhtIe1rIIKTq8LTom2MslBZbZrHzzlJKF+CyR+vIA7bWwED0Va3Ow5aMFPsacz3yqDFZvw/XLGWirGHhcoAl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181508; c=relaxed/simple;
	bh=WFOBnb4BHmxnBr+yPgAh4VJqbh/NRKxxzvF8ZRJ13bQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ei2jxtm6Vc+SIvfqLw9P2d44rltp14dJggKJFIOd/+7iM51PeBBJmcN3K0qruBq3qJaWcW0umK8iS4Uvj9ZlU9gMGZ5yuJM62VCVSzP8Df8jvVRBvr7Ox11iwbIqRwyRCiTCXg7Z60RNHlD8yNEtiKeu7iivZ8L35YFyouYxRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NyoEzmKP; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NyoEzmKP"
Received: from github.com (hubbernetes-node-f993f06.va3-iad.github.net [10.48.154.48])
	by smtp.github.com (Postfix) with ESMTPA id 337AFE027B
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776181506;
	bh=S/MTHoCwdVrpBr7kwSA3+ZLNuGOOtZ98YvAY5if2Ixg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NyoEzmKPwWX5ZGkRDtOgpdayRZZjSIEl2YkKAGNTla27brLKPAalUxa+lRL+/Zx/W
	 oJsY49bZi8O6NxMwv25T7x5RzUXZq6/MYrH5Xk8JuSISe/XUob9lWUl5Lh4PYEar5Q
	 c6X668sKK+bUHTZ4WheSEZgPB99iETm2H2kVQZmY=
Date: Tue, 14 Apr 2026 08:45:06 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081191/000000-1729f3@github.com>
Subject: [bluez/bluez] 9736f3: shared: rap: Introduce Channel Sounding HCI raw
 in...
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

  Branch: refs/heads/1081191
  Home:   https://github.com/bluez/bluez
  Commit: 9736f3017b53172b929ee0a710eec6b8c23212f2
      https://github.com/bluez/bluez/commit/9736f3017b53172b929ee0a710eec6b8c23212f2
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Introduce Channel Sounding HCI raw interface support

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP


  Commit: 1729f38c58dfdd3d54034aed674f885f17ef759f
      https://github.com/bluez/bluez/commit/1729f38c58dfdd3d54034aed674f885f17ef759f
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M src/bluetooth.service.in
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add Channel Sounding config parsing support

Add support for parsing Channel Sounding (CS) configuration options
from the configuration file.

Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
when running under a constrained systemd capability bounding set


Compare: https://github.com/bluez/bluez/compare/9736f3017b53%5E...1729f38c58df

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
