Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AD2E6116
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767093384; cv=none; b=jKNPyBi3mhiGCRHqhezQtfBjkylGPaX7iRAxIrgP1I7QVGOftY5tbUaXwjDHGUUEyvYHnBwPKCPKymEdr2ghwVZEZHelX9Exc9kcVxORDS3z1yIw3tLCoID2bg1xZGUXQf1kUuCi2TpHs5vK5vaSjRdgPi30XgbIztXqCVd1zxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767093384; c=relaxed/simple;
	bh=nvwF4ho/KIP64jkNiV2BKW0OuLWjqNJ9wvM9dC8JN2c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cie+0cyxfZtQW79+LinFjcFrwLZOi2qvj9GWd8gwpqzatGAKS2WB6y+wV0wc3kn9ANeL3NBYjZQieh4Lh7nN9QA4DTTWkkW4c5h5xYG3JfQibLIbY6hghEjlMhFwfVBafAEUWlMDekYXZQp20DtEDz8o327LausRgtzK5EJbAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kIu5BBNS; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kIu5BBNS"
Received: from github.com (hubbernetes-node-f10d5fe.ash1-iad.github.net [10.56.152.31])
	by smtp.github.com (Postfix) with ESMTPA id 6347F9202F3
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 03:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767093382;
	bh=0UYPyukJmxudQMUyT9dv1sYa5GilX6a0Tm3kAM5luzY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kIu5BBNSz1GWExnhFRx0UD6gz4Qo8BpJMHBebNQaHquFgw8Y8Zrqm81ZCBvhrRZiL
	 aGqYBqmc4IcRwN6mRHRpEpknD+hDYJoNy+ur3/SKSRBj9k0BeV9L2lhqUXB5C9z6NQ
	 2MEH5cZXU0Co4v5RvcJ+ka2BEgkXbLIMjx2ZqsqI=
Date: Tue, 30 Dec 2025 03:16:22 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1037326/000000-d031ad@github.com>
Subject: [bluez/bluez] d031ad: bap: remove setup from bcast_snks when freed
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

  Branch: refs/heads/1037326
  Home:   https://github.com/bluez/bluez
  Commit: d031ada38bacbf7c53869b3392c9c06ce3bb2767
      https://github.com/bluez/bluez/commit/d031ada38bacbf7c53869b3392c9c06ce3bb2767
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-30 (Tue, 30 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: remove setup from bcast_snks when freed

create_stream_for_bis() adds setups to data->bcast_snks, but they are
not removed from there in setup_free() which may cause double free in
bap_data_free().

Fix by removing setups from data->bcast_snks when freed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
