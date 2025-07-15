Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0220371E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591235; cv=none; b=MLp+Mg8mjKzTtJIdMz6FaPnXXy75J+iaOjlgJBfX1SWraKaq9BwLPaz7PZlMU0EG/EgoKgAkH4jy54VHyY7JEoZwz9YQuekYonX7tnOuSzQTvKhvw7in490cjHlivFq5RNUVR4R+2RqDEMiLpKY/5VgO3lO8BNz/fdk/7Ah4wR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591235; c=relaxed/simple;
	bh=6YDHRG1TTS5qL8tmrIolAlg/AkVLUiFTqVH3KI07zuw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bpw9jsybrF++TXCXAhOcQD8ZPrE6dqExJ/zexGYoOh/frMCGLSUwqqVnMLOyMN/+rE9KJJmfzHydr251rbOy4QA97PdF/F9ek25yxMPz8YiypRvtwqx+CW3sovGpINSDmsLs71bdbzjaBUFal90wt2OpVduVZym/7pafbJlC5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QiUsHWR7; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QiUsHWR7"
Received: from github.com (hubbernetes-node-10aa7ba.ash1-iad.github.net [10.56.209.121])
	by smtp.github.com (Postfix) with ESMTPA id EBABF1403FC
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752591233;
	bh=b30cN4CydTAPu1VCt9dgxALJ60N9vt8mfD1x2gtskh4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QiUsHWR7+HmasVOEDmS4QxvWMBE4Tp7BVHM7y6QQznm6mIdNUce5Ha32xm7mfA6G2
	 OHUc2mpSgL7P+8cGtGQuEUkBGyqoGwTa8jy9Oz8FURiZPC+TKJO6YPI1XE46lxMhy5
	 W6OOp/p1s40nZ4rLSPqG8U2eUkEGyN5HtsaX5imY=
Date: Tue, 15 Jul 2025 07:53:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981701/ccf6ee-000000@github.com>
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

  Branch: refs/heads/981701
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
