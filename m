Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B315746F
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614811; cv=none; b=Zo8B+Xwsdaud4eEty2ffi1nRLZbFecvDTXw9xtEgPngG9P/1QteP/bpy0/wpcjPvNIoU+5deQrNoQ3WL6FfC+tdtThtQB/XATGxKSLjlAgqKaMaZH72aDYnTtx+887GiJrTQfEVCrgJhOnDJr3hzrgKTy0LrwmGO253OcqXxdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614811; c=relaxed/simple;
	bh=K+mOyG5n359WUtlcc/i4+4ym2RMmwHPa7TAeJZhZSuA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Fcb72i1wkaEHyX2v/dpUUE6mEgdE9RyXfnXX9gPOxzNJ2q73F23JvGaq9pioc+MQy0YR2egthm4zV/aNlTlBd5TxOjfC4lW6Dw0uHQ5MBBYhoJuxhU4AnbIm6xe1LZLiKeW819lJkhE434rDK4eOmFcalZthA29crEvTZlCyFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JXy64V9j; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JXy64V9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776614809;
	bh=QpCRqK+bTTetsY5rad6Rw/41O5QFwCrv1wJNS4ycBzo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JXy64V9jHK7QfAEp0FBuGEjNTbI3fLvyLQcNpaKd/OECf89WYLbVdlBd+da++meeq
	 4d8ZgAsdN/xO3+9VmAN2COZRbwipAtW7ExLhLIOMsbttSS8HEfmgiOCWllAwqJXAOs
	 NjBbQPEVRSPS/AmPz220sEZxu+J1gvkv8o1Xpw7k=
Received: from github.com (hubbernetes-node-13fca81.ac4-iad.github.net [10.52.84.34])
	by smtp.github.com (Postfix) with ESMTPA id 8B6137810E2
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 09:06:49 -0700 (PDT)
Date: Sun, 19 Apr 2026 09:06:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069971/843d17-000000@github.com>
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

  Branch: refs/heads/1069971
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
