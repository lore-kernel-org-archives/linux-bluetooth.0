Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B6154BF5
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390801; cv=none; b=PHmXnHHUpUUkLJZVXa5H86qZDjQn0j6ziyhlUQF9W3kH0LmNpr7fEtTJ9WRCwSuM+Otf8hzW+kBqTpPur0OhCm/RhZ+gLZ6lsuB5rHozXr3iHursIJ30i3xKtkghIEODvvceohE9Uaah5a/+gDLsLBwi5EfpY/yqEF+lBNezz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390801; c=relaxed/simple;
	bh=aUBdUZI8svoCPwhtuZvDVAiXG96BvmsW7xO+75mEdrc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q/KdGjxsj0cC7WxfDc1WMvWsaa3/4qww1T11AroOn6HefKUZy8aUzlmufVGuAHJsDx+r+RHUvMxlbzi/4hadscLiOrYE8yBxVUXCkGSyWt8CpDlXElCE7UoshgEi1N5jgt+K7xnND2PkRT+BG6K+OuoP1y8Rts8IwFbQQi59xWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZKNK141R; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZKNK141R"
Received: from github.com (hubbernetes-node-640f864.ash1-iad.github.net [10.56.170.15])
	by smtp.github.com (Postfix) with ESMTPA id D30701408F2
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754390797;
	bh=St6RcOtiRhbXbE8msrP1VFU63fwrIaplFIxXwXQ5ZnQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZKNK141Rw7MbPOPtpo0NXb/Qc44ye8LwOCJTnziTk6hcOqnGAXHWTI6zyaH0atbfn
	 yBrYUt+NADFam7R8KsVc2TgulLg9gYv9l5aR9RduxX4CxwbRKkMNujy7wOxKidYyxP
	 K1sKSgb4hGa+/QFTV3d2trEeiZ44+frba7VESIQs=
Date: Tue, 05 Aug 2025 03:46:37 -0700
From: Myrrh Periwinkle <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988417/000000-935713@github.com>
Subject: [bluez/bluez] 935713: audio: Don't initialize device volume from
 media p...
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

  Branch: refs/heads/988417
  Home:   https://github.com/bluez/bluez
  Commit: 9357137e609889fa697f2ad6d5d41ed2979457aa
      https://github.com/bluez/bluez/commit/9357137e609889fa697f2ad6d5d41ed2979457aa
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-05 (Tue, 05 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  audio: Don't initialize device volume from media player

Media player objects may be shared between devices. As a result,
a device without support for hardware volume that is connected after one
that does may end up being erroneously considered hardware
volume-capable.

fa7828bdd ("transport: Fix not being able to initialize volume properly")
introduced btd_device_{get,set}_volume that is used as an alternative in
case no media player objects are present. Therefore, we can remove
media_player_get_device_volume and instead use btd_device_get_volume to
determine the initial volume.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
