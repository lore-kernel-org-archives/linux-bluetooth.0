Received: from xtrwsrct.outbound-mail.sendgrid.net (xtrwsrct.outbound-mail.sendgrid.net [167.89.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AA2D2394
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966443; cv=none; b=uegKqIm/8q/BJ7R1OrARLKpbrPtQIXIcvqRJZ5lakUc7mwsk7yzgYA+oJ07ATaOUVZTtUsLX9Yrkz3qQbSPORGJIfq1wKYCtqXkGonZTFjUbAGOsiSSRLrKF9jCuVr2Wd+3RzT82nRMB/d/DUjYMoPFR+qsjuYU2wUm0iGjWCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966443; c=relaxed/simple;
	bh=yR3Px7Hmd+OkWQ241ObBVfuaMmRDvI/9jMLBYkg5sUM=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=GON9LuQVQzExn9fAkS6AILJnXc8ACd16wBL9dsVIg/WtP36xYijoSS+burnSf8z7IoH2BoP1QHC2+kRAt4woF/uMTpVIOq5WN8TNCxEWfq/IZx6QnYgznRlGgWz6pSK9wpu2dO0H0S/Q3A+DNAGCp8BDn6awzsk0d8X/OxG1p/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l26AGM/9; arc=none smtp.client-ip=167.89.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l26AGM/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=95mgVJ+1EutaIPCTVsi60+u1jAEaBKuyDznHsN5wrtc=;
	b=l26AGM/94oQHcW2gO/09EgrwMx/9Sa4rfDz8Fys3+twR/irRmCkBMchoVtm4ZhbXtWtD
	GiIjnvx/d9tyKP8Mrlzd1SwIrkZRNntNpu3yt8zdbTYNypgzmAFMxt1dkgvxlMWuVXGJpw
	CQXrNdl/01FDPSWfwAFAsfC2nd+ok4HC4=
Received: by recvd-759dc5847c-hmskj with SMTP id recvd-759dc5847c-hmskj-1-69334028-32
	2025-12-05 20:27:20.656104268 +0000 UTC m=+8111456.286288186
Received: from out-18.smtp.github.com (unknown)
	by geopod-ismtpd-43 (SG)
	with ESMTP id NofDIy4OTpGgpG_cquCRHg
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 05 Dec 2025 20:27:20.639 +0000 (UTC)
Received: from github.com (hubbernetes-node-8b555b1.va3-iad.github.net [10.48.124.81])
	by smtp.github.com (Postfix) with ESMTPA id 28A13E0B1A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 12:27:13 -0800 (PST)
Date: Fri, 05 Dec 2025 20:27:20 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1030563/81e8d4-000000@github.com>
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
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD41IVOPMG5We2?=
 =?us-ascii?Q?VfCiL5ESn0oqWvraykmvRCNeYBhlARCVPe8=2FQtA?=
 =?us-ascii?Q?5vDJXrMm5cAkb3VqmvSRAy4dRzQLTx7JXbUKyl1?=
 =?us-ascii?Q?6EmhBrcBtf4I+OlporHw55PN7=2F0RN3jgTKF+IBM?=
 =?us-ascii?Q?rpD9Jm9jZ=2F+rWoCYhYIuF2XMxIC5xcqUw=2FORzc+?=
 =?us-ascii?Q?mfpc?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1030563
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
