Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E071940B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876988; cv=none; b=YoepJxaRy88+K7oP9Np6i6tWgGk8hc/8Oue5iknA6oGGJBIBSxFlhQf9dTW+n4hoEmSwpPF3iCFgA6HJG3Ir+Zyk3acxEdUs8fyfSyv7eMf7K73Ku+s1Q7F6fBt3CiAZZPLd5C0bkkDZ3Dmf2JDHLavUo6IQoPOOsVnGXTmETLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876988; c=relaxed/simple;
	bh=sBvS130AWnBH75HrxH0Ml3i1HmAIrbTROsHc5ot1FoQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Eb8i1NB0otzToHpY4c9aKV5AHeTQYpOHpjztV613qiUctbGlDZBiPJi39uUS+f3T38oFpoRhkvj4YaBzNSfTD1dPjhr0f25UfCsuEBoGW/gRUQZ+KiJBjL5kgDey8AQVlES9MSt0cPb1oMOI3cNal+A1gZioya1rhnyPps+HGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IC5ivnUh; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IC5ivnUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787876986;
	bh=HCMXrx8flqkuzHYPkgI4iaA7eBZDE+K0L96IjfAtAUo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IC5ivnUhfQlCxRqNaNNzHxXXzBLuYlCt+UwyygMgprLONwdsCWNTY6gZO8/L3XfEV
	 BcolJLKw4F2jHu/TA7WmWtjfLGFApWvirXfmCcXMIT3lqeAA0LHGdGmzU65MP6y4wK
	 FBihFW/aUD7+p/Qfes5PBgQZ4UGUgXFWOBByMkxw=
Received: from github.com (hubbernetes-node-8a002ed.ash1-iad.github.net [10.56.225.19])
	by smtp.github.com (Postfix) with ESMTPA id 4313D600B90
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:29:46 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:29:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152690/ce408c-000000@github.com>
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

  Branch: refs/heads/1152690
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
