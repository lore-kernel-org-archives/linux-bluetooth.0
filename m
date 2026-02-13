Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78327FB18
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010986; cv=none; b=qFB/XTPhjoktVhKjkDbC0A0OceqcUDKJ1fOp9mdHB/vf3e/DpaOZ2hruT5gVRw+HIcHwiW7yt8AIl4cD9nKUXAN4gxXuU214gq9yV+xTsay3+Ws6v2U6pfzFuf4CNn8ICWQNf66UgCMc/Qu6S2ZXcuu9fskvtiG0zZYQx7IM2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010986; c=relaxed/simple;
	bh=DWu3VBiA6OBOPcN4CrQLivXsZMpo+KfGrJvjwbHrOjw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eOjTgFq4/7YLbGltqzMd2+Xy0wpZK15MXrIlshbGPcP4fAMJje0HtAcatXvYms9mk3vx1ddDKtpHuBIxuD8lq00GOlwRYa1Ev/VbgEIXAQ10OqqnEc0zdsNKPoMVMF7fQSun31sFpgVuUWJyuSma5+hzmIRw3Mm0qh+wmHODHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HC3KM+Sb; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HC3KM+Sb"
Received: from github.com (hubbernetes-node-d8cbee8.va3-iad.github.net [10.48.86.29])
	by smtp.github.com (Postfix) with ESMTPA id C50EEE0BB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771010984;
	bh=rRO2j0MTM3dwk8RaO+4KEfYf6cpTYv2AOG6IclZjIVY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HC3KM+SbosxlByCNwpiruef7eLIjixEKx+hitmCOGvh3AyfTwT/ozW8VBJd9WL2vl
	 75qsTY8xh3TaLqM+0ZvbztZbWxmGRtFmXfMaQtPgc3r6PUu8XheVOQinosjrFnt3j/
	 +ld/lLhhk8cobA8t++nclcR62lRcnfDpEYLKezEA=
Date: Fri, 13 Feb 2026 11:29:44 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-dualshock4-random-inputs/81adcd-3fb5ad@github.com>
Subject: [bluez/bluez] 3fb5ad: input: Add counter and warning for continuation
 fr...
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

  Branch: refs/heads/copilot/fix-dualshock4-random-inputs
  Home:   https://github.com/bluez/bluez
  Commit: 3fb5adb8979c18eebbede5b31c71153514d8b91d
      https://github.com/bluez/bluez/commit/3fb5adb8979c18eebbede5b31c71153514d8b91d
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Add counter and warning for continuation frames

Add tracking and warning mechanism for HIDP_TRANS_DATC frames:
- Counter tracks total continuation frames per device
- First occurrence triggers a warning to alert users
- Subsequent frames only produce debug logs
- Helps diagnose devices that actually rely on continuation frames

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
