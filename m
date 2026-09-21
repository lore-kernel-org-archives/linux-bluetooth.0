Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09051A757
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030595; cv=none; b=GStEf9S6FrCjTsYykYWwwPHhSRCcVIgAbvTw/WAC7Me7Qe3YP6Q7Ncsn2v04ous4bm/Auhpb+gRNQGU0AAYwIFjH2LnMfBrEndSs67njyLXeuC63jQ+PU3uMtobRIA98uxYSE8bejOrz9k+hpSy0uMgVV8+9pr1fMlSWILdODgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030595; c=relaxed/simple;
	bh=gDVJUfSB+Muz2VWaJ/mdX2G+Pg2foo/p0ozODZXXmYs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HCfznqjzFifppJK3KPv4ofxBWeuswt+y5so9fZwvmsRkJEEkj+p7ylz74STnwABh/sq9kHhzfggiMTBX3x6SZWxIH+EWmVr2AqrSrij/7+JkGyJLfS8g7ay8GohTkOUn2w4mhhVDsPIZHhUqV/E20hi5IaLYF6T8cMFg6zBizGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tz0RZwO+; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tz0RZwO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790030593;
	bh=TVIi9A4mAJgqrnRhlCmQ4hCUqqPyMLMV1oGnKFXaGZ8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tz0RZwO+whp2y99agtCK9MhmgwM1ZIY8OLQwUnb5O32G5m2uVh3yaQ+Vt+E/EIR3K
	 TlowJPDDkhh9+JCnyl7dxMaxkIK8H2lO4YZSY0g0ha4QEIELLlzdh9AYHVdtVmYGK1
	 +J94DD2/dg2vy7rcur6BLNCpLUqcvN95Tg4BpyCg=
Received: from github.com (hubbernetes-node-8d30bac.va3-iad.github.net [10.48.66.105])
	by smtp.github.com (Postfix) with ESMTPA id 183BA340E2B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:43:13 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:43:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169363/0e2503-000000@github.com>
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

  Branch: refs/heads/1169363
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
