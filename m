Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFC35FF6C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495835; cv=none; b=GPVZf4niwBX4fk+RTXvqQtB3iltIRiefASmnTQGsnFG8hRZjKmBDVXuaJA4CUIBBk/NWBdZ8cZsH73muhr5Ab9o+7Ihfjcw44Qf62TwrROoMVUijJS4Mbr+TIoCe4yEpR57/403T24ZJ/yi5VG3o585pqqINGHUQfTrXa7w/3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495835; c=relaxed/simple;
	bh=g8JypmdCyR4TTMIs2TOZf9Mxyl+KnDQgvZwdAjfBtqg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jbWNg7GOokhGmi4Ggt+/ilseHVo0QzyLft8xR3LoaAG1yeEsTqqVK8s5RbyUD0VLc1gNoAn8hJG/0seDclZeQUlIiY9Ri6i3d2tON98epUwY4h/kJ6Vz5SWRnyGm0WRWS+FZrB1E0XFDMEikYyjwMxbegaY9da+OC9p9ux3vy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=KUtFsM3U; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KUtFsM3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791495833;
	bh=6b23OWgff9btp1DDmffhrAdO2Bze8c8EZIIgcrW6l4I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KUtFsM3U3AsudlhH61OUfO6PcRmi//SZ+U2jgkmwIzucDj0VHJwMRkGoc/WGdcLA6
	 0JawY6FjTTH3JLodkMBw5XcvPZkrAKS1O2vpSJpz/aE9zhonTCpvGjYfp0W3MtpxRI
	 v9fPLyAFP1B0L7HmDkvwbynWPbPWyGP4eleZoJChTLyTvUKFhRCV+b2nLXDMb8H+7W
	 xnioZhWztzzgPezc5roq/SW67rvjmFJ/Ni+E9fpTQKEjDXOmM6vtMKz3I8i9414HZw
	 8io1OAKchVUxMgn1nqDQYoh8sn9goT/JYiw1z1yTQRafn1GKnoQofxy2sb+NWLSIvb
	 pMQV6Fa4dJcaw==
Received: from github.com (hubbernetes-node-f46095d.ac4-iad.github.net [10.52.85.59])
	by smtp.github.com (Postfix) with ESMTPA id 707D5741208
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 14:43:53 -0700 (PDT)
Date: Thu, 08 Oct 2026 14:43:53 -0700
From: GBerfield <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181803/000000-05c12b@github.com>
Subject: [bluez/bluez] 05c12b: client: Handle system bus connection failures
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

  Branch: refs/heads/1181803
  Home:   https://github.com/bluez/bluez
  Commit: 05c12ba57bca7619df37922b23deeeef31a7a039
      https://github.com/bluez/bluez/commit/05c12ba57bca7619df37922b23deeeef31a7a039
  Author: Gabriel Berfield <gabriel.berfield@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Handle system bus connection failures

Report the system-bus connection error and exit before attaching the
object manager when the connection is unavailable. This avoids a libdbus
assertion abort in restricted environments and releases the initialized
shell state on failure.

Fixes: 8a05f2b1ac91 ("client: Add initial parts for the command line client")
Link: https://github.com/bluez/bluez/issues/2446
Assisted-by: Codex:GPT-6



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
