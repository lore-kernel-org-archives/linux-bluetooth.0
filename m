Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC636A341
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399325; cv=none; b=lOOqSAMuIij26kusra91RQHgb+mqYMWWULHHn5Nm/WIFpJlZmhbwVh6EFgg/BfFFs/aHEsU77av4g8mLqGMQO5P2D9RIhWI7zXv+ZEG24ccERMD1lV9MWQNFYQVvs6XtDHbW5LmbF/YQm0aasWrINmDGk1DqjgdgGTP/tKjphos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399325; c=relaxed/simple;
	bh=/3Mk51qdEKp920lNbQVuu505os8aglJMQuolZwo14I0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y1hXOVpkew52jt5ddXRpyf8EA1M8tjiD0TTZlKeVAUwi8XjVSvjmqs4PzPZOafQofid0qzNiVP9PiI9rZccRT5wxNYIBP+LezDtLKfBDLmWaqb/mLmLovuohRPFfuiPs24nGLRVjAByR99660AjgfDy9tutadLL6vWKcvntq5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=Cm0QYVTo; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Cm0QYVTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791399324;
	bh=rEoRlH9T/Fc3cA8itebKYSxut/GVSIHBJr6JYrmjFkQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Cm0QYVTowi5Vvnp2mzaLYtQuTgAW1aI3m5Xv76pg3Z7Ei/oMlKNopZRwVo0nCngdx
	 5yIWTu01Sc8a9KddE15MlI0T2chD9b22RTZREFmfGLUu8vGRbL6KGWxUGV18qbVflw
	 Kjh8sYrWSWgmYyWpbYiUJKkSLB116K1+wRnmDNqt7f6GjEl9BO5lAwVlNgbjhWo8CR
	 F628+fzIgF/zRnHQh/I2dNag4wIAkDg20WNIIQIKZhvwXwKfsKvwOric3whmzHOVls
	 wW29egqh0Z9Agyp1JqqqAGpDBw/QK/wr7ElF6I2vQWXsvCHe1WXy1MUChsn0FWk749
	 wE1CkMjZXhzUw==
Received: from github.com (hubbernetes-node-2e8cd06.ash1-iad.github.net [10.56.195.28])
	by smtp.github.com (Postfix) with ESMTPA id EB6078406CE
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 11:55:23 -0700 (PDT)
Date: Wed, 07 Oct 2026 11:55:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1179769/d83398-000000@github.com>
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

  Branch: refs/heads/1179769
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
