Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960386353
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998954; cv=none; b=SPlZxZIXau6aHT4cyECNQ1vD/B5vM6aZgI0ESrWrlg/nxRGTgA5Xp7ws/gK0FQitmaaEddUd6jTDT+XN/Vql8sgNy/i1zcmWGxWobQ9asMXQ3PinK5Ey6tnkXFTbU9ge38dmv3sy1s0UGP+LhjL1sJ1GfBI5dq31cafs2LGJGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998954; c=relaxed/simple;
	bh=x8BxIEYqBJfFFFPcPn6b2mwZsMIMAKQT8sbIUudlifg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=emWF01r/E+Wi/SAuQHxpve6S+18QLXIInNHM8spgNHH+us+d1uyRMM9Uv3P9UcQK/YIbNiGpg7aMFykJHgtwmPDaV85n/xBeROqgn8V5g0ni3P4szmmnDJXtCrFj4X64JK8189IwI/angqPFBI7rq+/kdwwULj2JHly+41yqKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hBuqkPJz; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hBuqkPJz"
Received: from github.com (hubbernetes-node-786021c.va3-iad.github.net [10.48.209.44])
	by smtp.github.com (Postfix) with ESMTPA id C1FD1E0516
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767998952;
	bh=USfPs9+gi0TqESO9pCHgcHlDh+WbILzdKqn4cuZKyYs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hBuqkPJzmwKNo8iEotZThsuGgLBJ8U2g6oqGPKpU2M//7JdY5PQF03YSZDLvZ3i+z
	 mpzJQRUSPb9wCESOB60D7VagEFdHNpQjwqI5HgCv1TlS5rTsr1eCvmWGBtdYvITMDf
	 AKWwV3gO7CmuUV9y4CNnEqkqjFP4NzBjl01vY7PY=
Date: Fri, 09 Jan 2026 14:49:12 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1040361/4a4324-000000@github.com>
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

  Branch: refs/heads/1040361
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
