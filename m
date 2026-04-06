Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF628AB0B
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484123; cv=none; b=I8zcLyB+bISTnOnTzcubVbKvkj4Gmnbwm0sjxeseyIJn6uSrJy2wiH00ms/TehfGscLzgq4yu+HtltDgrTrq6b4WeExof2eyxrNUKg3hmDWhoh9SXK7xBSLmlZAi2dlMlOPbMRQXh4hmXDU7i6RVluJRqJiuaDbJw0hxwZkWD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484123; c=relaxed/simple;
	bh=QIZcmOLI076FmJYbFFd6V8TvnBC5AIcUm1xC08XgHSE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TUEEFHUGVnnUzZA1dB65J9LJZ7mk+DI1km0LfPDjCszps0e5UaX/W+Ro2d4y0ZnWJOVOEB0zG6Q39C9ffAsh5oqM5E3OvAfV5oT0R3Z9u52drlxu/pvNdi/vsNK/l/qS9ZW15e2BJkjG1Z6xY6HNYuSUuZJtVsfxTOVudpWN+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GVfznP7O; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GVfznP7O"
Received: from github.com (hubbernetes-node-8973ab1.ac4-iad.github.net [10.52.80.35])
	by smtp.github.com (Postfix) with ESMTPA id A9942640299
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775484121;
	bh=WrDmhfNOdsy0bsF/OZ4HCUQ5wpZWFpbfi6dtjwnHIHo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GVfznP7Otyf4fGcfLuL8KENJlPigUK+jbOdeIaBvWSjpxWqC3iU/JExWc2D+yyTmL
	 aFaMCarwnqYls78ceP5v1w8RsTLyANwVNICpde2QadLcvH+4gcSeU435tx9HAWwT5N
	 hJ3ABsE1Pdl3uRNNSwdbjzSBOtQi8rRG1afDk6kA=
Date: Mon, 06 Apr 2026 07:02:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077651/39d78e-000000@github.com>
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

  Branch: refs/heads/1077651
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
