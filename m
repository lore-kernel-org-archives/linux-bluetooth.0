Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906F1C861D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136027; cv=none; b=j/fasbspeoGyKTPsMcOHF++9w38frE7gHnF78UtMK34BulXg+3hj1rVnK5TnBWLpDn0zht5ChyxLnpm+pXYnC4WXMS1lKdVWaLGREfjzwnKu8Nek+4hxzLcgNnBIPnnT47t839Kox1TP7rUujFw97oK3g9SdCIFHZJ41jbxbzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136027; c=relaxed/simple;
	bh=6W9L8TXX4vcdCpk30ny2FfjA6nMNt1GYFVeLgugGjUY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cC0cTaojSllhx8PUAtIRAiu1gUEZdm5bL4l0grF1F9b7Bw0XpjvlghZgTvRWUuc3SA5daLx51PxkGie1f0E5w7PGJdeI9gKOneGJqNXqu/yq/bykUtBLcApsTrwSG3joejUhTuEwdif/CvbTga+LnvHSJs5Cy6dWIcFfHBkDu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BYWOVtm8; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BYWOVtm8"
Received: from github.com (hubbernetes-node-ee23af2.va3-iad.github.net [10.48.207.50])
	by smtp.github.com (Postfix) with ESMTPA id 7C836E0705
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756136025;
	bh=sGn7GGRP81qWuv7GrpevGWVXFoVzu7ihbTofnxdUhAg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BYWOVtm8Qobl66/rE0aJsBu02C9S2IX8WE7oVDm5VB5TKPG2e8OAMr5bTH1fYrDCU
	 /u0w/zzSTqI5UkiW6mpmCTih5hIsux5PG8eMm3Z3iVOvXFIipnQuyH07vTI0hHobgX
	 Y7LgQ4IBJ/5STy4wWGFsOW5Djg/rPrMP8nLNjT6k=
Date: Mon, 25 Aug 2025 08:33:45 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995289/000000-8c6057@github.com>
Subject: [bluez/bluez] 8c6057: lib: Fix out-of-bounds write when concatenating
 co...
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

  Branch: refs/heads/995289
  Home:   https://github.com/bluez/bluez
  Commit: 8c6057e570e6eccbf3a6f565fbc2d55ae9f19116
      https://github.com/bluez/bluez/commit/8c6057e570e6eccbf3a6f565fbc2d55ae9f19116
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-25 (Mon, 25 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.c
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  lib: Fix out-of-bounds write when concatenating commands

This commit fixes the hci_commandstostr() command by writing new line
character in place of trailing space when wrapping long lines. Previous
approach was to append new line character to existing string, which
caused buffer overflow when there was more than 9 lines in the output
string.

Also, the last trailing space is removed in order to return
trailing-spaces-free string to the caller.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
