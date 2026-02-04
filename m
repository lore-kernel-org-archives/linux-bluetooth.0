Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12880347BD1
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770232993; cv=none; b=FXFLFfHnPCh4DoGFoI9J5PhlQ7yrnM+KslsLFyygP+JmH6cDEtdVjTdJEG6j/xhRYX+vlAbnIwdQ33bDLPwaxsvK8qFqMojQ+P6yXyq16sRDB94r6Gg8S7rrSF9e9zTTkPOnrgcOv0UjnR8jquMRp0F5qZMd+TbiYBk0Au4mhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770232993; c=relaxed/simple;
	bh=UczPLOS0X7GnQfzqtOlDc2oWpn46c5lux8EqbuiPWwM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZCCItPkfrdQLCFy0QcJ/aNxzfh5Vfstla3/7xHbdCQa5B83kIHgYB4HqRFKkrlcj+XA1LgxY+fFOibcxQYU2ZEoIYpPTgSjfQVxEENTTNm1PI4H9rSPSAljX7Rxd30BDjrp1VrCjUYyEil5x9Jx1ny/fUZwnC5rRvQOLiBXBQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LtzfEGOX; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LtzfEGOX"
Received: from github.com (hubbernetes-node-5f76f52.ac4-iad.github.net [10.52.131.25])
	by smtp.github.com (Postfix) with ESMTPA id 167E021528
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770232991;
	bh=aqo0bM5Va/tYGE8+BudC0crf1w/6kUXLcX7aswn1whA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LtzfEGOXbN2bjD7N8DZmcNgyWkNstwuAo0DV0K2X1QgJC0MYQ6pKzxX7uCec7BZl+
	 L3GdxfdffPuSeXRuTI7s9KPRMYfF0hjusAuoxkXU6/ohz3DtCvL2Uy9ad7gwMB1pV3
	 q8pruUIuNYxKWY2SfQmJ5LfRzrUHYawltWstBafQ=
Date: Wed, 04 Feb 2026 11:23:11 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1050866/000000-f9f1be@github.com>
Subject: [bluez/bluez] f9f1be: monitor/l2cap: Add missing result for
 BT_L2CAP_PDU...
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

  Branch: refs/heads/1050866
  Home:   https://github.com/bluez/bluez
  Commit: f9f1be6fd31f0b449be41717ef6d6880bb455be7
      https://github.com/bluez/bluez/commit/f9f1be6fd31f0b449be41717ef6d6880bb455be7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-04 (Wed, 04 Feb 2026)

  Changed paths:
    M monitor/l2cap.c

  Log Message:
  -----------
  monitor/l2cap: Add missing result for BT_L2CAP_PDU_ECRED_RECONF_RSP

Last 2 BT_L2CAP_PDU_ECRED_RECONF_RSP result opcodes were missing
accourding to Bluetooth Core 6.2 spec:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-02ef4c03-7278-7ad6-bbf2-ee2f0e921fed



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
