Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C3257AFB
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760165; cv=none; b=gGwbsn4xYoq2iWQRikzw/Yu716qMRf3Iel/dijpKulUiEm4O+1X4SEG8AuzJjpnqi0BLPSOmIGcnuASbAliQrAKfk3VZSff5D0Fuepkv8eZ4bBVG+8ZC65SH0MhDLVtvC0KPwnM8KsN50WCJYqjKUmsnEhAdaOjgvoK8iM/9+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760165; c=relaxed/simple;
	bh=/Y9FkTw7JOVxQ1Yk/KCAHszFeoa/FePOGFjaYLJA5lQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qIo+uH9pCxbhEvzf/Nm4fB0IEkygIlm8DmL82fA6zeNelgl7G3l0IOH5gjjjVKDHiuRzY9QxS5k6tgzS1oShsDMtIwVr6hbmOxvRygsZ1FGM6w0VMexp3ASb/O8i3QEdFwYGSKQVL1TBmb8MLQdekvXtzXEsQ9gU2xUo47fJ2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bRAMl52e; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bRAMl52e"
Received: from github.com (hubbernetes-node-a49e308.va3-iad.github.net [10.48.207.77])
	by smtp.github.com (Postfix) with ESMTPA id 4A7DBE096C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747760163;
	bh=I2mo6tuQuPtBobZe2dLyoszO4LeTeIYCzn5m6RD+tDA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bRAMl52e+fepVVgsPG8FrpJzdL8YnJU/6o9wVRVhiDjH5YTx6bqz6xwilYdyEXCH6
	 8ZqfQYqD+r5PHPuugbwkEfK7RvVdSKT5J4kIGkOH9SLbDQTv9PmSw25xdmDgU9s81i
	 jFvKp0az0T4w0eBZjjEfiIVnoP0nKnimdaxfUYHM=
Date: Tue, 20 May 2025 09:56:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964261/a651f6-000000@github.com>
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

  Branch: refs/heads/964261
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
