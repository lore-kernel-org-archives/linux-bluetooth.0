Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4972D374B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663745; cv=none; b=pU8OnySEEdMV8WfmKcLxJx+2LZkxpcHyeRjt3W2TgeeFo8/7OPLobUwCFmUhnAU7daZQI7pOHYumnQtQiXWTTPiPFeYIEHRoLJvuE3MxcdneSxOVSNNdMXsc+PXZX7Yom5znKHPzUwtCue3fURnbSCtPSQs+obu7czeghvW1E38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663745; c=relaxed/simple;
	bh=ztNbIMrcsh4ruTKptD+2ccrVk4m3JYKdVglNGVQW8vk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ax7/REC0hAEjSIF19Ix0vbCB8zr5KqNxppmZhRuTlNUxSZ0rjqJ4C6lHIFJqHe1RvfJJ7mtqcengTB1xH7z0jbL+florbu34otQw4Gz/fAs2mDCAIzN7r6pvmFT9P+8OAzWjQarS0EshKIGbJaHmHIfARRKuNJJHgJPEGSFm/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FCtW0T5c; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FCtW0T5c"
Received: from github.com (hubbernetes-node-6d3c578.ash1-iad.github.net [10.56.15.52])
	by smtp.github.com (Postfix) with ESMTPA id 4CA7760068B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757663743;
	bh=1dyM2NxiEwxcM9Uqj5I4UMrJUUE9sd1a3+Lno9rKFbA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FCtW0T5cV5EjWmOQmR0HnB0xBcVcjK8eUJ8+E+dVdBTYIcylVo+6SEZf2Tqljji1G
	 INfLbocUvzsXgjkzyM2kzZ2M+pLtxPy1mqI5tu19a3P5AIs0JcI4lZw07K4sVUAyOr
	 L+IwWeens6Atp+jRatGcWHtZ2Q31+NwG8pCOSA6I=
Date: Fri, 12 Sep 2025 00:55:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990883/2eb941-000000@github.com>
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

  Branch: refs/heads/990883
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
