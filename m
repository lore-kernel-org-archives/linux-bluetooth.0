Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44427A91D
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923278; cv=none; b=h86PKNLVbTv2Np2Dt29MMYOXvywrRs3FL731+xqJyhuG3bivCYrtzSSk0BKJ5CO6lMhDp4ATy9A/vVT313bOB6EsDCkPdc7+vrxrGnZkih3EDVNlk9e/G0LuYtx4oiNhZYeitMytZUzBbqkyhtud0hDSs8c9nLqSjCMhqRr5qwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923278; c=relaxed/simple;
	bh=x/EfwogDzJKuZwHcRdQ+Tiypn2/7J6rx4imMqKkD18g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jGnJ8+XVqd00GXRSoEjtRX+SHxUr3GOSzeC/lSQCegVNxUaGhKC/TkV+OPjlkUMpLJ3Z727nXx84jc6v5/uTdLliJn4QjDk5gWxqTtYWh+GI3YOIgkN6AZemokTZuZOLZ7OrmvNLVpx7YLC69YZq34UTE5xiW3EidvYaM5ZUOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ROSDt0gf; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ROSDt0gf"
Received: from github.com (hubbernetes-node-25b17b4.ash1-iad.github.net [10.56.169.31])
	by smtp.github.com (Postfix) with ESMTPA id 84F6860081C
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757923276;
	bh=3Qdxbr/ELB1W98hPFcIu2AXJfMelHF4/Y7ovjBdi1tw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ROSDt0gfHsCY0E9+IHx0XQGz3IQ9SVi4CFVTnWEqvLrxDI8OlUxHsezIqz9ZXrtb9
	 k9uf+ie+0vXW7dAq1JeAI235+pHwcLB9Y+W88tT5uZpz96+Ou+jlNpv0HWw60p0fop
	 vmgrP5wWEu74/ibVqnRg0ZTJnpZfOj7lMwgvejBM=
Date: Mon, 15 Sep 2025 01:01:16 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1002338/000000-d4b7bc@github.com>
Subject: [bluez/bluez] d4b7bc: audio: Fix typos in A2DP error messages
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1002338
  Home:   https://github.com/bluez/bluez
  Commit: d4b7bcdcd41a12be0c167b86e11c457f87b3b7e6
      https://github.com/bluez/bluez/commit/d4b7bcdcd41a12be0c167b86e11c4=
57f87b3b7e6
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h

  Log Message:
  -----------
  audio: Fix typos in A2DP error messages



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
