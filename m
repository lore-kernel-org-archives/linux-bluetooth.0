Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B81EEE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246551; cv=none; b=dHPv0Z7SU28y6kg51bC9eL/sHsvs0GHOWwWIgZm9atWHGSsGh3w9dMhMCV2fNH2u6DtvyIikQ57B5zoqGMYKO8xa7YLZW62KGt3Spzut2M9reSoHTf3gYhxHd5WlBbdUtYWT3+BYGBZbb10VQ0H6Y8UlTR3by/sdJas2C1uyyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246551; c=relaxed/simple;
	bh=mYnM44KSiip10S1PudGB6Io7ASK/TrAdW06CzbxAgE0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HC1r/8mCLgC9IJ8BGlhNaLMmiv0SBHUiMGsO2NSFmOm3A7BLtzr5/C1VQ1gX4rBDQBOiAj9Vj8V77RDnYVP8NVS8jAZp5Oe0JAp0XhyNyzp0Fc4RJzUvBo0tb2iEjM0Ja5f+CHPwKxOimxiy6rRgV+qwVBY8fdpypXJ8fj8Hd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XD3exQ9n; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XD3exQ9n"
Received: from github.com (hubbernetes-node-f09999e.ash1-iad.github.net [10.56.172.17])
	by smtp.github.com (Postfix) with ESMTPA id EC2B4920CF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747246549;
	bh=ruwJ8zkCdRCT9aD2iK3QEZ8dvzRv2KosARcMck6wKOo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XD3exQ9nwf/0IiZ4u2rlxy/kN8bftXiGxJfaLU7E/+HXKP12ftvOKl3OEKlRDomQK
	 5e3TknuiBQuhqIpBTx2u2Xy8Dbkr82hN8BdauWix69f5QD5dgI3fy1tPmdS8iSHKqW
	 o+hz9GmHxCJy+yX4ohgQvbiPn4c1KwO04QHF7fr4=
Date: Wed, 14 May 2025 11:15:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962345/919b57-000000@github.com>
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

  Branch: refs/heads/962345
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
