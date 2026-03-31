Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90B423149
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975538; cv=none; b=NeZ0ShprObuW6U+3qDiZA4KDjDDyebj8+jrC6mRJqGLKzxGhVq8pzow4hRp3lRoNvfJnRXxWdGK8YlZVOzJBK4gx2v0XlaqYKz+XuLbQyMkCooV6elEECja3yl4cWNB1ukAlaQCFjTvHvhLJlVP6dLtaHy58nKff5PZRtIn1tKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975538; c=relaxed/simple;
	bh=1Up6taqDfDdzGcusG/bTRrTAAx6OYT2pLMZ3CwZ52AU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P63HKPBI9lC9+Fm5W+0uihLMihrwqoMUU9WLO0bqe2E88YSvxB5v/gixtbLzNYF5fuld5fj4uY+vThrTuRkJOhg0Ou9PSXymlGg+YnNWSF67mw0yf+q3nATIqIe4XYqlIhCK5y12/uj5AMU4FB4+pAMxMGYmb3JyRWtBwHfai9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HTee+4n+; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HTee+4n+"
Received: from github.com (hubbernetes-node-78f8927.ash1-iad.github.net [10.56.202.92])
	by smtp.github.com (Postfix) with ESMTPA id 9913A1411B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774975536;
	bh=+hI47V62fTToh7PiuibRFbU+syn1gBqW8q5H/bx1a/4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HTee+4n+7yxZ/A99D6VxDesU7Dp9XoQzH/ff0C9gocYlJ6cqSV9bwmSUa1NTjvGEx
	 MktXihBycWvmeZXAUe9VYYYRyayiA+xgqg1y69ZUXqtcBixsNtjUIYaTC+1VaveTId
	 EzEWxXBMya6jWUjMuqDCh45W1gvAUkLzh4IxPTIg=
Date: Tue, 31 Mar 2026 09:45:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059646/b4a79d-000000@github.com>
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

  Branch: refs/heads/1059646
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
