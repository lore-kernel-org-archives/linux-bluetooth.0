Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08943D6A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116271; cv=none; b=AMpi+1BppQff7PPkjg6MKSw3/OaNcSeg33SBLOn+mnismu0BKAo7uy2saBpNebceqjdvj6EHTkCfExYTQk0vJkr5rX5d8R966OPNYYR6T38WvhTwIJXkqbjVnXni53R5mQ/8Ysa571d36xvk+n8kYbMmIuDA2Q7qrVyVhkzppWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116271; c=relaxed/simple;
	bh=+E/oi/zD5eWfu1OySfJazRVc6/L1/y+fvsLWR8vAtdU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tN/BDGuHCL+zeETlL6beGNIllnpfTTgSqpvz4AYeINALLA1Wg7iIS7iioQADGdC4jxy8WIeQEvjjOJQ4CK8Fzlb20+D3VSKkJtJiSUZ16EHvR/OvkA2TP6U/VNkqes4nyBvWBFupaplQ8tJdkqhKC8fqjNekej+pxFLuM0EwtME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gOZuhF6Q; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gOZuhF6Q"
Received: from github.com (hubbernetes-node-22889b5.ac4-iad.github.net [10.52.135.25])
	by smtp.github.com (Postfix) with ESMTPA id B0282700343
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746116268;
	bh=NuzKJEw6YdfUmKISgvHB/mpG4nIp2YhblsV15F67xm4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gOZuhF6QTWw9hwuRSIxHLdG01Y9QbxcJ/3g8x9NmAfa6uXJGphmRUTrP5qh6miZ5V
	 p9jPLNLbQ/4OAljKun8twQsTH52jHMn8Jt2c/fiZvHePUmZ9YT/sKusTimY22HyS96
	 w5gKmwDicYWEMZr6Ro7dwq2gs8dr9WaCL08QjO/A=
Date: Thu, 01 May 2025 09:17:48 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f8d0dc-bbfeef@github.com>
Subject: [bluez/bluez] bbfeef: shell: Clarify "mode" variable
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: bbfeef3a04b0ad4de5802790b6bcb2e4d9fb9e5e
      https://github.com/bluez/bluez/commit/bbfeef3a04b0ad4de5802790b6bcb2e4d9fb9e5e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-05-01 (Thu, 01 May 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shell: Clarify "mode" variable

It's unclear what that variable did, and which value corresponded to
which state, so replace it with a typed enum so that conditionals are
more easily parsed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
