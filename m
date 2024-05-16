Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27B1429E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881019; cv=none; b=Qz5mWCdgBfsy8kOpX+Sc/KqJlou5IUS+dh++tcFCVC+043l5T/zy3X5QLnJQ0TQnVORJS4F9tdX/GEZThivSwMnGB1VWlfHoyQzkoj9GiioKpFwDUh4YARQjOkHsgAMMEpe+rJosyukpS1aNdSbw5YKxGB5PQNuIABq2jzChku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881019; c=relaxed/simple;
	bh=U2tfma21NQYU0YkgPxX3uBmxa2ciRr86OTVug4ttwEQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q6cLF830nUoLJ6RLIWoU8AvE8M114vbLPAJmVU2TO5Rya5pDnsmblgvdYXV68XTYChzktX2Lv947p7QXFITrxGCar2rFJcMLeQCVE1BTHxQtPPiy+4u6xmbOaV4ZQBiKNGLH0GuOpkL9AAjRwVywBFHtD7LqHCKYi6boMzBKmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FLstRjk6; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FLstRjk6"
Received: from github.com (hubbernetes-node-957705c.ac4-iad.github.net [10.52.160.14])
	by smtp.github.com (Postfix) with ESMTPA id AADE1700860
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715881017;
	bh=Pj+TW2s47PGeDJQRcaw+dQ3/ngi2yZNd8YhXUnym5SY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FLstRjk6T2jWWRKbsQ52sGVXeq1NFQDJeXMLGEb6G3/UkUwUkJHyIKAhDUxakn5jx
	 nm8Ug1xRmGTI+3yIfrY4fbjAGtizt2vKt/WEVI0QduBWQYPypDxkV7hf9iKNyeR1EY
	 rOfr/3AEMjlvwDp2T6RZYHJlgCKZWrwUq83PqX/U=
Date: Thu, 16 May 2024 10:36:57 -0700
From: Andrei Istodorescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d9de30-745f32@github.com>
Subject: [bluez/bluez] 98818d: shared/bap: Update stream management to avoid
 PACs
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
  Commit: 98818da25b2329dd0ff82009c167724df19db880
      https://github.com/bluez/bluez/commit/98818da25b2329dd0ff82009c167724df19db880
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Update stream management to avoid PACs

Remove PAC logic for BAP Broadcast Sink stream creation.


  Commit: db8c96059c02fefd232d49dcbeb16d6b22481100
      https://github.com/bluez/bluez/commit/db8c96059c02fefd232d49dcbeb16d6b22481100
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add function to check the validity of a BIS

Add utilitary function to check if the information from a BIS is matching
the capabilities in bt_bap. This utilitary is used when parsing the BASE
data so that we can decide if we create a new setup/stream/transport for
it, or advance to the next BIS.


  Commit: 32d147959b8e7de3fd3d4dc7d208b25f0f2d652e
      https://github.com/bluez/bluez/commit/32d147959b8e7de3fd3d4dc7d208b25f0f2d652e
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Update BIS management

Use the BIS index received in the BASE to synchronize to the BIG.
Allow bt_bap_endpoint to be NULL.
Remove the Broadcast Sink code from set_configuration.
Update BASE parsing so that it creates streams and transports, without a
remote PAC and endpoint.
Update bap_find_setup_by_stream to find the setup in case the stream does
not contain an endpoint.


  Commit: 7aecf3bbcdb2257661116758154d827e5d15eb24
      https://github.com/bluez/bluez/commit/7aecf3bbcdb2257661116758154d827e5d15eb24
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Remove not needed function


  Commit: 7b1e0e503cb8a4e555496a542c06c318e112bd48
      https://github.com/bluez/bluez/commit/7b1e0e503cb8a4e555496a542c06c318e112bd48
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Return the local PAC when matching a BIS


  Commit: 745f324de5898bb63878356bd6639ae6b7e2c3fe
      https://github.com/bluez/bluez/commit/745f324de5898bb63878356bd6639ae6b7e2c3fe
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add stream ops for get_location, get_dir and get_state


Compare: https://github.com/bluez/bluez/compare/d9de306a28fe...745f324de589

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
