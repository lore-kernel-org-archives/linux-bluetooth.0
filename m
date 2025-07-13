Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1591FDA61
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752429592; cv=none; b=pSLx5myjmRWDvweFE2LkK99WqfFbWDDFMJSVxZkiuVKUFWzFYpuUTogWow/61c5OxF752lq2XxwK5AuXme6sJ9exqeLhU4BKZSnjhsAYJLsZic9i22tSI12JWuiJy5q2S8zmSTS3VHWyp25yJXZ0uUs58F8hzLQ4SdRGjPXWNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752429592; c=relaxed/simple;
	bh=XhRXl8uRPOEcrx0xnA8E0m6sCRP2Kvw2WDzkfPTIijA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y1049AcTFUKTJGzBcDEOWly5E+cFAgpn6XmuXp1x0Ay8AI+p19aoWR/EHxtkXqZK1CBkx5jJcfQOc1AQysNLH1v3+wP7vyQrPOfLzhzI/EPMwlx4WB3SffDG1naRIYruxas6XAnrn1610xcuB3Lk+sN/FNkuQjTXvN5N+I1P09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JtTbkTOF; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JtTbkTOF"
Received: from github.com (hubbernetes-node-52ed6d8.ash1-iad.github.net [10.56.182.42])
	by smtp.github.com (Postfix) with ESMTPA id D2D779203ED
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752429589;
	bh=Z0tGLnBa7P6Mh+ZlxImrfcaBS497JvKy3xZN4sOLHqk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JtTbkTOF1/zydWwb45d3ahDK+iY81rv2SPIktUBeK552C83Vp+RTURm6/FaiEIcHv
	 5OeyRi+8fu+4f6qmpJKc/NVvXoEGHxGVHtER5IUHi+Pjz/qW5HvlZozuvlq8OKVTtq
	 UwyB4jMJF9FTNfGYat6wObJEEW0Wewe2PdIZc+EQ=
Date: Sun, 13 Jul 2025 10:59:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971929/455bc7-000000@github.com>
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

  Branch: refs/heads/971929
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
