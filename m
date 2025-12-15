Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C9243387
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820046; cv=none; b=I7CnJR3j1eN/5+OafMKOG4ytJBF2ETx1lIYF6fO/QkArbbLMAJmIuOMLDFn6khsClYu8xm2V+3H5P9wyzgnECNDFq+LbCW8fndfInYXe6tnHy2q5lq6Vt6IyG8TKUMZ15rxnKWy/4AVcCQrYEo/g+Cn3NPPt+kXFHqoV6f4mqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820046; c=relaxed/simple;
	bh=GAJemcTNhFbjM/poY6TTHXAPMBGPBkZ3N704KaKchxE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TKLdLhi+PzBn1TtBSpQsJooxytMBDBW2r+S9EfAg6+grgL9vbCMKGFcjzCOFwBob7ik00NAOpy3kc5na3TmLTew4KMhWdk1O0Hr7x9NnpiGJRkyawVf4JDXv6GIOzlu/iQH0dsrUBeIUYgJNNpuf/uw7HYGLo8d1FlwRILWWuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cg6z9rka; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cg6z9rka"
Received: from github.com (hubbernetes-node-e5f60bf.ac4-iad.github.net [10.52.138.31])
	by smtp.github.com (Postfix) with ESMTPA id 7E890400E1E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765820044;
	bh=ESRKgc2VDjBM5mn1m8SR+kRFb+GmQgT+iedcVkxOq+0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cg6z9rka5GBd2akr4Ry2xRCghOkmtY12X5V4jqazCk0RzJz6pF60IF+1cuvPtPaDD
	 C0eZI85FKh6MZAtPc2HcG7U2JdMaRHekY/BwYd23LfkQXXjO6jA4erc2h8FJa+PeDw
	 /+ODfh6aT+KKwvBto/1T9V12i1KJ5QKW1NlaiUDw=
Date: Mon, 15 Dec 2025 09:34:04 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032751/a992b5-000000@github.com>
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

  Branch: refs/heads/1032751
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
