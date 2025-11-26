Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B030EF75
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175656; cv=none; b=KkvxI/zg/rMiTf5SHsbGqCtNOqVCxJZN23z51cnr3ABVJh4Uq2+xWRIBYMH51vQ8sv0820YrETL/2MGQj3YkKh/YD/bh/cOU6S2JNnjuzAFj6kC2pFfoEZM8VQorlXCm9arG6KNYsUmKGAXjpP8LY37F7Yo5H/V9ShwO+t08yVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175656; c=relaxed/simple;
	bh=RVbQuhj4H2ODyr3jkK7e4BmwcOv1FH2j5yTqCjRVnII=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eY98J3Me2jDQIhGWXPeM6ByyATP0nJuGN9JlcrM3+bcuBRfy7MiTPae7Qs8GRry6rJbpZSABtHrq4YuOwCK29k21WS3PmD550vqdtXmi5qBOvhWcaNqOYK0WPR+gcescKWzux0Lav9WYCxGRkc5Vspl8PPSDmZdYuZjDN7arUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RbO+/PvU; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RbO+/PvU"
Received: from github.com (hubbernetes-node-ab1f054.ac4-iad.github.net [10.52.134.36])
	by smtp.github.com (Postfix) with ESMTPA id DAEE220374
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 08:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764175653;
	bh=TB3EazHg1GJ7w+f4hbG3hQHCGCSfm3o7AAZe3aVF+ps=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RbO+/PvU6V6j1gcHE2xw9cAAXns6eySR9qWEiuhJ7/iVwSC/rivxdIDLTJl3WIno+
	 wGrydYCQVb06zeDUOe/sn2VMDP1qI1D8c9qnwbGblPMYQ09Ttrow1exEQOG1wy9pFK
	 mPiU+A7v+3cs4ZqBgv9UvdMfSoXeKcizcx2GhXgk=
Date: Wed, 26 Nov 2025 08:47:33 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027279/a7a5a3-000000@github.com>
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

  Branch: refs/heads/1027279
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
