Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620234AC142
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369435; cv=none; b=l7vb7Io3PHjVPpE1fB+LxGttml1RL85g4armcSLXOWZuYTUc5Wiv1JjQtN8HXtUvp0AKTei2ieKgd34QbrPKxKWtbnU6pipm0sIj5wYQRwSZgyI/lHkzUysa723bE8m+YqOFatW5yoMCyKx6QyNQK14RE/bBezA9OtIqiIPTgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369435; c=relaxed/simple;
	bh=33Q+MEKd5HkSWjA3UlBtzVrG9ZFNZUTMPY4NiSGpeJo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iztkff13u78az+LN0O8wPXlJQPl+6WtvLoqRXDoQP5xvLXjVad5C1WS5p8s9wNYS9yQHsAo6rls1RyQKhLrc6vLBVg4W7cgPJunBeS+3qtLOBW5reEAj8qRZQhheOAbcm0oflDvfjBxkLNTURB2UYk1sYOXTZT+gh1/4Ps2ih8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iTzajmGC; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iTzajmGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788369433;
	bh=XygxuD17Shd6wyft1DcagPYTjHJJQ40Nsq2b2ZJriQQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iTzajmGCn/r+jU/AteCmmVoL1RrM3aeg6DJJdd5FmBUiaEQu4RK3Eg8/E4MMjceNM
	 7RMcHT81Pe51fJYwQmokuG5I+9tM2cY1Zy/65qWEf64fChGjbOx4f0qUioo7sXI57K
	 4nrKOcA2noR0vtjY3N5YUcdjTsROzEh+BOOMsfYA=
Received: from github.com (hubbernetes-node-a6ea14c.ac4-iad.github.net [10.55.91.15])
	by smtp.github.com (Postfix) with ESMTPA id 83E16941241
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 10:17:13 -0700 (PDT)
Date: Wed, 02 Sep 2026 10:17:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154589/38f8e4-000000@github.com>
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

  Branch: refs/heads/1154589
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
