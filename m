Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090B51AFC1
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030599; cv=none; b=Ne2czT1YjqNhTwuMMhcYcIV7wrZHwF496Sz6AyuP3eQimPnMV0cM16a06R4AhVz83/80xZI9ZvFIK5I1HbbKPRSroZzzcykh8os/u4KUYdWs4D1wHIoTNicktumXhyYnkarl6fyy1pPZN7/z9weNIOHnlQIttOCFURtdeLxZYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030599; c=relaxed/simple;
	bh=8o1eSkJJKC6VrVYtiaTlkh09XDwHzAGu4Sj2Zxg8u5w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L/eTnnglE6k8XhzeSkgS1UIOSZxarJ/6EWmGMAvzx8/3RcVFgnlsoIoEZkCzhFjayYcwy7rzHvEhFTpdgx108W73jzfO91vLDegl3LgvvhaYkm72rjpamtpiN69Ay4Gbx1dB834ywGwARZxCE5Yh028Xp0njKvuMm3Vcob/Rf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DTZ8hUFT; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DTZ8hUFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790030597;
	bh=hpfBkooMG4Z2FuxlQQhyx7oUVF1Q/N6WAIx2lOW7e+Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DTZ8hUFTe+j0u2QIVwtkZ9PSW88mhgpQ4q1Lfv5Q8edAU7WqzXpk66kBANyXO90md
	 DWMcWDMrY74ZBk7HL2/KuCY1aG0qqAf1AtcRI6oKA2/FwMffHS3YtyiqEiPLH8VbKu
	 1ZPUVLT7Wy+SFAOuq12piVs3fBF9lJJV4lJRX3+o=
Received: from github.com (hubbernetes-node-9c2bfaa.ash1-iad.github.net [10.56.159.57])
	by smtp.github.com (Postfix) with ESMTPA id 07B2A600279
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:43:17 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:43:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169362/1bc658-000000@github.com>
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

  Branch: refs/heads/1169362
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
