Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA5233926
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864033; cv=none; b=NYTYV6Czoq/E3rtzO7M8BWae9lpV9Ng4iq5rmJPCF6lmp6+7zTsikR+NW4haVrKvKLemPIk0+Ag02jfP6G73tE/oTFMf27d0Cds10H3bzCCEABYf+JXJccncNLLS5db/IO3PRlnwwd8zb8TrAm9IcdkPXa0WB/RP7rh445DfAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864033; c=relaxed/simple;
	bh=XPgv+KrJqMYgKfKfbdZ/mWVFurxqJhjCjhRN5PfukxU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H+lsU0IFx/c8GA1IW7CGQsnKvduQ4Dr2olIQwsO7aNeD6Pv/N8MdgkevKNouz7P3bUMhUH8BkNFRYVwgUfD2dMTT5HMstw78IM2Tui7aFdEhqqmk7TqJLQF1grjzEJXBDCVWY3FQ5VQFq8ZREoIku1pFUOe1IbLkiTd2d/qDY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=V7lzgmTI; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="V7lzgmTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791864031;
	bh=1ttO3aZxZ+RErOiwm0//gJApH+siqJLWfqNCb5OZpeY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V7lzgmTIUTXtTv8mRPky/5s4TX4eucVcCNgPW/BoKS8+1oQ0LrSuW9p00YCtXnVaU
	 kxMAgS+C7PMmHO/ooXMb+id5fASClH6rL8y0iHcG8cFBQ7GUq/ziYMJTTUJnWWdLE4
	 /7C+HmpK8e0uXG1EYT1b/iqR+RmY9cUPFnKXYBPo+C2huLQtNt/dcSJIOPuc+iL4xP
	 XG02UfUiRFzqonJ3iJZ1Dz3CBdFQxPJXy6jQviN9Mg4Yn9YvGLfOMWdllmsaRB6qdB
	 YF9AokLEYGO/JBwFx5xpyRDUeEnbwISUeaDZjz54awapOMPYM0xJv64onDSsgl6be3
	 mjxBMRgH560Eg==
Received: from github.com (hubbernetes-node-041484d.ac4-iad.github.net [10.52.150.40])
	by smtp.github.com (Postfix) with ESMTPA id 98D8174103B
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:00:31 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:00:31 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184353/000000-e58f2b@github.com>
Subject: [bluez/bluez] e58f2b: shared/asha: send STOP without waiting for a
 response
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

  Branch: refs/heads/1184353
  Home:   https://github.com/bluez/bluez
  Commit: e58f2b24c46c62d200abacf4ac2d5c5b3d484bb9
      https://github.com/bluez/bluez/commit/e58f2b24c46c62d200abacf4ac2d5c5b3d484bb9
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M src/shared/asha.c
    A unit/test-asha-stop.c

  Log Message:
  -----------
  shared/asha: send STOP without waiting for a response

STOP resets local state without consuming the ATT response. Use a Write
Command so an unresponsive renderer does not hold the request queue
until timeout.

Test command semantics, failure handling and peer STATUS notification.

Fixes: 9948168cca15 ("shared/asha: Don't wait for status notification on stop")
Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
