Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832012C15BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975469; cv=none; b=s2WZY+T+p+2oV6o3oeiCje+b0JFgkzoAHMFQ2npQV/efH0tLV0DBIRPG8gq8kuLhg/FdfWr7YSJhF8q2wGm8KEPyvHUNDt6FVL+KzPyCqB2y8ZBPegZdEPwAx9vhc/GbyLC43BTg9avGeFoq5PTjeFwQgPl1Tj7ac0xwXp7P6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975469; c=relaxed/simple;
	bh=L5O0mKaGChVReQL+NSYyxGs8SglA+Lz+D4S9Iy+ULbc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VoDbMe+IkepowmcTgcLIOby1CvIQcmT/iE6SQkY3gDR5VN3+tYVMox7UtvJuqKbyCt8S1+NqvQYraR5rcGWMfims1qu4t3bb9OHQpMORoY17AWgkSTLw+5vNZmTOWohdMF/P8v6mB7iW/x5iv1XIpeUcOUvox51dX/VZ7RKhJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E63HPVRc; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E63HPVRc"
Received: from github.com (hubbernetes-node-a03e55c.va3-iad.github.net [10.48.180.17])
	by smtp.github.com (Postfix) with ESMTPA id B1BBB4E045B
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774975467;
	bh=3JAvoOQO/KoktkxU181+rw631DWj/zsNOctsx0MrAD4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E63HPVRc2xnUmX+lp0TWi/Qg8DufaZqu9oB3z44AS3mD08Knz7Osf7XE+i3kHkb/N
	 UH6WzCtOcRoGhFHZr2FdCR2V0Fn2i5rRxwbYFI34KsnL+fF+ZnEZPvPFnBvr67JRf4
	 7N6DTLUkzNMJkl442EZMl5JLuvmtvzjyKIh0YS1U=
Date: Tue, 31 Mar 2026 09:44:27 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8ea1d0-f99562@github.com>
Subject: [bluez/bluez] f99562: iso-tester: fix missing clear of io_id in
 callbacks
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
  Commit: f99562ebea5849ee8fd49026a2d342c242a1fb9f
      https://github.com/bluez/bluez/commit/f99562ebea5849ee8fd49026a2d342c242a1fb9f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-31 (Tue, 31 Mar 2026)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: fix missing clear of io_id in callbacks

Fixes issues

GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
