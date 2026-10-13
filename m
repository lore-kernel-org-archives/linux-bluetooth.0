Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87F55C1DA
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932750; cv=none; b=OpZWlrLZj/jVmOTJn3p3TepFJGVIcBRZWKX1EsSNtseVWHt9su8unSb7gvY8NFp+URgBMFVncQyEp8cvxwQ5SAsfl5Sstu3n2hWq5iM04rG+0snPChgalkkrWTMbewneLp10gwENEVXLKA4+kplH1TEvUwI+fKkXqnreM/TkTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932750; c=relaxed/simple;
	bh=gTngj/tItek4lUcvz5K8WQIvsz/XFtyu+Pj/JyHfyz4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i9taEkX8Wbu2UaDoyoKfdCIzyMUNTcRJcI/hkuiM2SqsKnTxhfkRyPG96Zf5OZhwuY5OGS8W/vDHpKMiAUDB4+qI8sJPs/EC0YdYN+jecjtIM58adc/tD8kQ1zYj/3b1a0aShbiw9KVXWKQ3f2QxQ0B+wmpYt9Azbn5fy4TTfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=StsP+VEA; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="StsP+VEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791932748;
	bh=tpnmyqXrN84pL3v/Kub8DlVUi9SF0cZ3ktbGns8FXj0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=StsP+VEAfGfeE/5vmakuJuNUTk+j9TVEURZABLP/o+ih3bz0TqAwSKg2bRe6AGWn2
	 Ag2ZLCfs/CK1XRcNlPnzZG3dOGNC6gPxxRw+/LfH/o0V4lVQ9qngAxURmODO3kBXbT
	 z+yznwxXG0kXvagX3ffVkvnDx/4Cdg21o3q2wHx1epvIJC6SZTsuKSPJkgcImvoZst
	 SrDOyq4RoQ3TUSCU6oT8hfks2a7T/+Hqurv7BxehJUDkton/VJDgulTA9mMFSp+Rrf
	 IMFLOGVxabABbRoNVNwk03FqoKmkW1e+D5AmlGc13f8Aack0bs+O35ctrqTDKgLCER
	 A2LnEYIjDoJDA==
Received: from github.com (hubbernetes-node-9e5300e.ash1-iad.github.net [10.56.211.73])
	by smtp.github.com (Postfix) with ESMTPA id 0E722600FA5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:05:48 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:05:48 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1185115/000000-3ae2bb@github.com>
Subject: [bluez/bluez] 3ae2bb: asha: Notify connection interval changes
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

  Branch: refs/heads/1185115
  Home:   https://github.com/bluez/bluez
  Commit: 3ae2bbb6575df7d55bfc0b4e76c519a0a0df5f7a
      https://github.com/bluez/bluez/commit/3ae2bbb6575df7d55bfc0b4e76c519a0a0df5f7a
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M profiles/audio/asha.c
    M src/shared/asha.c
    M src/shared/asha.h
    A unit/test-asha-conn.c
    A unit/test-asha-conn.h
    A unit/test-asha-interval.c

  Log Message:
  -----------
  asha: Notify connection interval changes

Omitting the connection-update STATUS notification causes repeated N8
supervision timeouts even with a negotiated 20 ms interval. Restoring
the notification alone prevents the reported link failures.

Observe successful LE connection and update events per adapter, associate
them with the ATT socket's handle, and announce the observed interval
before START and on subsequent successful updates. Clear the observation
on disconnect so a reused handle cannot inherit another link's interval.
Notify the attached HiSyncId peer as well, matching Android's
connection-update STATUS handling, without truncating the interval byte.

Reuse the verified socket handle when delivering a live update.

Add tests for event delivery, controller isolation, disconnect/reuse,
pre-START ordering, failed updates and peer notification.
Use source-level mocks so the tests remain valid with link-time
optimization enabled.

Fixes: c26389c466a0 ("profiles/audio: Add an ASHA plugin")
Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
