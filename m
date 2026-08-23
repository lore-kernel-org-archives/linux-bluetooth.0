Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB327A92D
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515177; cv=none; b=Bj4NxAMlamheCnnMBNVRVwbaZW84xRsO2aRHuHTN+LzHS4yB/Spb/cG6OMHJ8Cl+xs8a82nC1DvcXaNHZFa6rTTkMJftM+iQAAj/oFHRR0/8HwTNhbJPCNZe7pJazXckXy689aQKi/Lmb1R0D34m/D6xUj0TyD1uquU/Y4ts3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515177; c=relaxed/simple;
	bh=lrvm2EsOIe4qpcDw8ji6wVY9FNqZBaKzbhlWAwOn8pA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DftqxnPWSFZVfqvWE4NOQoxUMEiIyq4AGi8M3U2yLXpdoUWiA3Z10UOu1jVsh17l7SzoZQZgOYun4yF5N+wzC8+K1pTK319kDPqY73xqoWz2824mRSAcv3ZvDcCFU7Y7z7aq6guCgxEMJ0CHbuFp5Qf3yTkqFyXYreRskxvmk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EVT8FIE6; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EVT8FIE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787515175;
	bh=AN+EW5eOM860MeEQNnZACADUjTOTX4FCLiy3tUZ6mC8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EVT8FIE64suKFWk6SHfQj7PulIx6yKDrEWlgMoVktCNTUbyjgQ+M4tec9ECSEkdko
	 C2OSAc+DVtNKpLtBYrFd6szTgHU2pg8J4j/Xx8hIAv2YzBqDF6n29fnCIJpb1gXzj5
	 2V4JTNAc3K11tWzdHfLZANmJ38U5LSUVlC1QB6QA=
Received: from github.com (hubbernetes-node-bc1dca9.ash1-iad.github.net [10.56.203.117])
	by smtp.github.com (Postfix) with ESMTPA id 8E2233603C3
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 12:59:35 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:59:35 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134176/802bba-000000@github.com>
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

  Branch: refs/heads/1134176
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
