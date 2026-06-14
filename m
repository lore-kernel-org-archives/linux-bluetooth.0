Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915E376BC2
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438920; cv=none; b=HHcHQLa4kHJqrKgKmDRuldccr2rZvdBbGQv9i1gp9eNB29pkiTMmkSJ8xa2uldnWnL2OWnWalrTbGJDfYqJb/DtQRhvTHARhu/ZTTdAzycv9Q8UJGHRVA/2j5VyGe7S8e8LIwE3wHvCxrarF6vOq/KRObenP37MDwfPgKlrdYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438920; c=relaxed/simple;
	bh=kO5d3UjNXSegRz8ZO1cDh984LzXfkpFyJSwtwrhkC04=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YLuwnHONLsLM8tkaY+k019CzRhHeHQ2wyGPvFx8XnCR3+0MVBLjvUWeqT3RZKO9s1b4wtg0No/G2pKkmL9Ur7FVDEVQt+objtbY+QTsiV8CUKyuY15Ac2b+vksF1qbVVMDHOFAzeJfHJ9FByHtnki9+sN1mxU6pfKwBKlgLZVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ROw2icr1; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ROw2icr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438918;
	bh=G8DxS5WMg7AxMblsuSUMOaus3KPdIHXagwRb3CkCIic=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ROw2icr1bfzXdJ1b+nSdJO6xeEqo0flBeQpFB7kTbmAFq+wNzrAlbTvQPddmdpqM3
	 rMfHeiPeYezNowMVh0GrzmaYQ4o2EmzXOUHUXl351M5ZLqEKTcraZcBt4WRCz9xxZL
	 KCFn/gFbRmAE0Qs6O44i3/1H4GZZ4aqhGCO9nRr8=
Received: from github.com (hubbernetes-node-5f57d0b.va3-iad.github.net [10.51.89.35])
	by smtp.github.com (Postfix) with ESMTPA id 8355B1803C5
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:38 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:38 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111256/000000-ddb5d4@github.com>
Subject: [bluez/bluez] ddb5d4: media: use custom DBus timeouts only when
 remote s...
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

  Branch: refs/heads/1111256
  Home:   https://github.com/bluez/bluez
  Commit: ddb5d4c135465f5645d42dbe978912fbf0552ee1
      https://github.com/bluez/bluez/commit/ddb5d4c135465f5645d42dbe978912fbf0552ee1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: use custom DBus timeouts only when remote side is waiting

Under high system load (VM instance on boot) it's observed the 3 sec
timeout BlueZ uses for BAP broadcast SetConfiguration may be missed by
Wireplumber, as these are set up immediately on startup together with
any other setup (eg ALSA) that may need time.

There's no actual need for using a short custom timeout in BlueZ for
this, as in this case there is no remote side that is waiting for a reply.

Fix by limiting custom timeouts to cases where there is a waiting
remote, and use separate defines for A2DP and BAP.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
