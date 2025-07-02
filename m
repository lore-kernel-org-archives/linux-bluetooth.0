Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518042798F8
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462414; cv=none; b=uAzz2e9xYB3Q3NU/fUBEKiX5q/pFCx3ynfuhrm3wiI1A8klsKCCtS866wRUOLMe8ZWxO+9wR61BoglxWYPJJaH2i3U2eTynUjUtbQPprRKmM11ZYcl5mMbeFDXiaDrUKC4C0ilviTY6ftK5f6a9hPgMqwy0LvtrARfHCNYgolxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462414; c=relaxed/simple;
	bh=7N891Ngr+q7nJPhuQ5v1DhdgFF//PB9su6/FbNnAyoE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g6UAa/ULD0r+4vH6PYlwZmdFM7UQbvwDsq3A1uNj6oaE4KFuQ9iIJi9ctCGqJUd5TkQuN2VvDOAETDiyAYBIaN7pNDV7CLE+ThJlhi6GqOBn5GmqQW/WtkFdZtuX6DeY3YzJhlnc0l9gB7ibM79gymeT7M87BFcMeBAjQ1Vt2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EMoKMVGk; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EMoKMVGk"
Received: from github.com (hubbernetes-node-6d6f13a.ac4-iad.github.net [10.52.14.72])
	by smtp.github.com (Postfix) with ESMTPA id 6196420787
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751462412;
	bh=h7NmFoM/adeav/0hbkq+VYk0QOEwUiXwXMhh0Cf/4og=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EMoKMVGkODqdgiL4KGrdnTrf28gKWOrevbclNGX25Dbo4/gFdRSkYuPrtkv3X2I1L
	 rJ/ih8wMSDi0n9KfflSPfTIcDQFIUIIhF3A4M8M8W6WqkS1ab4EP8fdA9Xr8Fdc+76
	 R+Drm/twI1QpYzYw356zBtjKSsSm6VfocCHxhw4Y=
Date: Wed, 02 Jul 2025 06:20:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977912/03123e-000000@github.com>
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

  Branch: refs/heads/977912
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
