Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242612033A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665474; cv=none; b=BAzc8FDlZBOf37cqZir6n/Kk9Cc8V9q7Io34BDXtdg2cEg/yhic+K5B/+ViG2JMwp6JsjmmGZTHeLZyMr/zZhyepeufWx7DBcy35yI0/rGqnbioyTAaMwPyKJtRRtcm+gMMlc5NrY54pLOmbZRfcxvai4j3y4Qg/FKG1R+yMZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665474; c=relaxed/simple;
	bh=Mthlah2FHqxK1CWtpdoUeO9N7FlS/tr7dvzEWG6MniY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uWLuf57261sh4M3u06bZB5ijhlN/L4Td+nasiq2iPe8XWsqjSJYTQcT9XhTVDKJoUzwNjhbcdAeNgPO52dTG3ChutG+p5JLmxGpjWA9+CAvlkOArfk/2ZhOvr4HmVCsImLc81dlP0wSEx5444bkI6rYtysXEFfYXmsm7ymuClKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kY7KDJI/; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kY7KDJI/"
Received: from github.com (hubbernetes-node-8173dae.ac4-iad.github.net [10.52.154.43])
	by smtp.github.com (Postfix) with ESMTPA id 2C7432126B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747665472;
	bh=yaBCalH210zBRiCxRu17LJncipMDHViETw09plstepU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kY7KDJI/xoEqGcQ0YpKbEdXq0QnR8NfugHh6/0XLBEJoEYZ1ivtWqqABIeUTdYRYf
	 ljhC2ASkkEZ42NyMoc6rN/rGvutiw2fWWZyqN65EwkeSAlFbOinvWDIGW6EPjqjl7A
	 lkV1ZFc/dU52sVPqPOtEW2IHwWkelvGqunCr33Ow=
Date: Mon, 19 May 2025 07:37:52 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964210/000000-4230a2@github.com>
Subject: [bluez/bluez] 4230a2: client: Fix crashing command info
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

  Branch: refs/heads/964210
  Home:   https://github.com/bluez/bluez
  Commit: 4230a22cbd5b3ebc7eb4dab668f151a5bd2df82f
      https://github.com/bluez/bluez/commit/4230a22cbd5b3ebc7eb4dab668f151a5bd2df82f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Fix crashing command info

If command info is called without any parameters, and without connecting
any device, it will call find_set which doesn't check argc and argv are
actually valid.

Fixes: https://github.com/bluez/bluez/issues/1251



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
