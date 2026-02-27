Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62362413235
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203887; cv=none; b=VoEZsSzkbpnvBJToblrGSIKQy5H+rgi1GZ33iDdENBPmAjeCzVUReqKoSOV2jwRr6b3/RZDxCzAimPfVFrbqZ6+o8rYqQ5jOxx4C1FO1iXU5eoasBtbyR2xiuiU0XJH9RvyPhkEsFBVGSsl/1adYkGH/YLl5npX1tZSazmLICyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203887; c=relaxed/simple;
	bh=ANo/OqYSpiITPL2rUQrSRp9YJhKYleAhYhzMd+BmV7k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LZXuDuwZcxkpUbQf2nzDDcW+PGksFSJc5blarLmGbWyVFory7lh+jG7Gv+RzIoMk//dRDPU0Y+huvpHcE55PkXnKMzHoYrBoiCGTIBTGFH+aVmxCs2mULZ4PcqbYSrWdIQFXxOdhQBUjF3F6PJ8LL4fHTEfN4CZ846/EjnLKylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M8cGUl2+; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M8cGUl2+"
Received: from github.com (hubbernetes-node-f8534ae.va3-iad.github.net [10.51.97.32])
	by smtp.github.com (Postfix) with ESMTPA id 65CF1E11A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772203884;
	bh=NoO9joiUIOfZQEixj8pmYPIryrF0zQkD3VkihPG71mc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M8cGUl2+oW24lBKKdsAsWAPmGywXc44rnuwFM6r4c4AMYkc02/oM2SBBFwglKqnQu
	 wsamgd50WQcQZnGh+xKmX2rRNfEtLsfsHqT5eFcjPz6GSSMJTSGlaff/+2mTGNrmog
	 oi6/lIdKgyf0cFyOz0LtlGRYamZKQXAvAM9yfF50=
Date: Fri, 27 Feb 2026 06:51:24 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059044/000000-3f921e@github.com>
Subject: [bluez/bluez] 1e50d9: shared/mgmt: Add mgmt_parse_io_capability
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

  Branch: refs/heads/1059044
  Home:   https://github.com/bluez/bluez
  Commit: 1e50d9dc9e867dc17a2bea2c2884acc5d136aac8
      https://github.com/bluez/bluez/commit/1e50d9dc9e867dc17a2bea2c2884acc5d136aac8
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  shared/mgmt: Add mgmt_parse_io_capability

This can be shared between bluetoothd (adapter/agent/device) and
bluetootctl (mgmt).


  Commit: e1f12e5ca5a5da3f8fb80317e8a8bd3a0ead2344
      https://github.com/bluez/bluez/commit/e1f12e5ca5a5da3f8fb80317e8a8bd3a0ead2344
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/agent.c
    M src/agent.h
    M src/device.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  adapter/agent/device: migrate to shared enum/parser for IO capabilities


  Commit: 5d2975229ff43ee3778a640c04766aa639889491
      https://github.com/bluez/bluez/commit/5d2975229ff43ee3778a640c04766aa639889491
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M client/mgmt.c
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  client/mgmt: align implementation cmd_io_cap with its documentation

Documentation of io-cap in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().


  Commit: 3f921ebb899b2df13851fcb03a9e047994b7f9b0
      https://github.com/bluez/bluez/commit/3f921ebb899b2df13851fcb03a9e047994b7f9b0
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: align implementation cmd_pair with its documentation

Documentation of 'pair' in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().


Compare: https://github.com/bluez/bluez/compare/1e50d9dc9e86%5E...3f921ebb899b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
