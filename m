Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED211C5D6A
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599908; cv=none; b=GenCDhpj+Wz8seVKAs/bFHVmoLiQhQ4MCfWV80qkll2NAyExkZTL/AQSaBnEkirZo+W2OHGpmWAhUqOFyCURo4c1fXAMcFVWGZ3QiGGxiP1G4H/O1YDHAlD8/07loDVQ9D7opanWVxx1sbIzkaCYgXpCdOIcYWKXF3IlnRVKOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599908; c=relaxed/simple;
	bh=VFZQ8LXDii8z1XDzBh/iNwz7SM4yX4L6QdWQyNIt/ws=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oDpn6TjBvQOZDFEg2uDRYUTmagTu4v0QcaK+KQX+MVi3e7yIpDr8M/FZKn+a99/J1gz71mfaqs8v4DkaQsCzHirY8rnKUC937+DE4tj9sMbmSq/fBWepqp4ULq7U2D2ZPm59F6kAEyElUuyGlR9hxJ5GSgeWioyPbT2t0WdmnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ePVKJ69D; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ePVKJ69D"
Received: from github.com (hubbernetes-node-feb6d77.ash1-iad.github.net [10.56.189.47])
	by smtp.github.com (Postfix) with ESMTPA id 024A192126F
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745599906;
	bh=4qKn8lGxGSWSTEbTuAjZHpl0zXw6wvjMP3IaK3Dx8W4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ePVKJ69DEhHLk/CdFsr42sSvkFDTvSeLyJt31olv3ItlbmZP/udJDx7PDEqVmlYeP
	 WHaO+nHVDk5LY9JyzADstCcuSerdx57Nc9Kkpazt/Wmsa+tCczpkTxIOqP+SY5q+oF
	 IK/5Ik0STn29dvtvmZYQvpvn4qsPxrlLrRTsUbVs=
Date: Fri, 25 Apr 2025 09:51:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957118/000000-97ecb3@github.com>
Subject: [bluez/bluez] 0c1026: Add support clang-format
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

  Branch: refs/heads/957118
  Home:   https://github.com/bluez/bluez
  Commit: 0c10263345ed57abaa5d15c44e58d7dbc30f071b
      https://github.com/bluez/bluez/commit/0c10263345ed57abaa5d15c44e58d7dbc30f071b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    A .clang-format

  Log Message:
  -----------
  Add support clang-format

This adds .clang-format (based on kernel) which can be used by linters,
editors, etc to check the coding style.


  Commit: 97ecb3cc423c578a27dc45914b49a8dcc40ec28e
      https://github.com/bluez/bluez/commit/97ecb3cc423c578a27dc45914b49a8dcc40ec28e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    A .editorconfig

  Log Message:
  -----------
  Add .editorconfig file for basic formatting

See https://editorconfig.org


Compare: https://github.com/bluez/bluez/compare/0c10263345ed%5E...97ecb3cc423c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
