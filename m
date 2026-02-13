Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691B27EFEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002174; cv=none; b=YOXzzb3sADck0OINRDWVaxWtrVUbCTdlDZPLnh7WEtaUdbkv+EdpAHPvIDEbJwvI7+3jFWxc65ND4so4ubvoKQlFjPIdgYqdk2f9vtkvyN647FYT4TtePfaqbn0qPw2kd4m3WCssXOu+YsNDSkOSfJWhZhQ4yYQOnqnnu7wr3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002174; c=relaxed/simple;
	bh=r9ug3D2OFVW9umuu1+MFZ3kabLC54EP0DrP8aL3PyJE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CGyJiNOdtFxWu8o0H683EjnP5mzdCnzT02mwIt+SStZXZVCbsp7mzv/9mQL/8W9iU/F4iRVvsGL+chawEFPiwTJXMg8NAIzR8mE7hql+U94Q1YlQyR3CdKCFu6e1FTFc+Ewllwrx6M1e9Fk6JWUixc1fv367vA0ensw+yyHAT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SsOjcyNB; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SsOjcyNB"
Received: from github.com (hubbernetes-node-fde30bd.ash1-iad.github.net [10.56.201.93])
	by smtp.github.com (Postfix) with ESMTPA id 4779B141281
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771002172;
	bh=T51X6XQmlstqSnYiMqZGpr/X+B38srygc/KhU98WBs8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SsOjcyNB21Zvs4CmkhmFi9j3fudyn+mww1Fetawm3D5wpPKGm+/hntYGPzi/BWR2l
	 gr19Wrsk3B038cU5CmozhhEFZGiq9gbavNiMWD6hK6Zc+4v31v4T0jAIw0tNuyDaVx
	 NmKycZR43TVzRqxnsMLQNffRdR5xyVFEDMYfADCg=
Date: Fri, 13 Feb 2026 09:02:52 -0800
From: Sarveshwar Bajaj <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053982/000000-11f128@github.com>
Subject: [bluez/bluez] 11f128: bap: Fix use-after-free in broadcast sink
 cleanup
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

  Branch: refs/heads/1053982
  Home:   https://github.com/bluez/bluez
  Commit: 11f12809eda49e6ffb36de106b61c1d0e8eae87e
      https://github.com/bluez/bluez/commit/11f12809eda49e6ffb36de106b61c1d0e8eae87e
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix use-after-free in broadcast sink cleanup

bap_data_free() was calling bt_bap_detach() before destroying
bcast_snks queue. bt_bap_detach() frees all streams but broadcast
sink setups in bcast_snks queue were still holding pointers to these
streams. When queue_destroy() calls setup_free() as its destructor,
it attempts to access these already-freed stream pointers, causing
a use-after-free.

Fix this by destroying the bcast_snks queue before calling
bt_bap_detach() and ensuring stream references are released while the
streams are still valid. This matches the cleanup order already used
for unicast.

Crash trace:
  AddressSanitizer: heap-use-after-free
  #0 bt_bap_stream_unlock src/shared/bap.c:6384
  #1 setup_free profiles/audio/bap.c:1123
  #2 queue_destroy src/shared/queue.c:60
  #3 bap_data_free profiles/audio/bap.c:210

https://github.com/bluez/bluez/issues/1866



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
