Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3D3C98BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718602; cv=none; b=onDP7W3xvziSL9+bzplXJlMQIVHYYpmQnc4CEpTfQ78PUN7oMd6muMhAKl6ZRIzg+BRjTBX3Kgqi5NrFGwT9xW+tbglwc/mSImLPkVkY5wUljw1FQpR0P2rUJAy1XHxzrtY2EBO3XPWN9sSASqMy08UQco2vFWTg2qsdN4Lgp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718602; c=relaxed/simple;
	bh=Hu9dzVLS/8uv9KqHRJI6FU3fKre+CALRCDrC0nzzoaY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TPqzpkXWRdXhb4Xh7bd96uMMB9swpNGOSp63ie3KwISFVTMoMk9XuJCTmHebWDqW1FpJxHDueufgPTaWGxGLPzxCCTs745a3cyC0URvEQaXCMK4MnXsInxhjtDMnHHyLpPt0KKhI6uPOCHvtiYWF0JoP2sUfy3KZ1atqh5Jo7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a0E6SXcD; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a0E6SXcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786718599;
	bh=MSuvqu2PxO8Ro+WZYYIiAzqcrOe1/9cuLsHFWlL/PnQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a0E6SXcDe7yfesTUFWnJpa7Pu7bVaJemdJRljt9o6f+NbRDfiCn154WLjg7r8cnP0
	 fOta78OeSMwsla0I/44cS1g7qmhHM627Py0w01LmhvFJxmDUiw2hw4Nc1OIZMcdEbv
	 flds5YdxB1vWP72ILnkJLPjg7B8R6ytH1Rq9eWts=
Received: from github.com (hubbernetes-node-396c2c2.va3-iad.github.net [10.48.84.30])
	by smtp.github.com (Postfix) with ESMTPA id BF734341244
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 07:43:19 -0700 (PDT)
Date: Fri, 14 Aug 2026 07:43:19 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146125/000000-61b2d3@github.com>
Subject: [bluez/bluez] 61b2d3: avrcp: Fix Out-of-Bounds Read in AVRCP
 GetFolderIt...
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

  Branch: refs/heads/1146125
  Home:   https://github.com/bluez/bluez
  Commit: 61b2d375a947505bc631618cec5dd82a67319eae
      https://github.com/bluez/bluez/commit/61b2d375a947505bc631618cec5dd82a67319eae
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

If the "Displayable Name Length" is much longer than the size of the PDU
packet we receive, then we might try to memcpy() past the end of the PDU
packet.

Be careful about clamping the name copying to the smallest of:
- length specified in the PDU
- left-over packet after the length field
- size of the string we'll copy it into

Reported-by: Elman Shahbazov <shahbazovelman97@gmail.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
