Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519673988EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803710; cv=none; b=MjmY3xP8dILqZRk+O6VFgxJoB64KRtC8CgwlWUtW08lVPGuobFAivxRtqy2GCDyVgjqBCXHSxPeXyrT0w49BkWdrj4Ym7AYu9Uon7ETiAMixlBrQIBr1pV3N843yNpWIqRQcQOvUSrjUMoEbcWeblrihoOF3lpRPzKZ3CR3PTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803710; c=relaxed/simple;
	bh=1vys3tlH+7e9idXx8bPz0zqDagP9NGixn6qe+zV9Woo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UoMfWWhLiO1e0bQJJvOc3QUVC7bDSa3AQmVudvJiTDRIUJuhELwJmMmmlZu05nrHxavw5asqOZO9XWyLhM0+nyrd3cnKDaTjoBMI7bPcGBBd5Mb89jrYTzkpSRrz++LgqBwnrHffjOOtKBWScqLHzJvzUAFUTXILPM99Z57n0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ALWWITnx; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ALWWITnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776803707;
	bh=mUvVvK4c3opV36KXalW/3bXJ1muLvKQ97NAZPs+ZL+M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ALWWITnx36jJb5Dzu4dbiEFq5AQHCbW2J0LImggi1GtBn6gA7XFRrKvvbRAB6mFUu
	 jFr2dlRnDNIX07WTxi/O2DgL+uJBm+7hMCZb4K7NFu/94KGSlavcTJJznxwrGV9937
	 59CnpOQ8YyDYbaerUEOrsayvynaUmBkXYQf2Wu84=
Received: from github.com (hubbernetes-node-e12b829.ac4-iad.github.net [10.52.207.58])
	by smtp.github.com (Postfix) with ESMTPA id 083EFA1174
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:35:07 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:35:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1083932/7439ad-000000@github.com>
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

  Branch: refs/heads/1083932
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
