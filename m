Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105143CFF65
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045140; cv=none; b=YVrpRFYZB07nBCk2pvAGhdykL4dFcadIMucAzNXXLMORXWwzPEjIrYh6s6EjXggYk9pgd7PQ5674n8fnqPy6obnC6cammIaM6anvGQB2voIInup+BsngkD3qf3pRzRsWwTulY+BioYeBwqDrqnicnGg+q3Jh841kXFGa5zT5lxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045140; c=relaxed/simple;
	bh=W7ohWE8dF2NF2Lnzo7cOcxPTl5rwxePTF9WntJTghoI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M4gDAceZCiVaEpOOgPx1sP37p6kkpptE+l/qQ2DGmZIpSvkqqTJvvyTBw+tLoJCXVGxaF0SoZrgGKTYIFiYCqU3av2AG4hRQf0IRCCW+GeNKypdIXyKCU/dJ4+i8leQV03T8wP+I3x2Hj+JPdPAV8rfajRUyK7QXBsnT6Fr2E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EtROuzFk; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EtROuzFk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777045138;
	bh=GW6TdNrLuoQBG8nDpGVVecz7N6ri4haiDUwgFSbRXwY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EtROuzFk0vWWyYD8HziM/dwwkfx4dJ++9T1y9FFTzJhhexaGQ8u4AtdgMy8jLQ40W
	 4llN0Rkk6wT5NWEXl7i2aCAs0q/Y2B2WUh9RQAk1bnsx8EdgehmVQ5bIalkDc4TwHZ
	 6uEcrN30rL8IxDPXFlAZPJqfVA9A6dNuR+h32SEs=
Received: from github.com (hubbernetes-node-4500896.va3-iad.github.net [10.48.144.28])
	by smtp.github.com (Postfix) with ESMTPA id 3E7A0341025
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 08:38:58 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:38:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085008/f8f5c8-000000@github.com>
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

  Branch: refs/heads/1085008
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
