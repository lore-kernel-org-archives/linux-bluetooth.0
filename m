Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3317D355
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680358; cv=none; b=fKi/eyQ00ikJU/0x173EBDkAHxiWJ/HrJDcPh6fcZ1WqJ0PDn2mikNQO7/ku8s+fzOQGJ2mcg3xzfHoa4siY1G8rG+JchNhhGseDZeVJiK2F8QZi+3wFMhQ8GaJPQtjN43//2yYLQ2ZqeKwNcGSUdT+ALbXshRwv+tK3BCkqzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680358; c=relaxed/simple;
	bh=pKg1o84KS2Z5BQJTj0sIGP0aKx48lA7DHAMIdPT/adY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P9y8Oyp2JIsdjmpsi5OVaflJINiKudhdVU55IAwj/1kiCz/J0UXaR4BTpfqF5WHuONAeOIpaLiDk4mKBqQnADf+x4FCT7+TGVkgwRhXd+D8Mvlvj2k3IxxXO3yibY/0olXTg1/075ZW1fW0+UOiKOF+oeJf0njujgpxVk9ph9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BOFBonu6; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BOFBonu6"
Received: from github.com (hubbernetes-node-79077ff.ash1-iad.github.net [10.56.153.33])
	by smtp.github.com (Postfix) with ESMTPA id DAADB140404
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 10:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740680354;
	bh=2WtMlGcBjpTFsMfFuQkw8zlGJsuMRXI1auXMdm3d9yk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BOFBonu6HY2j7DR3RNsEbKNZn8tPt7TJDFSLgSl69omxH5QvOkL7fF7ky/PK9Mjd2
	 7bvFTTudznpsXLK7z28LoMYrgoh6yp0jNVFu+qlmaZqj0XrLS5dRFFqfAdS+f4jr4W
	 1kSdbJZxs1147VtjJqHcWlIYEab6Oewk5Tr6ZImY=
Date: Thu, 27 Feb 2025 10:19:14 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f4617c-d68dc1@github.com>
Subject: [bluez/bluez] 4b4c93: shared/bap: Add support to register bis
 callbacks
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
  Commit: 4b4c9383d58ad63faf18908e5d3864d52dc686c1
      https://github.com/bluez/bluez/commit/4b4c9383d58ad63faf18908e5d3864d52dc686c1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-27 (Thu, 27 Feb 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add support to register bis callbacks

This adds support for registering BIS probe/remove calllbacks with
shared/bap. This is needed by the BAP Broadcast Assistant (BASS Client)
implementation, so that the BAP plugin can notify BISes discovered
after parsing the BASE to BASS, avoiding direct function calls
between plugins.


  Commit: f49953d96fab77fccf80ab5af56538ac749c3489
      https://github.com/bluez/bluez/commit/f49953d96fab77fccf80ab5af56538ac749c3489
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-27 (Thu, 27 Feb 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Create BASS session with Broadcasters

In the BASS plugin, BAP sessions created with scanned Broadcasters are
notified in the bap attached callback. This creates BASS data for these
devices as well, to internally keep information about the sessions.


  Commit: d68dc1fd03bc86a5427ca8738c04fb692cc95263
      https://github.com/bluez/bluez/commit/d68dc1fd03bc86a5427ca8738c04fb692cc95263
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-27 (Thu, 27 Feb 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bass: Register bis probe/remove callbacks

This removes the BASS add/remove stream APIs and uses shared/bap to
register BIS probe/remove callbacks instead, to avoid making direct
calls between plugins.


Compare: https://github.com/bluez/bluez/compare/f4617c531abe...d68dc1fd03bc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
