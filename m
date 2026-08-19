Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0523D301A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165946; cv=none; b=g0skOfYi7OqNLyd7JfpPAP9InjHsxcxMAQikWpRXWD5/xROgxtabm8xoI86rRmf6d5sS8yqjbSFBaxSQvmzO6H5PWpoZwOGyx+DI9y8qYR7pvY08G7IorYMd5qtpebMnktRa9yMSlZGWsOdP0/TB5eEL1WQgPLWC/puJDElSl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165946; c=relaxed/simple;
	bh=UhFvwKiAYzyJ7BBX4KiMhmZwrcbTcqd56p5e5s9YJJ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZxWdBOmpkZuuNgkRZSZ/PEGL7hbA4NJVsvUAgrM3qGkZ9E/rat8NzsO+PauDkEPBydUwRDJAG7Apfd6dZAMtd05Nu6Ddzr+McXN9fFoPBWl/IfUs28lmpdQY9m+NMF11BVc2Mryy4EAHZfK0txmR1lxgLBFbFT1Fi0svTxo9R7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dH+ka9w8; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dH+ka9w8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787165943;
	bh=TbxJdN2fMKa7JO4yliij5icTngDyqoobhf7ldkzxx3I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dH+ka9w8sx3iQJUB7idOtGICQsXOorCKTWQ/fyABfrpVpKXd2Ysxpf0iPahR3MOfH
	 /lm78kMmk3uhTlnUQDbXi4vKm5jwR6E6l75k1AicgV97S5+b8NPt6L602W8jo87tu7
	 kg/JM7QmzNlO256zpFwbgIIwaUpq0GzGeLmU/bpw=
Received: from github.com (hubbernetes-node-3827d2d.ac4-iad.github.net [10.52.206.45])
	by smtp.github.com (Postfix) with ESMTPA id 94923781037
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 11:59:03 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:59:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1131086/75f75e-000000@github.com>
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

  Branch: refs/heads/1131086
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
