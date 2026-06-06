Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C512CDA5
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767965; cv=none; b=czMclqTlhnfIM7a3YpWQr12TUPxE1VAYpxOuecwtO+jqlfhCyXsHTsO/NkN8MJ6fzoX4WhtlZCSweHPOaTE9dTLng302GRDuWInXGG9fKxSbcNllnioV86BaWL9SiVxrm7L4wf2nVDzYk/xvX8wq6KAaEfba9nT/UiCr8XuloRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767965; c=relaxed/simple;
	bh=OEG3Evs7AADBXBeDmKrJh4sDw0vJtX5y7NSZ5fJ9qEs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EhiCYlLryFT41z3Fe+HkWhklk7uifswdlJNNL1Pa7yqYcpvVw1TFMVj/Ytk03wYuk0VxhemnNGuWsI/YpPjf6eGH3iJvuP4G1LtvrynLKBHCAekXk3o44Tajaeo29hN4kQ80ugdHIFYJpgGT97whHvzgxxR65hCak1rfcAo0bak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N9hAgPI6; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N9hAgPI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780767963;
	bh=WrZMfe+kxdi/Flt1spvwfJtY/PHUCv27mWQU8MrITgM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N9hAgPI6eiMmv+x++esDeCKmKd0sGDsnh0p3oUR1wLvL15RL+S8DKY06Bruc0YJE1
	 CB3CefkxhNSX3idlUrugkFxf4ZvFGDmTRFGZzQysolh1zPaNDBzdYqbabFiN20AUVd
	 p/g43Zt3MC726CIgRmsjPzO5TzV4PLJDpZOg1cqE=
Received: from github.com (hubbernetes-node-96bbfab.ash1-iad.github.net [10.56.178.23])
	by smtp.github.com (Postfix) with ESMTPA id BD68D521008
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 10:46:03 -0700 (PDT)
Date: Sat, 06 Jun 2026 10:46:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091167/2fb1b7-000000@github.com>
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

  Branch: refs/heads/1091167
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
