Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CED35E1B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482610; cv=none; b=QVKZFykoAWtp+JaHZUFZE8fI59dUk5Ea/nz4+4UQhkkylbg5rcXkE5KPgy3YXJYdxhS0pm/ylrMbxXL2gGX7SzEV2ZK6hFaueMBngzjKR8RdRW3OlAknUfYA5d0VUqljQNjnwjJQVU78SoCh7w5XWGMm3MVJuDc0pxyQd/7p5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482610; c=relaxed/simple;
	bh=mbeYw+kkHzfDrWMLfJkRiNGTMHsD3NmiNUeo15+D7OQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gzTxdi7bjY3TsmS/ollbgzqT5NVcFH6LREZQXyDsaHfrP1K0jLDtkofOoD5WC4uLI+TiBRoQh496rzLcEzKEZV2/D5ROFJmR0qsvN500wJxOovGzXdKuE7Ti9GmeZ44ZUNYOCDNo4GF6C62FjqHVexdXVwwyjtlIeervw+2CTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ecckbiZI; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ecckbiZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785482608;
	bh=ey+tEo4c5Q9GNd8NffyUjGFDTzfr7tIy2lDBS8/FgBM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ecckbiZIuFWvKTZQAquJwWWRuj0eL8KpacCwj4/t2zyVZRW4uHobnKaewsbrqiDde
	 cAjp94jbkdX4tKQi+vlyzBDPnZ0RfdCGldqX133N7e+vKrtWQfRWuVUIRkm7tZ5BWl
	 Gh3P23NLh3x26wt7BtXd/HZw5xfAG35QyRpOuSAE=
Received: from github.com (hubbernetes-node-0c92e65.ash1-iad.github.net [10.56.146.26])
	by smtp.github.com (Postfix) with ESMTPA id 14FFA3611D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 00:23:28 -0700 (PDT)
Date: Fri, 31 Jul 2026 00:23:28 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137931/000000-e38a41@github.com>
Subject: [bluez/bluez] e67d70: doc: Add org.bluez.CSDistance1 documentation
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

  Branch: refs/heads/1137931
  Home:   https://github.com/bluez/bluez
  Commit: e67d70f676f883e8a5669bb2e6c9b5f680460295
      https://github.com/bluez/bluez/commit/e67d70f676f883e8a5669bb2e6c9b5f680460295
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-31 (Fri, 31 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.CSDistance1.rst

  Log Message:
  -----------
  doc: Add org.bluez.CSDistance1 documentation

Document the org.bluez.CSDistance1 interface, which
exposes the DistanceMeters estimate computed by an
external ranging provider registered via
CSDistanceProviderManager.


  Commit: 0614a2e6df99e79a0fc60707d42988cce50a9ae5
      https://github.com/bluez/bluez/commit/0614a2e6df99e79a0fc60707d42988cce50a9ae5
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-31 (Fri, 31 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.CSDistanceProvider.rst

  Log Message:
  -----------
  doc: Add org.bluez.CSDistanceProvider documentation

Document the org.bluez.CSDistanceProvider interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.


  Commit: e38a41ec69f60ea903eea7eca27c111ef5c281fa
      https://github.com/bluez/bluez/commit/e38a41ec69f60ea903eea7eca27c111ef5c281fa
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-31 (Fri, 31 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.CSDistanceProviderManager.rst

  Log Message:
  -----------
  doc: Add org.bluez.CSDistanceProviderManager documentation

Document the org.bluez.CSDistanceProviderManager
interface, used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterDistanceProvider/UnregisterDistanceProvider.


Compare: https://github.com/bluez/bluez/compare/e67d70f676f8%5E...e38a41ec69f6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
