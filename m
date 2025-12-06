Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36A33EC
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979308; cv=none; b=BSzeGHIl8P1Imc+6D5qm+lHA+tcI3lU/3bBg94OQtCWGdvOYrRLf7JSxHf0wowygzdiMxM6Hl5HEz5fHx8CZgzcbE2rs6fLJ5lTnAskIiI1pcr0xEzADrrOOVQY7oAnlFEHv4QXo4fCGD85uYhUpRVeJDzBj2OAAqpKtz+uAV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979308; c=relaxed/simple;
	bh=UGaYXHE0R8cIeF8cVv/fErqqLfO2Rl0+9G9ViDMF2vg=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=flE79fD+DS0pFXa4B0zzO379gPqf7vsC3yfQ58fSxC2ECknRDZi8JvN2+E9g/LwEDnaxnCT+nmeGpbX6fWH1I9KJ7B7PHNnv+ixDXMTvXPXbUuQH/tEtu9VnKqSdf6B4b4LSYqjigAXnhSiMtfCb+8uVLHwCv01XHRfg4hSKk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R+Qj4hxQ; arc=none smtp.client-ip=192.254.112.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R+Qj4hxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=A9EKm/QKFeXwcjgF30j9foNcwSWm5y0w9fmIWYPGHZE=;
	b=R+Qj4hxQFr8mpQXZnn+TN0CJmW6T54QQ1pl/wjKzkxm0VNffC/Q7ZHgBklPjfWaylvta
	5pppGL/GOFW+bBpq/239OmlBl0xk/8ArxqvhRc+pObFo/0IHMTE7HkG6mhJxs+kVws07at
	+9szz/2i+jHXkwH3RDds5eexzlShZdPUM=
Received: by recvd-54fbdd4785-zcjfd with SMTP id recvd-54fbdd4785-zcjfd-1-69337269-E5
	2025-12-06 00:01:45.764069995 +0000 UTC m=+1566646.563420985
Received: from out-20.smtp.github.com (unknown)
	by geopod-ismtpd-3 (SG)
	with ESMTP id EtS7ER8VQNG_s3WJIS686g
	for <linux-bluetooth@vger.kernel.org>;
	Sat, 06 Dec 2025 00:01:45.739 +0000 (UTC)
Received: from github.com (hubbernetes-node-d7726b1.va3-iad.github.net [10.48.205.77])
	by smtp.github.com (Postfix) with ESMTPA id BD6B73C1146
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 16:01:39 -0800 (PST)
Date: Sat, 06 Dec 2025 00:01:45 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1022224/63414d-000000@github.com>
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
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD4zvhFARZ7R8X?=
 =?us-ascii?Q?rBnynDtjRIIXcwkWcwppwvA06MghSGEFR7Qt6op?=
 =?us-ascii?Q?J8IpwDrSCbY6O1kOeIbo3KX1LEeFLp6MPc2J+QX?=
 =?us-ascii?Q?2TDlsnhLlEA+A4YWIZqQ8FEphtGVpD22hZEJUCX?=
 =?us-ascii?Q?BMbA3jOGaMWenyBsEloIgFU3AY82FRMfH1IO=2FZZ?= =?us-ascii?Q?jGKX?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1022224
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
