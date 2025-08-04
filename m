Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7C1EA7E9
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320431; cv=none; b=IX15zD+JVkbbo8roWwbszDBby5qsAJWihvF+LKew7sKEruM0GpiKQeAW0B2lMTOb8n7n47ys+xOg3JarXJfijIR+Fqg1fA1B3871iNQF84NZrHSZZ3GVuAwPrFO3nWe8unvsU9Q2xHgzOPW98GdUFpG1ejxEbKFTMBOsQBjY1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320431; c=relaxed/simple;
	bh=iG+oHefXy4LEMOgif/HC3K4il66xYQYzZmdVlCngS0A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DK1eq+3uAjfBfGHdAW9m1bYmN8FJcOFBICtJoWLYQNKdDtjmNqlbW+R4Ko9QYIhRv2VKAqx5wVFCzceNvolZCFl+Rz+ExHEFAJJnIPJ+lFASHT3WGSkU+JKSw8A3BAwKEOnggnvp48gBELXENA5KAJcqJL0i/JzaIml1pSy8hRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BwyY/Gze; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BwyY/Gze"
Received: from github.com (hubbernetes-node-e408d18.ac4-iad.github.net [10.52.182.33])
	by smtp.github.com (Postfix) with ESMTPA id E62D421421
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754320428;
	bh=obgAMrEzGm5186oYMU+kikXvRRGQzHsMVrRBSQHaI5w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BwyY/GzeZCXhKp7xCiMNVz3wXhI6t/zKON+dC9Fd+YQMSmUEERBd2aUlspIDOjxha
	 uJuMnffjD6FOI1vl0xebkKVdfJULv4SJbA31ZjpIdGRCwaxzGXKiKAuJYu2/Sthi3x
	 wimla2bxkW2Ljg42PdEfDWYH6NnFBRYC38k1Z8VE=
Date: Mon, 04 Aug 2025 08:13:48 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2c0c32-af816a@github.com>
Subject: [bluez/bluez] af816a: shared/asha: Do not start ASHA in case of CoC
 conn...
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
  Commit: af816afa7ed1f70377f02545ae2b297586194adb
      https://github.com/bluez/bluez/commit/af816afa7ed1f70377f02545ae2b297586194adb
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-01 (Fri, 01 Aug 2025)

  Changed paths:
    M profiles/audio/asha.c

  Log Message:
  -----------
  shared/asha: Do not start ASHA in case of CoC connection failure



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
