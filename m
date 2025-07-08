Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8392E424A
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001069; cv=none; b=vGGc95Pw44jCHiUnhOI9gmiFmdXsH/Lp6/lSQxKP+WLCrS6naxm+GwMQpAbqIAMF/RaKQrqcPl8czHvTf+gZ5eBQqbeU39tUbuP7JFEGV7QMalVDW8IreZYUp24Ofe3Cd4skG8NJhCKdz/36VRwYtR8+nJlsTohTjz7PwTZ9hIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001069; c=relaxed/simple;
	bh=Ux9BAr6v7NWTTA4N4kBxlJfPuzF6DzSCiQFoOq6b/yU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a70c4Vhz4Bhd4rrIzT3MeO2v6xJHwPcdg6MtRq6ZUjKsZFTqgOeVOqPRA/JsWsg8DRMtmsYWbNRd7l5Ynl+qp3kJMzBJjU/kUMM4MMUM5C8x768AeVlFWwwnPeM+tzdHgDN1rF0NFt26BrACsjNxuV4x4s0xeHPyMJSsZW+9i2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ovjvtpn2; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ovjvtpn2"
Received: from github.com (hubbernetes-node-cbe86b7.va3-iad.github.net [10.48.157.10])
	by smtp.github.com (Postfix) with ESMTPA id 159124E03E1
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752001067;
	bh=2apbHjvrIsEYxxUFdQHKM4h0gRKkwtNz0PLVONr21fY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ovjvtpn2KtKBqbSwMboiqzmDZr80PZnDzOL+yICT76+nPksr3haZW2a7kamqA32Sl
	 6Z8SbEwjgWvGpI+Nb/9P8CdEbhO03DvUhtgHv2zILGG2g7CUUtjo0GjrORW1XMMwMB
	 tynPFCuatWg239pWGrbq3ncCOoDj2UOg/caM4RJM=
Date: Tue, 08 Jul 2025 11:57:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/004518-9ed79e@github.com>
Subject: [bluez/bluez] 9ed79e: shared/shell: Fix not running pre_run on
 MODE_NON_...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 9ed79eedc075436bc865d5bf5c3c01813bda2060
      https://github.com/bluez/bluez/commit/9ed79eedc075436bc865d5bf5c3c01813bda2060
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE

If a command is given to be run in non-interactive mode the code would
not attempt to execute .pre_run first since some (sub)menus requires that
in order to properly initialize things.

Fixes: https://github.com/bluez/bluez/issues/1394
Fixes: https://github.com/bluez/bluez/issues/1317



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
