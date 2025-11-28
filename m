Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECA26B971
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764363586; cv=none; b=SkbN+Q5+pxIqCrUaJoRPdbC6oJOUrXVfaLDopDwmxpdwMipKZFdmKAROsNEp9Z8joiW4eODeiBVlOHvv339XcZuyYXcT3R2gbVZN59NoMgPpfHHTPVXq/X3GkEOAfs8B9xyNeFI+ETrCqQmldUUqc0gzRkoYi2HeNCLYAH4nvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764363586; c=relaxed/simple;
	bh=eSmpUEWKjQ8vpjfAlQbhlB2CvNyN4xqAL4cD5hGvwVM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BETxjiovsC6mH57yzHOd00/K/tE0RgXcHOk+1kTEUxHEKXg27EZztGNg2mh8FrQ8qgD+06sh3OQMX1rx5DzEWuqxtrV+YHFT185y0dXiBLdHiyl+D9sQ6TI6L6RE+6sR+vCQZt2hs3K0CYB5ERg+cjH3j9FM6aeCVW1qH8MBkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k5Q5INXR; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k5Q5INXR"
Received: from github.com (hubbernetes-node-e455c9c.ac4-iad.github.net [10.52.130.34])
	by smtp.github.com (Postfix) with ESMTPA id 693BC208AB
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 12:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764363584;
	bh=aT3+KjdfQTY1mKuHKmkzdTj6IrlqOUdg1/NKIT87zbQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k5Q5INXROp4JbSVbq8t4zG/R99jR3UL4Esqwh8QXzifgK0D3NsUEiw9aim2trG0+U
	 taFP8NS5657+ZjPNA+nD/IbCpPjnKRBJnIzWo2Hlcjf+UjnAqWlwivV325ssMNCrsf
	 NGUVOCimQlV5qv45H/xQodInlwxL9W+8PTAdue/I=
Date: Fri, 28 Nov 2025 12:59:44 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026711/f5872e-000000@github.com>
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

  Branch: refs/heads/1026711
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
