Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF002DC33D
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222111; cv=none; b=RFaK8qCL4ZvoZPWeE+f+Y6LJUqqV5JvYzzinRulxHhpprAwQnHi8matUFw+EnG7VPR3x21vXVepf/Cq+Dj04PYcw4uyRv042dxvwdiSTWwltaRoVZkHr1oIP3TT8VjmZDJJn+53L6vdM+Ed43SfqaJHP/8q30sJx7QtBFdChpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222111; c=relaxed/simple;
	bh=iCGhYpXhici4O7l2iuZiyZQzCiEld9lE8YNtPQWF9A0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NYfBGYTxKjREzuzfsRUN4IIVdDfTP/rd784bDp6SHVLIxlsluuUU9zngALj+8JTmXTFQnv9wey+Pzf7I3jNH+Yrjebm7UhLbKVUqiyN9vdcsLsAiu7/nD4m1geVMDCG3k0KCc4UeRTSXoVjE/LlGHFP6MKLr7UsiGieQA30GGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lD5iurBE; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lD5iurBE"
Received: from github.com (hubbernetes-node-f013e6b.ac4-iad.github.net [10.52.208.63])
	by smtp.github.com (Postfix) with ESMTPA id 3013D21379
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765222109;
	bh=c6YYT4W+nzsq0q/OpUwrgsYtb2bmB9ona9sSKmqZkEI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lD5iurBEeDyMDHpG5Zw/DBA+qtDuggd01JoFWkHF3zxhsL/WTvo+0DEV6q0/04azb
	 W+b+QNsv+csxm1stfrGfgqaLPhQ+i032ySKgQ4kuxLeo3b2004VJCV05aT4H0UuHcG
	 hIZ2/iGJNcd2UPKouKglSV3Mtf0igTZ5diz3UBcY=
Date: Mon, 08 Dec 2025 11:28:29 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031462/50b5e0-000000@github.com>
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

  Branch: refs/heads/1031462
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
