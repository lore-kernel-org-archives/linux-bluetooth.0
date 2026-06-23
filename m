Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22743D45CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215223; cv=none; b=ItGyXsgnve6O8Ni7+jdyHX436QBsTvC3r7VCVmmgqyfYarhTLy89Jzt0Aov6D3Br21dQldll6KinAhD0tFBqi33KJxgGmnVuB7r3WoctWWEVzrRCRLkvdkuGn9M71b7hsQOB7MH+mL18Y8rK2GV8Gc+Y6lGjuJxcSg8VArkqCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215223; c=relaxed/simple;
	bh=+KYjLKZ5v8WIPeP60z/H86nsspHEisKl10qk+H1u/mk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aBUcJuENVePOw4s9SWjKDi5CdcfKZPiCOh+ojdYRHA4Ta7nAWx7Of8XBUBzd7M8IoJx6lF6sbAIl5ssbU6URENo2VUDc//7PMQUswLd6o0RanRq/72eTvPpAziH75GFHhgp7fTAIAO4V68VPDD1Itzx+TLRy6vXpIT9P+5niMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fy5Vlx4v; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fy5Vlx4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782215221;
	bh=Q5t9Ea2nAuzKleWUGrfkoa44gmtFAQw+O4JbRXI8N80=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fy5Vlx4vsTNjdEYIXeOuvHRy0W979GE7QJxJdLRq++va96xnNcz+j/A2CJSbYdNlQ
	 dEOpRZSHNz2NzT79HA+VT6HUTeVGCG+BmIDOk1K/T4giWM1meIng331AzYk2XPoanM
	 VLLAdQdf+Qh+N3qxoQfKfIOcyG9u+vmXJusjL15w=
Received: from github.com (hubbernetes-node-fe904d4.ash1-iad.github.net [10.56.224.24])
	by smtp.github.com (Postfix) with ESMTPA id 2D1D9520AA5
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 04:47:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 04:47:01 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1115319/000000-c62fba@github.com>
Subject: [bluez/bluez] c62fba: shared/rap: Fix step payload pointer in
 parse_step
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1115319
  Home:   https://github.com/bluez/bluez
  Commit: c62fba1e317d2fd3e80682726ddf4a275db2ae85
      https://github.com/bluez/bluez/commit/c62fba1e317d2fd3e80682726ddf4=
a275db2ae85
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-23 (Tue, 23 Jun 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Fix step payload pointer in parse_step

util_iov_pull advances iov_base before returning the new pointer, so
mode_iov.iov_base was set to the start of the *next* step's data.
Every step was therefore parsed using its successor's bytes.

Switch to util_iov_pull_mem which saves the original base, advances
iov, and returns the pre-advance pointer =E2=80=94 correctly pointing to =
the
current step's payload.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
