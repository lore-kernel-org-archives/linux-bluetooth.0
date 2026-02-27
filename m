Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5145038
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772192977; cv=none; b=jrYzqkDWAZmFFirgUK7to37LJ9kGDoM/uIx3PyrQm8X9LsnlTGbHbtAnepi0n+9J3YF+vuXSFuvzbU22tAZ8Vi+bvXXqd3ZvT8Krwou8VlnlDRHUiX5aSgUKMfFh+NOp1eLaJ7onSGydlLu1uXQK2ag8KdVrHlu+AwZt2aFW338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772192977; c=relaxed/simple;
	bh=8kVucih0Hd62EWYP+M6fnF7I/S9VsK8Svqr9gES/Dz4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CfvnsF1WEDu5M5bY9QiiJUaEogqaDKGW3SUllP76cg4lbPa+2zvfpS+Vv9FKdo7qmfv5ryKhEL9OoTyIoSUOXskaeJz6Emsi8iMrC+uJZHTXo9l5LwwnntbUYEys3bE9zvEDKLCQDLO8R+1JXcredxrWkntUGJehoDNjNKVfMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ipX4IL0e; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ipX4IL0e"
Received: from github.com (hubbernetes-node-4d31d62.va3-iad.github.net [10.48.204.50])
	by smtp.github.com (Postfix) with ESMTPA id 392E73C05E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 03:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772192975;
	bh=Ml9V1wcdXMw6+UuTgGFDaGL8eja7l72Bp+BjpB3AAxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ipX4IL0e1B4D2hpL6l+9xvuVfmH0/tpwLyqb2qlIHbypz+YNLiK4Ri2PuNrzVk5Oy
	 kn4hDf0K5rz0obngfSvXegEgcIAbYQ1a3zzlEc4jtdfPmv/gq9LdH+IzafHJ7G/Qjs
	 rs6LuesCfMd02IaAXuU5xRP6G3p+/42PTDMAmrLg=
Date: Fri, 27 Feb 2026 03:49:35 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1058931/000000-ee344c@github.com>
Subject: [bluez/bluez] c76f48: Revert "shared/shell: Don't init input for
 non-int...
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

  Branch: refs/heads/1058931
  Home:   https://github.com/bluez/bluez
  Commit: c76f48036c5b7040021a7fbd4452e96d68e34d06
      https://github.com/bluez/bluez/commit/c76f48036c5b7040021a7fbd4452e96d68e34d06
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  Revert "shared/shell: Don't init input for non-interactive shells"

This reverts commit e73bf582dae60356641a32fc27ae03d359ec4c47.

The fix caused "bluetoothctl list" to not output any text, breaking
a lot of existing scripts.

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2440346


  Commit: ee344cda63707c83ef60d4eb521d77f021904a4f
      https://github.com/bluez/bluez/commit/ee344cda63707c83ef60d4eb521d77f021904a4f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  tools: Work-around broken stdin handling in home-made mainloop

bluetoothd has 3 mainloop implementations, one relying on ell, one
relying on glib, and another home-made.

The home-made mainloop handler use epoll() without any fallbacks, and
will hang if one tries to epoll() an stdin that redirects from
/dev/null.

Closes: https://github.com/bluez/bluez/issues/700


Compare: https://github.com/bluez/bluez/compare/c76f48036c5b%5E...ee344cda6370

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
