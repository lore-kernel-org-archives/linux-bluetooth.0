Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE93655DD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918168; cv=none; b=iSdVbw/svzTP+/RV2iIJgmBLK3q/fpxnH6X+AQk3hQ/n9iuuURCZ9asKeCmSbqT5dk4em39FilT2Pfe6KP+MDKYkligXbaPwuSoUz4tqJ+P6r2lur6uEYLAxqvIeg1wBLGURkgJQEc6JCyXtqT0B3oVYIxr6ibHgN+Z9JYCDES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918168; c=relaxed/simple;
	bh=5pmwfw2bStUn8N4zvZJFDTIEFUZW2vVsw3ULVuYTDY0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pJH6rvfO2X9r4QXmM52NuNj/H0dHZAmb8XIVjd38Y8wTIIRPLF/H4bWyeE+QlJ6ij/MMZJq5wQ0GrIBTGNTmBU6Tc60vx89YihirKCI2k6dgGUl67Yo1tgeFSvHA0LtTxxQ0nFdmOGPotbUaBjBX/0dhHEeVwJh8cleEaGUbHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dIJxtAae; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dIJxtAae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918166;
	bh=Qadh4ByU1qNW4Hb/J0fhZG7HaWWFHFx/Nmlfk5uHZxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dIJxtAaeKh0yAYzs2FRrSWBRBnbcXbiXd4IQ/pEx7ab3soLp/926xL8nnemhJrH2k
	 w5M3ZlMGIRdOkqEjrkukaE7AF3xEDf8ccEOhyF3gk9ELonX7BgeiZuKKUeDZTzKfXs
	 PdmauntXqHvjSKV1tX8KRqkJIhBxGRHkCOf3vpes=
Received: from github.com (hubbernetes-node-4231746.va3-iad.github.net [10.48.14.24])
	by smtp.github.com (Postfix) with ESMTPA id 7F4295012CA
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:26 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:26 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107770/000000-374f7c@github.com>
Subject: [bluez/bluez] f77e33: device: Refactor device_discover_services
 function
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

  Branch: refs/heads/1107770
  Home:   https://github.com/bluez/bluez
  Commit: f77e3342b063f9d0d24481b9c9072cf65715dbd6
      https://github.com/bluez/bluez/commit/f77e3342b063f9d0d24481b9c9072cf65715dbd6
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/input/server.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Refactor device_discover_services function

After refactoring we can reuse function once more in function
void device_bonding_complete(...)


  Commit: 5208e0e39be7f840cf6aac9843753ab01ebc96ad
      https://github.com/bluez/bluez/commit/5208e0e39be7f840cf6aac9843753ab01ebc96ad
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Rename start_discovery function

Rename it to start_discovery_cb to indicate that it is callback function
from timer.


  Commit: 374f7c2ed37f7927205a770d66c5b9b1f0f890ad
      https://github.com/bluez/bluez/commit/374f7c2ed37f7927205a770d66c5b9b1f0f890ad
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix returning discovery error for Device.Pair

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.


Compare: https://github.com/bluez/bluez/compare/f77e3342b063%5E...374f7c2ed37f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
