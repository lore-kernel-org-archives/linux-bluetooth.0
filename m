Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6D2D661D
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Nov 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763791019; cv=none; b=ZAhlpXTtxo3oMK7YB3SC5wA88JBhwaSEeEaEUyRR4/5cOJLy2AdEJ+3AqHlPkS/p9KFRWkpjkN2DjlsS//tCvJsMisHUdWqOLUdNx0ZlueADeHafPzFx+uq5ADvmjJT9Trg+rGXcqH/GhK2/ZIVvDYFbnMAsVSR5v9f4Bc1BLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763791019; c=relaxed/simple;
	bh=LxurVittwFBXNC9+CaCy/iP/HfzTiH6UFLIoHbE/aRQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=o7JjBIpqUKSCTXnUe3nLsBhwzSihn6YecyziIwmxx53PjdNOQN5vJIofsRxATRJ308Sl1nuU/kJCzGg8FB3b8prU83IMnf//kOEDQ2i5VIPbQ4oUc+SoKLf7XA+JSaMPD5bbwaLfgeaeM9KUkL22dF8Td8uYaBCD1Z8TgPrxEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YHGmFDr1; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YHGmFDr1"
Received: from github.com (hubbernetes-node-530f5b9.ac4-iad.github.net [10.52.206.108])
	by smtp.github.com (Postfix) with ESMTPA id 366D1400222
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 21:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763791017;
	bh=9A/iy2kMEhc90FnKl+tg2fdvJjs5ZFhlK54nsBnIXkA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YHGmFDr1lAgc/t8qmYv6dO1jzrQYizQx5l7jMGqX3JdcEMj2aayDIgszUuW3B4RyB
	 VZTwitTlBtv/8/YHIiOr1amwq3Z418hBorSuycoK3pImoooB6JHWaFg8lLEe9YNJ0a
	 gyCsTVeYbrG6VwtXdh8IxFt0V/cL1f1U/kVDdbGE=
Date: Fri, 21 Nov 2025 21:56:57 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014817/708285-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1014817
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
