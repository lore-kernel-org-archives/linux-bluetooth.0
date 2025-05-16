Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0672701AE
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425467; cv=none; b=ue8pXB919zSQAYBWDBUnxhG7S5GznUW49v+W363k+lozRlyQKLTNrdPuQLPk/JzP5yGzZNpRlRW+7S6GxfqPig6+lyCFoOPsW+M32myZ6uJZ/q8Sy63UHOELlaQgmryZcywQVEB2WshvqxjY5nlvrRzHCs5ubJmoYKWaCDMFT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425467; c=relaxed/simple;
	bh=MLce68QT5I/tT0n1hKeb+PQsJa5yKFPQHnjdlQ56hLg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hWH0mM+3kdgkvrBvRBumS7kTj6RREJXpy5/2qaTrAI6pOJ/ILGEMreP/KOnD5HoX7Jfgcx/f3UNtVHMJuABh8SdTZZujdQt9P1aNpYK9YPCQQOwdfEzOchIzg8JssLYq5NRTX7VJlLL5vTZqZYB5nCRD8feXR3CaTU/d2sM96SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k7ySUS3R; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k7ySUS3R"
Received: from github.com (hubbernetes-node-06e1fe8.ash1-iad.github.net [10.56.224.26])
	by smtp.github.com (Postfix) with ESMTPA id 1F16792125F
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747425464;
	bh=USROwFSYLwm85laJk7pOEuFGuqNohaWfJq9bh9CmtnM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k7ySUS3RhFnY012lLp303v8t9hFe6jJmm2OUWM8BghIsHvR/77MW8CMrmArutMizi
	 AXt518vLX0g/fK1rFh7vJvlJLzBzv/lnLZvrgDzqdUUBgDPRoUXdeZrV7yUQGtwiPs
	 6e6wYmsIWG13NA+/zbdduhOF809+zumMuMJaPhAw=
Date: Fri, 16 May 2025 12:57:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962935/81c21f-000000@github.com>
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

  Branch: refs/heads/962935
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
