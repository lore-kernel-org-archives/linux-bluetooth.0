Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D23275870
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216970; cv=none; b=peqxwrhQYUV15MUXcTojEIhjTVFBVJcshJGizr5MEj9QTX/fbd6gSQ4SjOpdzOh3iAXPFTZCFneb0bpOR+LQcaodH+OM1FtfCyH5eanvwCzcnJWWdan925bYh0Yy6ZIY2JaHUfNVsKIlTWgHFQYsma4+BE0bH/UD5lC/iF1Bvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216970; c=relaxed/simple;
	bh=T4yiUFrlv4bruYAaUAwyuH0QVJQIxMk4v2hyglybE0c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UrwTUzqUl+DpZvsZvYtKztZ5f13ysvBY/IGInJf4UaN7KDLqVtpOlY8aSnyC6i9qfp1rbZYWOHkmfDawlpbNHt6A+Rwdu0/I8c/eYLOv/dRL8+FQBUTjYTKi+XWDciL9i0CbH8iLyjPLCCNKd8Vh/eECToDdDswZyDUtGLh48Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M/ffX8+S; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M/ffX8+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786216968;
	bh=iRR/mdvLZmU2CujztWhgMPKizYJkuJ3dlpZdb0PgtGE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M/ffX8+SmuxO37COzOvhLElqjxrV2YaN6zOZoSFLuTel3dXw8hk0WQGfh/uo5P8AQ
	 kKkEsqYsFzTbj+Od2/TqdYOqhSegrXDQsclsnfn+VGtvvCu6sCAnORRyFZz8lvs9FI
	 BHzmpKYBhX4LSfY+xsJIDr0vYo/g7A1ehCO4fvWY=
Received: from github.com (hubbernetes-node-b44799f.ac4-iad.github.net [10.52.12.27])
	by smtp.github.com (Postfix) with ESMTPA id 7F7AEA07F0
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 12:22:48 -0700 (PDT)
Date: Sat, 08 Aug 2026 12:22:48 -0700
From: z4pdy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142766/000000-306156@github.com>
Subject: [bluez/bluez] 306156: client: Avoid scan prompt when discovery is
 alread...
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

  Branch: refs/heads/1142766
  Home:   https://github.com/bluez/bluez
  Commit: 3061567c4084e3eecfec2e59d1c0f2f1de4d6f7a
      https://github.com/bluez/bluez/commit/3061567c4084e3eecfec2e59d1c0f2f1de4d6f7a
  Author: z4pdy <305461556+z4pdy@users.noreply.github.com>
  Date:   2026-08-08 (Sat, 08 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Avoid scan prompt when discovery is already active

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
