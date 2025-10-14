Received: from xtrwsrct.outbound-mail.sendgrid.net (xtrwsrct.outbound-mail.sendgrid.net [167.89.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED1217F56
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481156; cv=none; b=M3hpdfC4w4xgTVdW5R95Nn36kAGp94cGwCJWZ+o0zx15wJdyk+AdmSS0NaZOpvjt/JwVcd1fiBXKFbv0A4ZVRkATSXJ1SNDx9Qxy4I6BC3L1wDBdN6uLWJNsjQA1xKEjHNwiwgjZsHsOXl1QRmx2ky5LGp5gljeKjZSF3djAQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481156; c=relaxed/simple;
	bh=wWfS2TrLM/Mme+rkEvxFEh2uKFTO72mhuygoldSkGgs=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=fvy1EhLGms3g2WgJt9swuPg+KGiGi7osJ5keeX+b+ZvLuGd61aOAXVPaoIOQqvNkl7giVsJQsQudqUbwTEywrGeRcpEWBETuhpzxgL3OHGJ3hpCr7O0VUEaaZ5XB1yiU3kDzwZq2KFMYgGni4ic/tgeZf85O0iI9fNT13kB8VoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CRZwy8ln; arc=none smtp.client-ip=167.89.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CRZwy8ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=hrNQ8eIVlES9tbWhxJL7mP3bY28XmZp6hcCrldBSS+k=;
	b=CRZwy8lny82V24rTyOz0ZskrNRrWZn+H8PswVgfEihrB0Nt1evQt6UvB5t3KX7PMaeia
	2IMUyijvO9B1e1ZfxhVrI/vhYOwIuDkjxd6s1Pel/++FxIhC7ybsAYNVvThCpAN92+VwG1
	CUR8SYfQl4aKSgFSRaIrLxE12qOhrfWQA=
Received: by recvd-6fc848bf8d-hdpnh with SMTP id recvd-6fc848bf8d-hdpnh-1-68EECF7F-52
	2025-10-14 22:32:31.998753754 +0000 UTC m=+11425678.648070919
Received: from out-21.smtp.github.com (unknown)
	by geopod-ismtpd-8 (SG)
	with ESMTP id feYJ2m_4QWumuTehjyemIw
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 14 Oct 2025 22:32:31.958 +0000 (UTC)
Received: from github.com (hubbernetes-node-1285f69.ac4-iad.github.net [10.52.202.118])
	by smtp.github.com (Postfix) with ESMTPA id 8E2C240113D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 15:32:25 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:32:32 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1011502/9edcd7-000000@github.com>
Subject: [bluez/bluez]
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
 =?us-ascii?Q?u001=2EyVDaIUJfOTIVaBYkJvNzXFDwUvSfXABmYIMG7o2yQ0XjHiQN8HeKlKfUQ?=
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD40yG+8nsmAvN?=
 =?us-ascii?Q?8FvKeKDeBw9ugfubF0pd+ydt9F8JS9k4Lxgxo=2F5?=
 =?us-ascii?Q?eC08pHemuAxrL=2F2WdpjsaHEL0rZmT5pufzx94qy?=
 =?us-ascii?Q?2S7niHtYAdWTLRyjsYq5lVHoSQhMzN=2FyPq4KJ2W?=
 =?us-ascii?Q?VyW4uge0VoIQsDw+VShLWvFGxCOBxaN4YBl1WrD?= =?us-ascii?Q?74=2Fa?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1011502
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
