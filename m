Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0901DDC3F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368586; cv=none; b=fd9llXTuye3qWlUXJV29MsRq8BipXdMtrdWFlDZ0nK7jCaXULzrEArdjwaZvhzv5lDZr/Yf7j/9RlpCNDxp0BrdCgejRlNkMRq51FVprFaw7ZNCkkBY6dCOkQRT8SWveVdwsLbfBAr6bnHQYsw0f6fOI9RPHX8SowH0J8D3cj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368586; c=relaxed/simple;
	bh=8Ta0yVNXaHD81gqeNrEIElgIVXLWrlcJKVF0MMuI/I4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KkcoSNCP3CVi+25dfYESae+uto6brArpzON7wkBjZ6eX/fdMFK2WgJ1T25Es2MX8WlO1SYN5SUinlmpTFDyrc6kdYgq8IAO3vncVKxDzL6SBSLE3pz8t+1x7nOG7abhY3r/zEN68jwp9sJeyOKc5WIFgoL4nM4mhO/2yfwwCVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F0yc2otP; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F0yc2otP"
Received: from github.com (hubbernetes-node-e455c9c.ac4-iad.github.net [10.52.130.34])
	by smtp.github.com (Postfix) with ESMTPA id 1B784209DF
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757368582;
	bh=0LsSDsQU7MfXwB4hWvu2EuW2ENfno/Jzc4oFGVhULuE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F0yc2otPNvnUTHMgNtufKkoF8wiE9Lvls2oWwfCLAHy2qMMQ7mZCdNsDbJFEgaIiT
	 ur64JIN/OBz7KYHoEFdYv++IbtWFc1iiCJC2go2BO2A+2SvAgF/fY9GsD2PfC6detL
	 f5QFOW6nXoXWwTVpC0qv9q6yIcwCNTMWLA5U9qLE=
Date: Mon, 08 Sep 2025 14:56:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/998967/0b5f0c-000000@github.com>
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

  Branch: refs/heads/998967
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
