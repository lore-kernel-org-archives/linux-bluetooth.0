Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA31F4262
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752346554; cv=none; b=eyfLF0cRoN7PdvaQ3zJCwu8iJCsq4gp1zfU2hjpQqApKwqkYlvwY6mKIM1sPa+zpC4Hzatm6XI4pGrkkS6PXbiUjEy2tJak5vws53CJfVKkOoi71WpjRsM/NOk06IjrfGpOeth55rJfileLayNm6BJdrZ8quTJe0pjlfWNsYB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752346554; c=relaxed/simple;
	bh=gL9RmfS5O7KqGXCXsddj4ySnj1gcKcqOwuLgGMIHbfk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j6XIt0OIlcnoH9WIFJ5NJ+2aThNl2yeZetvRFNpMz925hPEQGyaoQ2c5LusxbGJAIT5C4pvckF4pdb4oXW0lvXEqK9H2SYcezac7qzNYAhx1YgVXTvI2hlqqYgT561H9PQhczelXSDwK1/rfc7CBUxVBxX8iJg5G3loWtMaH/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Pbv3QsUh; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Pbv3QsUh"
Received: from github.com (hubbernetes-node-e11d38a.ash1-iad.github.net [10.56.193.35])
	by smtp.github.com (Postfix) with ESMTPA id 44A40920211
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752346552;
	bh=LsIv73bhCtVK1VQjg1quiAB8NTunNpF3plaUKsXePoU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Pbv3QsUhlMbOf4MjggxeZmJOJNHEEaM1zrNoperEy9ul+1+PGVSmsT652SweNCzsW
	 3Da7G7QrJVPA7m5qwMO0aDKpjqE9u2qIJW4jsWqqp6TKsI13oFMYb2kGcBOsePuTaY
	 fJYUQ7T+MeqwTv1xDvIf0tDhF39cF8bKItkBg6jI=
Date: Sat, 12 Jul 2025 11:55:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971489/1464b4-000000@github.com>
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

  Branch: refs/heads/971489
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
