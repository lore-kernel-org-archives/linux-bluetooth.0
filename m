Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A5B3E3DB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273667; cv=none; b=jw0LeOWoTa2a7ypkFyUhDnoutt3J1T4+pVJ3UZD3xPf9cGGPMkhS91oOII72BmOaofnvIOsAliKwqKbFq6smcuwRmB8hKHof4iGVsR/lL0qxTW0nhtvuLSN+I6reWm3C/HdkCy7Db0L9NRMoeyzVEfjRKBK4tCQ+iCAzVbB5umY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273667; c=relaxed/simple;
	bh=pq5qPE+qU/30WTwc+b+awUUaAQvLcUwliGlb1Mi5Aw4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ffRNduKU7JoZt35EUOi2cmnpHOnzJNljLv7cMBwGj+gqVUQDiLAlKM0Bo0G+ehYgwd8ozbznZuPkOPTeLpuHE7yV2MFswwmUzpZBRMP2zmamFT1+EJBrQOFq4dUFh2B/ROm5INIQ30ZbrAjMOPIumwgP7uliMOcT0zmRG601jhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qno30DEC; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qno30DEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776273665;
	bh=DGw3bF6vvZpS3t1Wn+D4Hz1zlkcEbxdqM6zrnvpQMog=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qno30DECwbdtg+VYxV659PhCwgCmBYBj3y25D9c/cyi338oIgSVjb642Q+pvTLXEQ
	 uOagG6OEb5Df7oqeQeSKJtzY0/UW0UoycE94C/lFAzf7EXZL5+GviTAAyCTJuMpB9z
	 X040thJKnvB1CkR361B6nuxeZidm5gLBZQoI21W0=
Received: from github.com (hubbernetes-node-1eaabaf.va3-iad.github.net [10.48.222.42])
	by smtp.github.com (Postfix) with ESMTPA id 3AADA5010F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 10:21:05 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:21:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081547/0423d8-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1081547
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
