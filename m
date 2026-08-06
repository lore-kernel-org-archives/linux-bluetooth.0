Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9A473C72
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030092; cv=none; b=t7QrasM1S/7G7DiDs25lFwQm2yiU2+RsOz+/ib54cYA/bTTnv1SHpNxcMgoyDfAM/QTkfQXpveZVc7WlzfeCq7rhN3DXb0REZAMasdSTVpzENMkk4bECWgcLV2YOMQdTWbfyDy54lRLL4rTJQp7dS0anSrLqdfl4i4PqNXeXQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030092; c=relaxed/simple;
	bh=95DaNfAhA3/tLQnNcvOnfKYW9RDEoNRgiz1XwzmRXhE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VGHe6cSIirci1RRQELQPeKhexpBDBYBIlKFdjvHtN/oSxEXggyThMxFpalEEMW8Bf7ABP5pQ138wbkVgGSWMvfFYjRzUVKEu0QmwHaQhZyE2ljTefDZ4MzThFkfNO1s4epRvR2TTZ73/XHlE7lagw6/tlnK3YX5O2o76tl/0VQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mVWqDoOV; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mVWqDoOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786030090;
	bh=EwgAqaInCpXubz4wnKPoLct5IMwyZibpRBF/znNYj2U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mVWqDoOVcDXnHqgGK19Wx3RIkBAB9QqiNkyTIuoBa9EOOKRbtkNizwgbH3FQNdi+8
	 8CPgPi3D2V7MqnmBhQriL4+sdZMWrwC7/reH/tXBU+jl4kZb8P00ok8xH0rbbUyi44
	 4scwFPcAF44xflvSkoDg1Wa0qzQ9ZFxtg0UsLa/E=
Received: from github.com (hubbernetes-node-cb7e49d.va3-iad.github.net [10.48.75.53])
	by smtp.github.com (Postfix) with ESMTPA id 05C3E341410
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 08:28:10 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:28:10 -0700
From: Elman Shahbazov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1141524/000000-2de22a@github.com>
Subject: [bluez/bluez] 2e3a31: unit: Remove Android avrcp.c dead-code
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

  Branch: refs/heads/1141524
  Home:   https://github.com/bluez/bluez
  Commit: 2e3a31fb926733808029f8968ce6fd569f51e9be
      https://github.com/bluez/bluez/commit/2e3a31fb926733808029f8968ce6fd569f51e9be
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-06 (Thu, 06 Aug 2026)

  Changed paths:
    R unit/avrcp.c
    R unit/avrcp.h

  Log Message:
  -----------
  unit: Remove Android avrcp.c dead-code

This code isn't referenced anywhere, and seems to have been part of the
Android support in BlueZ, remove it now that Android support has been
removed.


  Commit: 6834116004fc0596efae51578dde70517d714110
      https://github.com/bluez/bluez/commit/6834116004fc0596efae51578dde70517d714110
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-06 (Thu, 06 Aug 2026)

  Changed paths:
    M Makefile.am
    R unit/avrcp-lib.c
    R unit/avrcp-lib.h
    R unit/test-avrcp.c

  Log Message:
  -----------
  unit: Remove left-over test-avrcp Android test

This test was supposed to exercise the avrcp-lib from the Android
backend, but that backend was removed, and the library moved into
the unit/ directory.

The tests provide 0% coverage towards profiles/audio so they're just
dead code we should remove.


  Commit: 2ea8323b03de8cb8842235a5ec6b515bb4df5056
      https://github.com/bluez/bluez/commit/2ea8323b03de8cb8842235a5ec6b515bb4df5056
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-06 (Thu, 06 Aug 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/audio/avrcp-parse.c
    A profiles/audio/avrcp-parse.h
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Split off name parsing from parse_*_element()

This will allow us to use the name extraction code in
parse_media_element() and parse_folder_element() separately, such
as in tests.


  Commit: 7f7331df9262897db521401f9047c9d259535209
      https://github.com/bluez/bluez/commit/7f7331df9262897db521401f9047c9d259535209
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-06 (Thu, 06 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/test-avrcp.c

  Log Message:
  -----------
  unit: Adapt poc_*_oob.c test into a new test

Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.

Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>


  Commit: 2de22a864b8a6eecd94ea0d06b9b204f377a7f90
      https://github.com/bluez/bluez/commit/2de22a864b8a6eecd94ea0d06b9b204f377a7f90
  Author: Elman Shahbazov <shahbazovelman97@gmail.com>
  Date:   2026-08-06 (Thu, 06 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp-parse.c

  Log Message:
  -----------
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

Co-Authored-by: Bastien Nocera <hadess@hadess.net>


Compare: https://github.com/bluez/bluez/compare/2e3a31fb9267%5E...2de22a864b8a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
