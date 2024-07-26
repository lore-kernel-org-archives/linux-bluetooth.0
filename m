Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C046BF
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022332; cv=none; b=qE2BhBL3FI6YnvinCAPxoGQ+//INrizcCf9tw5MduOXgwibjyE7mmw5fhFICQxC3mqk3AuwKq7Nlb3nCVpkZm/Pm30ncuTYTeWnVAi2mFPmfIU9DJI5XQyVO7499t8DFGWSRZ/9uw1C+lwc7OcDhciCcUCrAhjj5CTbyv6/aZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022332; c=relaxed/simple;
	bh=sydrOEiiO8ymdTfLwLc+rtGMSn+jSg/t14ULsxa2eN4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Yd5S42+MBzs7P6sRaic+9IA3r1I0IaZk9uv2pr20mCnhZ853cdB0Nb6JWjvujbRSdPvqevmNqAXH1tvjAsMArEoI0zu9TaJeT+9rQXCzDHhY3DFhpKpZsdCrTy9ZqrWxVWdqZNaWBqFuLc7Mq0ymyij2G0QR1Ef++dCVNuvu7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MCVCsMV3; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MCVCsMV3"
Received: from github.com (hubbernetes-node-9be5abd.va3-iad.github.net [10.48.206.61])
	by smtp.github.com (Postfix) with ESMTPA id D9F1DE03FB
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1722022328;
	bh=ZE4QbN74k14+89YpkdNuV45jVJzR8jN/HGLJvQsreak=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MCVCsMV3NIF1FN9SX8/yM57w7YyqxJBdxRLKXCFPQTkkb1vRLHxNNRa3+lB1tHp2b
	 Ndc6kJczuqpqnd0+AYaoOP8D3obMtbjqKlpm3Kb6BG+byl6q5yVo48qtOhLvYFp9TD
	 Mkk9NSMx0htSmbOJ4cxrICa1umT6v4eCA/VV7JyQ=
Date: Fri, 26 Jul 2024 12:32:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a3f997-fcf391@github.com>
Subject: [bluez/bluez] 4c9d4e: client/player: Set number of channels based on
 loc...
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
  Commit: 4c9d4ed059b539c696e1ebcc92b0cb2522e48a2d
      https://github.com/bluez/bluez/commit/4c9d4ed059b539c696e1ebcc92b0cb2522e48a2d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-24 (Wed, 24 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Set number of channels based on locations

This sets the number of channels based on the locations set rather than
always hardcoding it to 3 which in certain case is incorrect and can
lead for the same location to be configured multiple times.


  Commit: c2312ebe318413f9e72df505fa236024b57429d4
      https://github.com/bluez/bluez/commit/c2312ebe318413f9e72df505fa236024b57429d4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-25 (Thu, 25 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to enter alternative preset

This adds support for alternative preset to be entered so when auto
accepting configuration a different preset can be selected following the
order given to endpoint.presets.


  Commit: fcf39175e35ef086ffbe4e84ed6dcd3bf4c0aeea
      https://github.com/bluez/bluez/commit/fcf39175e35ef086ffbe4e84ed6dcd3bf4c0aeea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-25 (Thu, 25 Jul 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix bt_bap_select with multiple lpacs

When there are multiple local PAC records of the same codec with
different locations only the first was consider, also bt_bap_select
would stop doing location matching early if the location don't match
without considering there could be more remote channels.


Compare: https://github.com/bluez/bluez/compare/a3f9970f7a8b...fcf39175e35e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
