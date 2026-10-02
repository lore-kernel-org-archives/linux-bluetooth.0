Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A254A8FEB
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959476; cv=none; b=jokNWwoJNxQtNjx9vzzTXS3utNF0pGJDSpI+Kj4X/PyprcL9U4jmlV5h37AdWMGSI+6YgSppHxmtWaYDOI6HpB3dO94+RK3RvUFuOkmRFsXtGaWYlxh+EQc9Q4XnXaD5YeDJVdDCJ3kwfsJYrOJe8hcqK0OIzfoiE1k7l2LruQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959476; c=relaxed/simple;
	bh=KNyreuPp/VU0XB8ETfW8W1r81BfqTILvpEaUD25wxgk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RgonCDN/lgtHJ6QF8AmPLpVwFKulWz6K5M4yUjD0z1l9c1358+o4itr05PJqZZrO54Ptlk5VfCsqyYLuO80rGTqcl08FbpI56hnLzucHEYDAuYPXFTMJ1WV6iL5VBzh3yqNaj1G0rFJFwf4MOwZHg3ptDuvDUqBiXOzprjdYIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=K2xZT1lI; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="K2xZT1lI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790959474;
	bh=hGqcDcvUffpPglTcL/n4Hidm2m4sSsJp53fdasu9ZuM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K2xZT1lI3uZU3vws/LYs+bJJoL30NWaHmn3d0M3tZy8e1rBTy6TZLYSKgOCXE2vNr
	 gRsVOfZV9pNhit4vmVOJ6u1Gl0Tgarx7lbRT56A34hrIYpOJ/BcKY55BUTKr+o2Ubb
	 JgXpX10GhFSxd8paokjD5AbUYqXXnN4R6LQFUvT7An0qeivLx1BkdrHMf2odR5tuQS
	 JFEjSqvnq0u7S2u3YUDTjwfZ7ObLyYOTXilE+3wh+SYPgn4N8Z4PR/PvJGGd0t8IT1
	 DbDeyQsfE9SQWpVz0+0rambGIRgw3S0mk7DK1m4QG3NPsOfRkfsYUC64JJLsZeD+JX
	 BMlnttyib0xfg==
Received: from github.com (hubbernetes-node-f8d24aa.ac4-iad.github.net [10.52.175.68])
	by smtp.github.com (Postfix) with ESMTPA id 15ECE402E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 09:44:34 -0700 (PDT)
Date: Fri, 02 Oct 2026 09:44:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1178077/0ad9be-000000@github.com>
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

  Branch: refs/heads/1178077
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
