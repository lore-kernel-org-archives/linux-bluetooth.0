Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785A275870
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216967; cv=none; b=J7+FjOgsN770m39lylOVrzbLakSb7jA5ZfY1+sRr+LVif8PmPrrmiQdHKWft09jFygpaev/6+7DCIlLRwtwxpcdEpzbvSv8RyvZOjeTZBz7+by5tqRwMMeAo/CNkYjPWXaqEH7cZFWBQAm0KUIG4uH2rUuvIVE3Jv5IgDwFz/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216967; c=relaxed/simple;
	bh=HDtufkpa+I5HL5UUAi6MxKzXa2aO329OK3GEh/Zlcig=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gTEnCA+CpbPVtXrSrBToOf67m06c5FS+uqBGvdnKkRVBPDaZpYaSxe/jYBj8p4AjT5zPbgba7xuvPS67+0phWvk8JKjnQV5lFyGxCaA2IQFJ8ovSCtcMt0XmgDQIJHRxBWUvCqcQVdznSbUqAW6KMX0cAZmCZB+YAh8G8ck+nP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VIkfMtPc; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VIkfMtPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786216965;
	bh=GwxIiwO/J2ZUd1Bfg/c7cGZaOoNPaK4lUoqDCd/84Y0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VIkfMtPcfDTQVQ9SpJQtRIAfRr9famgpmNyBDd5pFytKOkVde9uSqgEE34HDwUaA4
	 R/34Cs6wal47O9iIMHf+OSmCThIIbOgVH5jIYDcChe3wkdLm3RxC+5QkwyhB3zV3hC
	 uyHWaozz1WJkLjplouXnTVTv5I7/3em9/Ju8rUb0=
Received: from github.com (hubbernetes-node-44f0f93.va3-iad.github.net [10.48.76.94])
	by smtp.github.com (Postfix) with ESMTPA id 9D86F180A7C
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 12:22:45 -0700 (PDT)
Date: Sat, 08 Aug 2026 12:22:45 -0700
From: z4pdy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142763/000000-c92911@github.com>
Subject: [bluez/bluez] c92911: client: Avoid scan prompt when discovery is
 alread...
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

  Branch: refs/heads/1142763
  Home:   https://github.com/bluez/bluez
  Commit: c92911888f02409001eaa8df5022928137a4f913
      https://github.com/bluez/bluez/commit/c92911888f02409001eaa8df5022928137a4f913
  Author: z4pdy <z4pdyy@gmail.com>
  Date:   2026-08-08 (Sat, 08 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Avoid scan prompt when discovery is already active

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
