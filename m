Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8029A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Oct 2025 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667342; cv=none; b=ktNYe80tIqQJEZ8fhYLPeEiRo6IBdoNd7AjGJU0e1Fh6MrBvOtD2PePJHp53dc24EeNDZS/gFo77eA5HgATJRGQcFS2I7GuKWkPB0H2qZlHOglFEA2M4ImN5GAflybrQGrTmNUhLp/bAKJOZ2IIJGyqf1uBdH0GbkxGMuL6Dkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667342; c=relaxed/simple;
	bh=8c6kmKJRXy0xSmPfSdoOFVAPQRgsPCje6un3ZH3X/dw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pGSSmYjHYmQ3ue6TirWLj6Di4eeBxFS9fUZ/YbcUKhuftBtheIK0VXy/EPXc5rTAAeJ3qJcs9xBYgH1uSx557kJKvxfyB7R2+azBqnUf+tZYUxmaBJ2xmgiSmqlFltL31C4y2xIG8ODpmoxa8BHeytVJi+sNhUCwjz8znvhFjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I3ZpFy3i; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I3ZpFy3i"
Received: from github.com (hubbernetes-node-9427cb1.va3-iad.github.net [10.48.158.17])
	by smtp.github.com (Postfix) with ESMTPA id 636CE4E0351
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 19:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760667340;
	bh=xhDuGqFh7eTX4HTwEs+Hw4VOPBpTdv62AxUjgDHp9l4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I3ZpFy3i9PNOB/kMuyReJ6Swt3QahNJJDZlgEDu2xc51iU05db/ZsUkBwkxmVn9aY
	 P6/AdZoAuMo0g79IYB1Am3q9AwlTQ5htcf8c+NcteB8soN8NbK7AkR1Y8wG9gL7bxe
	 BnOGSez4TEuLDDuzGOdqvCApQMf0FPNy9zHXNffo=
Date: Thu, 16 Oct 2025 19:15:40 -0700
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1012592/000000-70e635@github.com>
Subject: [bluez/bluez] 8e9794: shared/uhid.c: Fix 32-bit integer truncation
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

  Branch: refs/heads/1012592
  Home:   https://github.com/bluez/bluez
  Commit: 8e979494a47c8ae3d0fb17a1489d69df8e0f5a9d
      https://github.com/bluez/bluez/commit/8e979494a47c8ae3d0fb17a1489d69df8e0f5a9d
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M src/shared/uhid.c
    M src/shared/uhid.h

  Log Message:
  -----------
  shared/uhid.c: Fix 32-bit integer truncation

Id paramter given to bt_uhid_set_report_reply() and
bt_uhid_get_report_reply() corresponds to a 32-bit tag value passed to
us from the kernel side of UHID. Specifying this parameter as uint8_t
breaks the synchronization after 255 request and renders the attached
BLE device inoperable.

Fixes: 92ed637ab2bc ("shared/uhid: Add dedicated functions for each UHID opcode")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: 70e6350cd2e70da27f2f716b3ac11843a66006e3
      https://github.com/bluez/bluez/commit/70e6350cd2e70da27f2f716b3ac11843a66006e3
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Fix 32-bit integer truncation

Id paramter stored in getrep_id and setrep_id corresponds to a 32-bit
tag value passed to us from the kernel side of UHID. Specifying this
parameter as uint16_t breaks the synchronization after 65536 request
and renders the attached BLE device inoperable.

Fixes: cdddd7e69e06 ("android/hog: implement get_report functionality")
Fixes: 83ed02d06fca ("android/hog: Implement set_report functionality")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Compare: https://github.com/bluez/bluez/compare/8e979494a47c%5E...70e6350cd2e7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
