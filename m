Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731D40B6C5
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685736; cv=none; b=edVbvJBhTPFL9xMLo2XgXom64ayLW6QcltdhrJZ0ZSqKYPKv5rBeIiaNkPuqq8egrG8k7OgRn282KA/ec6yedeZtxF0gpC+TQUAsq7O8b9JNq2QHReefWr4E8TWJvuFqvU2RBar9bcJJyPLiBalAi22aLYvg/CBOKMswCUFOsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685736; c=relaxed/simple;
	bh=dsyiahXPRMlTnG8zh7yW6yRWEo6BwkyLtUaRHDDHN2g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tRgAqOBkJSbb414RhQKqMQdC1egpuOlD3qvdaWjl3lgZucQLpb9du/wOYW+w814XhpvWCsPo9ii/09x+QP44mEUHD+AYYsM1qN+hFZmK4rjFldisjDQjg9WcXkNrHjhkwtYL9IPltYhpo5C0pWW4KYSnvocDzKcBLquHPQtN2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qebxa71a; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qebxa71a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778685731;
	bh=tLIk5BbnvvmH+GR/f7XIo6sqyxw0Yq7QQh3enqruM/E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qebxa71axVPmW9dGYFFlQHBg7N/oNdUYQkZXSZ8FSMimkmYxRoiFYCjz6OrOmVL8/
	 WoUJNo7TBfwNwR5dfnBGIp+/heJSxLqx9OybIumq4HjaElREbRN8b3M7Se4cz+ee1N
	 8whZv3na1Roey11NrUm6CuV4y7T0Y/yK7gqXKfzk=
Received: from github.com (hubbernetes-node-e054e8b.ash1-iad.github.net [10.56.131.83])
	by smtp.github.com (Postfix) with ESMTPA id 59FF0923310
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 08:22:11 -0700 (PDT)
Date: Wed, 13 May 2026 08:22:11 -0700
From: apusaka <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ee4a47-c47895@github.com>
Subject: [bluez/bluez] c47895: monitor: Add decoding for Microsoft defined
 event
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
  Commit: c4789506455f639a330ece6016912b93c9a419b8
      https://github.com/bluez/bluez/commit/c4789506455f639a330ece6016912b93c9a419b8
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M monitor/msft.c
    M monitor/msft.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Microsoft defined event

This adds decoders to MSFT LE monitor device event



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
