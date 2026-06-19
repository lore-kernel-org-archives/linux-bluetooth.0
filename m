Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B93C0630
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887505; cv=none; b=gXbyh2Gcawplc37pKcEVgB/Rjrv3UtWBJu1DS9boEseu7mpnnEZv5VUThdB+154S0QLH4DQbPGgVSDSMlT6qRr1o2sHCJDXVKFI/nHoZGq7LEXA7P2Q28tycDlu6x5hHn0aZtD62SGUCyM4k8saNSIZSY/WZaa5BiN5fd+QcBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887505; c=relaxed/simple;
	bh=C9hOsXl4QSxRvOUICeEAibr5kQKFH/8QP3RaMIhwUkA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iy8NO3ET+nk/pTDNX59r0rWELqBOLpukIgylVM9RDmN1Yk4E+L+8KaZym//PY7VC7osOne6r3wg/tlx+F+JJ5c0dSxXN0gOqOiXQvIMlQ/ldSYMRqdrWeRLir0f0iaot7NBaYSe3dRPO7FqeVJxSq3gZqcLgBQwKTtpLA2unk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=blO8pF3H; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="blO8pF3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781887503;
	bh=irS3L33Y+WWtjVozw0DGzfofsgAP9LRyis6PjhUeVRo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=blO8pF3H/8SB1h7GQidpuvE5yj3q0WCVuiCI/Yfuj0y6Q56YuHbjFrItEvrZtWOYn
	 6AmVQtxmgiyE/69X5sKFwcxsA/Nrp4WH4tdcaFjzJUUbG90mNfXGKWEBwY/ooTnlza
	 x6YywwUcGb8SuXAMgV5b/uF3WJYQN3azimWiKvSQ=
Received: from github.com (hubbernetes-node-ca41cfb.va3-iad.github.net [10.48.175.35])
	by smtp.github.com (Postfix) with ESMTPA id 3E532800E36
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 09:45:03 -0700 (PDT)
Date: Fri, 19 Jun 2026 09:45:03 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/629b78-9305ae@github.com>
Subject: [bluez/bluez] 9305ae: shared/rap: Fix Mode 0 step serialization
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
  Commit: 9305ae767ac401498c0ed8b1a3abf1484d44f0ff
      https://github.com/bluez/bluez/commit/9305ae767ac401498c0ed8b1a3abf1484d44f0ff
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-19 (Fri, 19 Jun 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Fix Mode 0 step serialization

Replace raw struct byte dump with field-by-field serialization
that conditionally includes init_measured_freq_offset only for
the Initiator role, matching the RAS wire format (5 bytes for
Initiator, 3 bytes for Reflector)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
