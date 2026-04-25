Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CB29CE9
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777103332; cv=none; b=SbC+8dbcxb+HdREK9o8eK22wF+ubeLr1jqyKhST9CMizQ1f9gezYiA2YWUULcIe61UjUg51gQkAP0J44zt7quz+71qhgawqDfmDV0ja0UEMxN5mLaqVtj80EIq+GpvzUXjQfN2DVr/3bc5ZPhSC6F5wYK5UZ6pqNnf98JHa8QZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777103332; c=relaxed/simple;
	bh=kzwpMnyyHv1EFD/rBwiBsxlQZhlzkROnudKoxG2D1Oc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ABRtNoLqYXrFkem24YWr5d95N1xfVQUX9u9X2c9Wv1GVLXVL8oHPWVRddbLvToyK/Kdum19QKB0GVgdvR5Kb1gPvXeQNnsA5wCNnMw3bEnpmBUH9Jk8yOwrdn8RaCrWZvhzuV3Fauj3XPH7EKnJwZmM3VQqiqjhVTlapVfRyOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hvwWB5H+; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hvwWB5H+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777103330;
	bh=zLeyS9kT/zSYy9Bv5KvH+eNEuSKIWvJ6OQv1dDH33zY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hvwWB5H+/F+CJgE/FbHUtRzKqvSM7Rjvs/XXtXRCGHPzEZBKtjQE51Zi3VcbFPtQl
	 bI27n51jL+U0qqI1T+s4GXHgj+K5b1hmbpMSKI0Pimmdq3zOhigV0XXRcRAjHGnO+O
	 twdo2K3j3Jr+xbT3Sae6ugbvcJLVTKfqucqpBDpE=
Received: from github.com (hubbernetes-node-dccd559.ac4-iad.github.net [10.52.13.23])
	by smtp.github.com (Postfix) with ESMTPA id 98A74941130
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 00:48:50 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:48:50 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085439/000000-06d3ff@github.com>
Subject: [bluez/bluez] 06d3ff: src/shared: Add RAS packet format and
 notification...
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

  Branch: refs/heads/1085439
  Home:   https://github.com/bluez/bluez
  Commit: 06d3ffc22a4170460bb75021d91a44ec0201df70
      https://github.com/bluez/bluez/commit/06d3ffc22a4170460bb75021d91a44ec0201df70
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-25 (Sat, 25 Apr 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  src/shared: Add RAS packet format and notification support

Add RAS packet formatting and notification support for CS reflector
Implement complete RAS data pipeline:
- Handle HCI CS subevent result/continuation events
- Serialize ranging/subevent headers per spec
- GATT notifications for real-time ranging data



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
