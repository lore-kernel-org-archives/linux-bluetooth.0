Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649103B19B6
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478553; cv=none; b=P1lV+gzQdW76qXcLfpR8LvI/yKFqXOxfK0xS1Sf4vf5kzAwG1CnkZUGVBp2LgVxVOPlNeZAQFCqAlF7EAjr3SSKa/Rl7qMmYYKeUWK5T1V1l+/I42yGcApvwsB/ZcvBQFCMArSBCsy9+sMoC7JdwdxAW9ov4Ayc4hTZbuVYhabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478553; c=relaxed/simple;
	bh=8wZNXVQmgBIDxeKPPf9qJhupcKHJHaqnPZ/DA/9XinE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Xi6fKlXACyGxau3nGuAVMmynrKfMyF1W5zMHKpuZYyo4RqLFCUrheGmaeh/4v6gusRRw3QzCPGjzI083IdQH35bwNykkTODWDlUnM6NWyVmjwqEJ0Wv9HRxU7KbPVrJuzXuEIXHori/ve0HVpf+xcBb/70opdajWcKgLDGV3Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=I7OJ/PJE; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="I7OJ/PJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791478551;
	bh=6dfAR5QJxim88MJUJNUaIg6gSeWrMlXDuG5HvRCMnBM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I7OJ/PJEQZgEoUuwS9iTtjZ9beroG7DW0ff3nHujKpEEIlJrYEC7RBnjsoZC+tanX
	 0Yo5IDePIIct2JTTmb4JJkyyXSmUKnxJSlhtgXn4LRKzwAirWmh3X0P6ORfYGo+AUm
	 zTP2SDfw1ifSn2kpA/7p0daxvVKXB1dHO/tl6RWypUrV2mmLj4a7A/f8EVL4MDug2p
	 fW4ZTnT+SMuymQm1lUvlPE/KYjnbUqWP4gtErZ6/K54sGAVcQXFgUdVU0pdSxG+Jt0
	 7vrpEWaT7916k/bBZP/6RllvDvxDnUeHVr2hgHsEmrQhWdI5kp3LALKTppbBL3mud7
	 QRGFuNpjSf0XQ==
Received: from github.com (hubbernetes-node-abedb76.va3-iad.github.net [10.48.72.85])
	by smtp.github.com (Postfix) with ESMTPA id 6C8E878135C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:55:51 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:55:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181228/5b628c-000000@github.com>
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

  Branch: refs/heads/1181228
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
