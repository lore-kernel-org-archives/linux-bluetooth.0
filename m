Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7A1FF615
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976330; cv=none; b=bvNKHPiRUj0XKTubGnC+cwus8zXIVuDq7JSgeT1k8wvF4QIgEKg/U0pVwwSQth4FlIdAIacaWnU+XVsF1aFblIiMZjx0osclthIY98gwINycAG7PF+I1GXL53yLCRoPWNU/zdWh1Ux6qJ8xbv0B8KB41+cVnNDkmJIyP4WVjrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976330; c=relaxed/simple;
	bh=lgrGRzThNX6o6xMlPHGL3U19CsC6bhWsgQqMxUIyhKE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e676V63G6aredIotz6tTW7obGzyA3TbU2JHDVa8EwUjMofmsT/eIGSgJJ+YRdjTRNH+SdD4hcGN6BHVAZwbFbvIqF1O84CqAJVXBJZ7xivbmb/tdWPNaU1alK9jGW/a+iaOvXgdF51XffqYaa6aGyUEusx5flVA6N4PnaTlbkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HXvg6MiP; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HXvg6MiP"
Received: from github.com (hubbernetes-node-c4c8ce6.va3-iad.github.net [10.48.130.41])
	by smtp.github.com (Postfix) with ESMTPA id E3940E0B62
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741976327;
	bh=eNX2+T96VkZ2aC4M6FzyJk9M/vWEeMcKrr3w4NGv5CE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HXvg6MiPKaKEo36n2KGFwj3QJlGEMljhlzOTI4JZZuz+aQqD+U5tKvU750T7ystlK
	 QbpJhy3M0rKkz5cGBHFSUuXx5JGXnzfnIvpdkSNvygbIS6K0f3IsETlIJIFj63WmEh
	 H+CCnxrYD62ErhD1HfvbyXr21OyOQZXebZmwLM+4=
Date: Fri, 14 Mar 2025 11:18:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ee2243-21d45d@github.com>
Subject: [bluez/bluez] 21d45d: gatt-client: Fix Handle property of descriptors
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
  Commit: 21d45dda01da8665f04a7d17dbd040c54f6091c0
      https://github.com/bluez/bluez/commit/21d45dda01da8665f04a7d17dbd040c54f6091c0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-13 (Thu, 13 Mar 2025)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: Fix Handle property of descriptors

Patch cda5549f2475 ("gatt-client: Add read-only handles to dbus")
introduced support for Handle properties to GATT attributes but the
function descriptor_get_handle do access the user_pointer as it was a
service not a descriptor.

Fixes: https://github.com/bluez/bluez/issues/1133



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
