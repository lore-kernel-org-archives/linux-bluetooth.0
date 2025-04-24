Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A827BF79
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508786; cv=none; b=HgPUxVMjnpx/zKD2wfYcp0byi7Q5QwpW8PFdhd6v5cwtDgfHfmvThzy7PM6wsGRaVavz3fCS+T4Sh0pPuqyA6NyM5u8kt39ozx+WImyfGgBqqGA6Ki43pGvHR+4Y4scmn1fJPE1BxDTVEcg7//lqvr/hw79w4pHZOh/WD0pxf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508786; c=relaxed/simple;
	bh=A/kxHzxW0kKV/zNdVskTzn901OttQEkPD+t6YvhsQcs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Tt2Z5hOzl7i0GeMBAOjrVXAUDF4QzKHy5iT5Q0cyj0D/etlg9fS0MkyaFTuiX36r7fCqQUOsKZIT9Soks9GDOemBEv188BYRhtB8ljas7iezyj7UVTVjAS03ZLtCnMkFbWNOEo6z+6E573OwlMCGxNjBNFyyCD+wE9PFyFNL3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cDFGTM4B; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cDFGTM4B"
Received: from github.com (hubbernetes-node-79efdbb.ac4-iad.github.net [10.52.144.34])
	by smtp.github.com (Postfix) with ESMTPA id 0CD0E2126C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745508784;
	bh=Bn5UZRWE0oMz5/7gTAEfXTZHpoQac9HJwJwn7CWQxU4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cDFGTM4B2vjIIP7MdMoV6h/ILXDrV0t1Bsbr9++Jhs1AQ5aYbjUbcDThrqknV2gmp
	 gmp43EpjWF/eBOiiQkuONzI/UdX0WTtLlfY1oZUhEOnZpKWmWKpGg9K3BPxV6nIskS
	 3cE+t3vpWxtaiaHEPxlnQ0rmebYCFNAdXkRzRoyc=
Date: Thu, 24 Apr 2025 08:33:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/629672-c8bce6@github.com>
Subject: [bluez/bluez] 9a769a: workflows: Make use bluez/action-ci action
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
  Commit: 9a769a3af138202a95e37d4196cb27fbcb665aa0
      https://github.com/bluez/bluez/commit/9a769a3af138202a95e37d4196cb27fbcb665aa0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M .github/workflows/ci.yml
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflows: Make use bluez/action-ci action

This replaces the bzcafe action with bluez/action-ci so we can maintain
everything in the github bluez organization.


  Commit: c8bce6574327ffb34358bf6829b1ddecedd0ed04
      https://github.com/bluez/bluez/commit/c8bce6574327ffb34358bf6829b1ddecedd0ed04
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflows/sync: Remove workflow job

The workflow branch update is not needed now that action-ci no longer
use to base the PR and CI tasks.


Compare: https://github.com/bluez/bluez/compare/629672307f6c...c8bce6574327

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
