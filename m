Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B8256C6A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581791; cv=none; b=Fx8TSlHQW7x83N2xKNsy3U0qNXqOjlaRbIYq2lSA1TXOjp0yAHu6wmrRqRv3M9LfOdkV09qIolbGdQL6nGhQh8gwZu34vLmzvg/fyqYkVILJ6EvWUgO7A8Cu9xa/UMiJBOkFxYQzXbRAI7souORrqNCP2pvAgpZfSk49D8K3274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581791; c=relaxed/simple;
	bh=kr9EX3+obOCbFGkDK1eyosClYE9iw898cHJLU2QY9qs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V7PSnv4Rh96p94a7mb40SKoDZY8pPILKZUNlchrqxAQNDdIjEayYywBT/T6fHEfnCoSikvu3ecBp4bb4hdLc/ZTgvvdOJGEhdj4wVYFmrz+sPWRRXlH1cf35hmMfMDAqDIL+MBpMOJiyejdg0Pgq5Hk1EpMA6YkF2CHGIkKz7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JV7/1h6S; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JV7/1h6S"
Received: from github.com (hubbernetes-node-cd72301.va3-iad.github.net [10.48.148.31])
	by smtp.github.com (Postfix) with ESMTPA id 46A8DE03E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749581789;
	bh=a5whPmCG3bCgU5WN7eyb5jgScfphLlZEqkqtZUE5qlU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JV7/1h6Sm4hdztldsf+pj/t8/QBEVUjxgY0G1eRmQj7V4mU2ZgajUKt4WbXyKI9AN
	 zTfsIJq0i+ZQYEcRgy8H/XuOuiok5rpH6ps7DzwqvOtdskx9m0GH6Gnmy61FkGQQX5
	 25dzrcFySmSFSK7+p5YgH5jnqarIXuIPRRdD0AC0=
Date: Tue, 10 Jun 2025 11:56:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970417/ff3f31-000000@github.com>
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

  Branch: refs/heads/970417
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
