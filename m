Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F84FB9D5
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631127; cv=none; b=sNLP0WLMScw+V0ocdvfw+PGGYtgtQyrsTQheUUt+hKNBJcc9K1uQ2onvbnIw9j9n+7zl9kHzA+jtHm89bTa89IIOiHKUqL44RO9DrUxU9JKg1blpmD1YECGZ/tpo2sUsyw+p5MrY2P1DFXnDMyu2U8I6EwlkW4a4aFiVkPfoyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631127; c=relaxed/simple;
	bh=wahRrdXiONxLzkTsdgUEYhADQo0e3INbl7JfET+BUZ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gkwXzFaV6BGYg6emqjCKtQVDU0hlvmYTY2L7YQxCeTQPeF9/ljUI7aJrFUIBc2F864FZMCj6vVsFddy0DAJvPB9MqWDcUbzJbUZ2GW5ca7237Ch+vw45zUCFqlBV8ipI+rCPAMTbNNNqrQzfRI0zadxfo8TSt02WpwFL9bR6fFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lj6dneYy; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lj6dneYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631122;
	bh=Ip0tILIHkI+1CuscbuewiTMGhvmxvJvab2ZrHNXH2ho=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lj6dneYyn6J6lsc/91zZ/M/2c+MFaRpSTyHOtpBEbOoIe8548o27sf8U+1aIx/iqf
	 UtoEOyQxBG95IztgBdn+LG4QrYpr2aORzDwT7YML9GrahY6xIt9n/7aCiskdBbzP2g
	 /iisXshvsrJ4uFR+YbHZIpUAgvhAA6AWBPT/QUEE=
Received: from github.com (hubbernetes-node-fefc343.va3-iad.github.net [10.48.68.94])
	by smtp.github.com (Postfix) with ESMTPA id 2667334114D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:32:02 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:32:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173745/9d4632-000000@github.com>
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

  Branch: refs/heads/1173745
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
