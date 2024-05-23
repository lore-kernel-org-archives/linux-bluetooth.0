Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664017C8B
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482431; cv=none; b=Ug2hLQbMSaOt3sWjz92e8aG1IAARUcFYZF/y7DakwqZ4mxYObkwMAMFCmt6zzY6nMZ4R/rIbP7wPyJjjsTsJzH/GqrT+UQ+Ee8ZHEwPnGswXXeTYmyMJo5T9E+bUOPMBTLJw50LChibMriTpI2Nte6FrbrsDiJkUF5r9ogQAoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482431; c=relaxed/simple;
	bh=AJy/NP1fc3SBaVCa5tbiMvIuwfNDvf43n4/6uh25mP0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tgsAGvXtsBaZ9pDZQmz3QrNkY4mMwmUPulHf1fRY0NesHKQ6VYHBOfuxmHpFqX/1Moqs9XX9AMqhbC88XX9hlKojk9+iGwdwCeSyawYbmj+9vRGeApVadp5Bq6Y4D/dM6hDnN4FJ8sfJX74FiAY/qOsPksgRMA94dY0xEj5gsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AHYiqmS3; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AHYiqmS3"
Received: from github.com (hubbernetes-node-f60b2a7.va3-iad.github.net [10.48.206.47])
	by smtp.github.com (Postfix) with ESMTPA id 0A83C8C075D
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1716482429;
	bh=Xrs4PSCXFuwViXe1SCILbRBNWgoVwx+6v1IkU4fWItk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AHYiqmS3yFb7389gaBOwkW/yDw6zv6H3J9qZFonhpQLlVpr0N3rAPYaa4/LMO6uW9
	 WqruZC7xh8JlbhQicYwYwXTcf5DWRf4i0+8pSm5anOhpkl2zwFJi9BcQv6fC4xEYME
	 Ko41L+kAy3EfMvFefilX4VEf040ub2uSbf+VB/s4=
Date: Thu, 23 May 2024 09:40:29 -0700
From: silviubarbulescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6e51ac-758930@github.com>
Subject: [bluez/bluez] 5da00f: shared/bap: Update BAP Broadcast Source state
 machine
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
  Commit: 5da00f712989c9840c5adb538be2d4e14db0b523
      https://github.com/bluez/bluez/commit/5da00f712989c9840c5adb538be2d4e14db0b523
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-05-23 (Thu, 23 May 2024)

  Changed paths:
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Update BAP Broadcast Source state machine

Update BAP Broadcast Source state machine states to use BAP define states
 for source Idle, Config, Streaming, and an intermediary state enabling.

Updated test-bap too.


  Commit: 75893035705da57efd6f8a84bba77d596c463d34
      https://github.com/bluez/bluez/commit/75893035705da57efd6f8a84bba77d596c463d34
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-05-23 (Thu, 23 May 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Update BAP Broadcast Source state machine states

Update BAP Broadcast Source state machine states


Compare: https://github.com/bluez/bluez/compare/6e51acb0e846...75893035705d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
