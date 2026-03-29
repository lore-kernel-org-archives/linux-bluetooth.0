Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B793C07A
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788499; cv=none; b=Jz17n+DflMOFOvE8kuD55R8Z4C9CHVqEytMwLeX6pQX6ih/pZsqeP/SsY3iTEq6ICuHaWtEaNfmizld7yRnoD2zzpxqWBQ/3q0RA3ntk6Tsr3qt7TmF5XKrfHnXFxibBewBFqT38+m0dXCyoTkpuk+gNKb7WVtDYbdjqC2VgO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788499; c=relaxed/simple;
	bh=7jIFoxsminHcmGnb2oTla3HvR9Q1mhBHio4+dMkLACU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=onXdfgphjcumaQs3zClmC6I67wTkzAJOYdUnWxU59uSwC2A0oYOKaCdjWstP3H5bE/8q04LhaZeWrbnAJuEQumE30djJj2dGNIuN8GrgLPERCMCXYPNantzft2kAraA7hjnLFWE19TBtEDLjyR55jyWoMepbZTwPfxkE3rVuJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eVsBuAqW; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eVsBuAqW"
Received: from github.com (hubbernetes-node-b527d65.ac4-iad.github.net [10.52.172.36])
	by smtp.github.com (Postfix) with ESMTPA id 9C7BF801DE
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774788497;
	bh=Rg30fR6i21JM1fPB/yZLa27fMM3BjblyVSFrvA3Un6c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eVsBuAqW8paVgcJwVI5FQzITKqFml5l1pLluLXy+qvTq89juBZFGeuDm7NCmYeVFD
	 s6Rphr7an5yT7+uWii2sfwnpgW35deYOUVSbVDkfAcG3BirZbeBOqtv4Wt/RnSsHP7
	 1bDmHbMlTTHvs9GZeTlysr7/hYWJTShmNYrINFHQ=
Date: Sun, 29 Mar 2026 05:48:17 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1074168/000000-2a934d@github.com>
Subject: [bluez/bluez] 2a934d: iso-tester: fix missing clear of io_id in
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

  Branch: refs/heads/1074168
  Home:   https://github.com/bluez/bluez
  Commit: 2a934db48e9257e0187b40850a8fbecb1ce0b385
      https://github.com/bluez/bluez/commit/2a934db48e9257e0187b40850a8fbecb1ce0b385
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-03-29 (Sun, 29 Mar 2026)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: fix missing clear of io_id in callbacks

Fixes issues

GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
