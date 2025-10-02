Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2F245006
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423037; cv=none; b=qkdpTOg1DTGy5WedhQ66q6U06CbFsVGFbKEpEhyR+YZwshLaBSSuz7XnvUy1FIkq86KcSLGOEKJRz4nWpaosTmweHjn6WgstQ4uwgQ7SL4/PNK3ot2EYz+Fgvecg7hxnd2PwdFnKWvyfb+7mwjwZD4OAIUq/Kl6mQ8uIUsX/Zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423037; c=relaxed/simple;
	bh=zGCDJjehuknLi9MjaFgX0QriozZm+7lq9h+ocs6tPCs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nY5bY2NTu0afiP7jMEQLM4zyWFQlMe/I03/CBFOME7XqgMtgSnl6nV2SEY0EP7FpYMHvIPqdelLH+9D9a3C5mf1bh8OqE92uWWv+A8BWQlGnn89sQTTePgxuMDoy0XqNm/e17JU+u/fv1W4hi0bHcxn+IrrYodMyDC72Ik6nAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nFA2L63R; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nFA2L63R"
Received: from github.com (hubbernetes-node-513d18d.ac4-iad.github.net [10.52.169.47])
	by smtp.github.com (Postfix) with ESMTPA id 2150E640CFB
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759423034;
	bh=smUjC1XYkcrAX9pa18CUGTzoCWAvMgDCY2+C3XJ8wME=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nFA2L63RSuuZXGWSC6LT1b0+T8wu3ahG7WON4VnwhiNOnrHRJ0UQlIJ4kTEq+DdpM
	 MQRTId6JYNjwXOWuABO03rpQu6jDiGcEJNG9+lFDT4sQk8tMtD3FqIOkej4GXum6cU
	 ZHXR5/6++Yl0l+yfDMZU18Cqf/Qcs142r7Hcxqws=
Date: Thu, 02 Oct 2025 09:37:14 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008059/000000-5172bd@github.com>
Subject: [bluez/bluez] 5172bd: shared/hfp: Fix issues found by codacy
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

  Branch: refs/heads/1008059
  Home:   https://github.com/bluez/bluez
  Commit: 5172bd1a220a12cb036844538ffa8948da7538cc
      https://github.com/bluez/bluez/commit/5172bd1a220a12cb036844538ffa8=
948da7538cc
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M src/shared/hfp.c

  Log Message:
  -----------
  shared/hfp: Fix issues found by codacy

Move debug string after check of hfp pointer.
Add missing argument in debug trace.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
