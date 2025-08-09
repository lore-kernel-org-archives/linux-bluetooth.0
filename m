Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B22BEC2A
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754758816; cv=none; b=hxuXmcva9P8JWdOdDS4J6qydo68uObaviFQTOe/t6k07nDuT1PMtoCjpXw7OryePP7XqqBKSRKvPWlAulWI5plwpLoAgPwM+bGEvTn/96sFly6qCkiyrjS/V8/MO/88VJy8/tHm9vy5wgu3VaJEO2rHRNvGPnJ8mku+KW0g8+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754758816; c=relaxed/simple;
	bh=gIDvOlyfHoHYJH2whL6PVl9q4Vfa/Ya3IpXIPuuthx4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mbB9qmsgYBizKZ/Wh31CvYiCxJli2meCofcM41znOIBU/W6I9/+bAy3yJqx0Ei2GE2QYnjqgpjPgGwB/DHHrNjBPosPI6c9MP1cOeft5lqv9i7ElI0Vq0S0ljn9cwfiGX3Ixze93dkGIa39n2nICgip1C3qNd/2sOS77aeKfSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EMs9871M; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EMs9871M"
Received: from github.com (unknown [10.59.98.28])
	by smtp.github.com (Postfix) with ESMTPA id 1BAE96006A6
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754758814;
	bh=yuWGq/QwKkFFopgLstMASp69Ul3pkLwTDugrRRIrwW8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EMs9871MlDOJ8/CRrMR87EYoxWHktPeReZX9nEbDd9qoXwOKuGSFV7HdtD+ZpyL5t
	 kVZBcw5soK4ga5946Q0bgzftJu32pClZueRDWISRDwjNN5uitArmzs+VXrZKs7kLGM
	 5nAtrMnQypabuct5P+xKS+WsppB/8tx0K2xor5Ls=
Date: Sat, 09 Aug 2025 10:00:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981119/85e1c4-000000@github.com>
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

  Branch: refs/heads/981119
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
