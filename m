Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93116372B57
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228321; cv=none; b=lRXyJHZRpy0FAcNFDrIntttOOo04242sEMv14I78nKMGN4+pnJZ3gbWjrh+LFyMiRmw54MfbZKJ23V7AalczA7G/2Zum27ZGyKfP4GYbN07ZVavEgGBZAB9PaoFgD8p2jFDMf8j8+nNL39mewflPFBMMBa8YiimtvAaWesV/fmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228321; c=relaxed/simple;
	bh=g/sPptnvXGN9uzpBMrpwBFOUSNfxH/aNUFrylfqfRWg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AMcAHlXD+6LaZEJR3ORN8jQUrxlPKyEd+YBvFG+q4fCCZfJciI+7KGS52h+e5NUPpv0YgllW0ubDuSB6Y160EtOfkDX01Oxj1YHWWmEFhvLKafk8JtKqbSOxk6fsNhA7a5AUBHIYhjh7XGNlpSxRIHUDoRf8PUOf0RU5Q+ta8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dxc+hyTt; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dxc+hyTt"
Received: from github.com (hubbernetes-node-be332c1.ash1-iad.github.net [10.56.169.38])
	by smtp.github.com (Postfix) with ESMTPA id CEF3EC1194
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775228319;
	bh=fNF9DkaLhmQH/ILQYhf0rAwEaqAVp068ZG4eBaMeCdM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dxc+hyTtgzwJkOXGODuQGdYlrGuB+i1hbijFxiSaoqRRaWBl6NYkw5/2dOvgGLgat
	 6AAs/AovwunkmLoJTMTt5wHOfW50x+2IIMTIfn/on7+Nf2L5UNEtYwSsyjb9aoAFaO
	 x97vQkIbrU2TOqgiwcZ+oNqYklu+xJ+ozB4QpjzQ=
Date: Fri, 03 Apr 2026 07:58:39 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077051/000000-c5e55b@github.com>
Subject: [bluez/bluez] c5e55b: client/btpclient: Add GATT read and write value
 su...
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

  Branch: refs/heads/1077051
  Home:   https://github.com/bluez/bluez
  Commit: c5e55bac5e782c02ca2365e3d1e8025273ceef84
      https://github.com/bluez/bluez/commit/c5e55bac5e782c02ca2365e3d1e80=
25273ceef84
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M client/btpclient/gatt.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add GATT read and write value supports

This stores the characteristics proxy and handle so we can call
org.bluez.GattCharacteristic1 ReadValue and WriteValue methods with
the "handle provided by PTS - 1".

This will allow to pass BAP/CL/CGGIT/CHA/BV-02-C and
BAP/UCL/CGGIT/CHA/BV-03-C.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
