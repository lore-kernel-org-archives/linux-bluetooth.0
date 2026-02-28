Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAF430B85
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772323121; cv=none; b=vADa/QhTC8xtpDW+bDJKhh8yYkmlSEBLEzI9oeb4rzcVueDl8nWzj7kG5HqMsCiejUXkah5B76Rl8BPTkNBNl6SGaiSVQALPPyxbxABxVgoRASItUfxr9OzEQdkI5WgNKQVAX7r/apB6pIbm/r6fBegA3R6cDPI5LkpqhFuTqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772323121; c=relaxed/simple;
	bh=uDnbn+9w+oXxLqgaBcsb1gydanj0LvzOfuTJOQFufgQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s9dcbHh/nQR+W/oOOtSyT+J15haYiNXguqb3eXbM1sOQkXwHDkBvyh60RbsxHw0VhCdiLyVvZCeuIjrOZJ5qMBkrUBY9Oc0QuSTYez7ihtgwUTOhfJl/LOkxWrViMiBXfeRiRImL4k2gzbWH2hfsI9ip58pzsaaHaesbqW2vcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lOtn/+gn; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lOtn/+gn"
Received: from github.com (hubbernetes-node-bb63c76.ac4-iad.github.net [10.52.220.24])
	by smtp.github.com (Postfix) with ESMTPA id 03E7820521
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 15:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772323120;
	bh=O8lWI6+JHuOnW0n64I8jCmZxF3Etqv+OKVQPZVLq9HM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lOtn/+gnpacA+1gIgw8ZDSs+rGthg242eQ5cEh64CHc5xB5euVYLbahQqD48l8jHW
	 RFS+tBwZbqGdVFWeDsYORDfvKCrieL7dn19hQn+ZT+r3BmGmPhSHP7ACa/QsmKUHLC
	 QRRFr/RwPqn8NoXLSKPJ52nOpAqBhc56kWRKxUlU=
Date: Sat, 28 Feb 2026 15:58:40 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1048745/b5d9f1-000000@github.com>
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

  Branch: refs/heads/1048745
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
