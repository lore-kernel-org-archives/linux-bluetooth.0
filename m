Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62132EB5B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547017; cv=none; b=VLpAyoRjqRbfLmjZqZbGkhschzZq5zkxbi2EM1z7oWeZZqrY63JNUvYgZmyKNQnELYZCu1iTWzXhVSoKJvL8zxKYAgYi+toxENT7kcy4rdfHpNF6hHeWPTttGybproUewvGYvdq9OqtNcWq3y5dIEww32V/4QQOywcJbmbsejP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547017; c=relaxed/simple;
	bh=vt4MZw74squZwSuNIHqVBqGmbRfwTiUybHBgV1SnZdg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sy5tXj2eZMU7W56rFmuBeEozcQsLLrvNqPwFEIdEWcuETdSk7SecC0ZYCvS9I3w2it7ythC+mE4BAT+9AncshDTqXP9YWYXWTbe5TqN6YXGhkCfjMeGsz8RalghrrADDnvrFhgGdiCnwy3PwvfhuZAQ6Dl/D6DG+UfLyW0121gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SO4utPTS; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SO4utPTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781547016;
	bh=wpXwL4pf/UzYzWaUpffF6iifMn2FXRuq5Qrk9AcgOPg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SO4utPTSk7Rs+RyXyEsOO/2ZdVGb4onOBYya2Jbo0USYPLUGn9hYU7hj4C5+mUNwp
	 FnGNtXeRyldvyDmKfiE07GIoKgRJqN01tFl0RCOmmbDEp9eNTrwXAlXyAwmTi7R+pr
	 V2XdiGE8D38MRkOC6LmnntXwZqBSFQye9tHJyYo4=
Received: from github.com (hubbernetes-node-7c2ab5f.ash1-iad.github.net [10.56.194.49])
	by smtp.github.com (Postfix) with ESMTPA id 1A9F760104B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 11:10:16 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:10:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111256/ddb5d4-000000@github.com>
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

  Branch: refs/heads/1111256
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
