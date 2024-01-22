Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650648780
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957990; cv=none; b=QNdIbENdzZgo1IHuXiyi9y52JNs/A2AAdhx0TGuXOOH86Yi/639/RTh2qZOfhkghCfPavBrUC4LvA5gpf9kL2Zh7tbYmS3x44jckFe7Badz1V2Btm7c2ofMoDJb/oPM4suRHyJN48pmkTaD41gGydKchXTG0AD3FeRjZnTi7YZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957990; c=relaxed/simple;
	bh=3xd/joJWN1KGKuU8T80CWxnlSSGrB6886aML/mQlXpE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IwKtZPjQa8p5kxJoLfFUQ1y/o3Pmm9FljFGNdGWHa45Vfk4gC5nrVgBPYX+XSaV5Ta2G9XNARt3+upsrB0tVX1sfGP+6lNxUk1mFxctcROlrmX/6vUo0TJJNm3itHi8V7N92qpfD4hHN2aeyfBQfq7QotMHYsVZQFcLuZa3quZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GI5vj7Kh; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GI5vj7Kh"
Received: from github.com (hubbernetes-node-ea07c45.va3-iad.github.net [10.48.130.36])
	by smtp.github.com (Postfix) with ESMTPA id 7FBF48C10CD
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 13:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705957986;
	bh=3HegjkQy8m/G6toSsTPiVeBrcumGzkRcwzmzy7HE9sA=;
	h=Date:From:To:Subject:From;
	b=GI5vj7KhIb6WKqXNSy6s/cKEOfac82DBN4b0rleoduoYEdn5JvBZfHPxLjKnUcWqO
	 Npx3B3tcwkOvn51HICtP6XAjzoUiIYkJcUHSPhqx+i+vQhCRoho2wqmZ9Apiy+QEdd
	 6RGAxkzGAi0DC+L0lV4cGnvyLMAU1DDPeuVvKs2U=
Date: Mon, 22 Jan 2024 13:13:06 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e0c64a-a9d1f6@github.com>
Subject: [bluez/bluez] a9d1f6: bap: register all endpoints before starting
 config...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
      https://github.com/bluez/bluez/commit/a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-01-22 (Mon, 22 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: register all endpoints before starting config select

Register all BAP endpoints first, so that they all become visible in
DBus before we start calling SelectProperties() on them.

This allows sound servers to know ahead of time what capabilities the
device has, and plan the configuration.

For example, a sound server might select different configuration for
sink+source configurations as opposed to sink or source only, due to
bandwidth etc. concerns.


