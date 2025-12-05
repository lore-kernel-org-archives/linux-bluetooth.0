Received: from o1.sgmail.github.com (o1.sgmail.github.com [192.254.114.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC678272801
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.114.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978994; cv=none; b=ZeeqQF6DUuXgfblX0T2BkAFDXH+vsrlgg8dwKPAgG3pcJQFr1T1UbbNGgUg1eI6b4kG7oGtDPVzBZp4WVZjVIbs6NZWFmkFx1bCZf0lzt6m6XGSZG7TehbNDK6O48IwR7osahXAij8hLNoCYXCLxBieLbFvT0wLZtZfsIvAqeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978994; c=relaxed/simple;
	bh=7L5nJOiltfykH6hywsB5OPU9qGGKXWCLfEs59onzuP8=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=ucUda8G2nXsn0ZOOUPjFVrClewx5XWEV5mDUQ2XgeE3UdKS29M1epADsE9lsncaFgm6Xc/o2yl92nF4QkmrBk0oclf8mIucN7Q8PqZ4Q8wUI0wr+NJd5uPuqdur1XC/XL8mxpcXkCsOIfb7OrBbVkfkmrKQ8VWB1aDH4ApMldoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X/a4BZoq; arc=none smtp.client-ip=192.254.114.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X/a4BZoq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=D847zhd6bnOwmTIqVTXrTxbgLBcF5AqHkDEi4SZS8Mk=;
	b=X/a4BZoq1KrL/X2Jvpbyw8n2BowIX8U4JNiORL+yx2iMFqDCJMEuUzjESWgLQkc9fus3
	ffzmVfUmVpRl+v9Z4Wtz/F+MWIDAWrp1d4vy4j3W1npJYY0d73XUaFm+S7wUGWlgkjIAcx
	7KOc13YukBDY+Wa3JJPo0OTHhyhNGKbMo=
Received: by recvd-cc48c778b-6xv8d with SMTP id recvd-cc48c778b-6xv8d-1-6933712F-57
	2025-12-05 23:56:31.673737034 +0000 UTC m=+1566470.373845179
Received: from out-28.smtp.github.com (unknown)
	by geopod-ismtpd-3 (SG)
	with ESMTP id PBg4DU0hQbmCy7aZD48PfQ
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 05 Dec 2025 23:56:31.663 +0000 (UTC)
Received: from github.com (hubbernetes-node-6b043df.ash1-iad.github.net [10.56.148.46])
	by smtp.github.com (Postfix) with ESMTPA id DA3A09203E8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 15:56:24 -0800 (PST)
Date: Fri, 05 Dec 2025 23:56:31 +0000 (UTC)
From: Andrey Smirnov <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1031011/000000-b4e372@github.com>
Subject: [bluez/bluez] b4e372: device: Limit the number of retries on auth
 failures
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EN5Nb3YqJhrHDjtBOJuKP0GM8bR7a8MLVBGhb2vso31eE3YyGLTPM6dwtc?=
 =?us-ascii?Q?P01dtBx7KCE8IviCXfuzyZ8IkN7p5OfO9TOvHJL?=
 =?us-ascii?Q?+AfVeAgnvj7hVEIzRWSx2bQPRmTLdlwdjvDTfjW?=
 =?us-ascii?Q?zOEaSF6xZuBso8AiyHnt0Zj2B6C77Y87WFgegC+?=
 =?us-ascii?Q?mQGq1cheJCiStYg2x+XHAMG945HAheI1bGnXTFJ?=
 =?us-ascii?Q?Qt7gSa+bP77XTC9k1gXigjKMUT=2Fo5++QKqMyXc=2F?=
 =?us-ascii?Q?vLw5?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1031011
  Home:   https://github.com/bluez/bluez
  Commit: b4e3727aa6f53a993cbd0191372ac89e0307d49e
      https://github.com/bluez/bluez/commit/b4e3727aa6f53a993cbd0191372ac89e0307d49e
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Limit the number of retries on auth failures

Currently BlueZ has no retry limit on reconnection attempts in case of
authentication failures. This leads to a very unpleasant user
experince with, for example, XBox controller. The scenario is as
follows:

1. Host A is running BlueZ and XBox controller is paired and connected
   to it.
2. Host A shuts down (for example)
3. XBox controller is put into pairing mode and is paired to a Host B
4. Host B is powered down
5. Host A is powered on
6. XBox controller is powered on
7. Host A/BlueZ will start spamming XBox controller with connection
   attempts in an endless loop

What happens under the hood is:

1. BlueZ starts up, sees that there's LTK saved for XBox controller,
   so it adds it to kernels autoconnect list
2. Once XBox controller is on and advertising, kernel connects to it
3. BlueZ tries to elevate the security level, but is rejected by the
   controller with "Key or PIN missing" because the controller is already
   paired to another host.
4. Controller disconnects, controller goes back to advertising, goto 2

To avoid this, let's add a simple auth failure counter and disable
autoconnect for the device once we go past the failure
threshold. Let's also implement an expoenential backoff in our retry
logic to avoid blasting our retires in a single burst.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
