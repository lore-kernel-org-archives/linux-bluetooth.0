Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C634DCEE
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604561; cv=none; b=gu04XmkwRVXR1lPkOegzxRH1JO6xWKRBRekoJDV6WtaBx9/S5pTajoB45ixXAAsEPrbFVBx/foXxo5xsLMLPJVs8qt1P2UtVb2WRi8y6j2zgvrhXHGRAz1/40myCSWWCc73In8oR0KIzxrO9fkNyCzQEG+iQbHf78bYCIUojmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604561; c=relaxed/simple;
	bh=kz+vm3cz+cIYNQXKkD+s8qQc7SsoqakbdC13WXTSTxo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VYsFSp8NretKWINL2FLTzRUFcwVNEYu2HcIYr5kNzn/UQheKBf8F+dAfnJUhSO/zvYN7pjmpRQ5ZgHnPruCxbuFLRzBif2ieUPAZ0kcoxUt1cnGti9d0VZi97MeOgtKn6FIGPr34ynBVu1aazkeE63ejCRujiKjXE2FEqg3Ak+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S5QMohpD; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S5QMohpD"
Received: from github.com (hubbernetes-node-05b67ac.ac4-iad.github.net [10.52.221.34])
	by smtp.github.com (Postfix) with ESMTPA id F2C5B20BC8
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757604557;
	bh=/CV4BybvrqLgDrB5zU/IWjHTBccUgk0LR0XPy4mlbtM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S5QMohpDaiXplmOV3z7aeCwRHrKWfx325k3QiscNqdKLiRFFmifwBjbIyhdqDrs65
	 SRJ5eZ/JU2G2MAv/lgOYxVP12852+1BRSbbZJCChnkDY4eKrYAQxbm+i8GXZjKPRxp
	 DvUCyxVRFwv3Dr5VshZu3p10l61Ts5tVCW/+3J2Q=
Date: Thu, 11 Sep 2025 08:29:17 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001420/000000-bc59c8@github.com>
Subject: [bluez/bluez] 0bb304: audio: Add support for specific error codes for
 A2...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1001420
  Home:   https://github.com/bluez/bluez
  Commit: 0bb3040a52bd312582eab35b267c24e8677c5e86
      https://github.com/bluez/bluez/commit/0bb3040a52bd312582eab35b267c2=
4e8677c5e86
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/avdtp.c
    M profiles/audio/media.c

  Log Message:
  -----------
  audio: Add support for specific error codes for A2DP configuration

The A2DP specification defines error codes that shall be used if
the codec capabilities contain improper settings. This change allows
clients to trigger the sending of these specific error codes by
returning the corresponding error messages from
MediaEndpoint1.SetConfiguration.

This update is fully backwards compatible: clients passing other error
messages will continue to receive the default error code as before. On
older BlueZ versions, these new errors will also result in the default
error code, enabling clients to implement support for the new errors
without breaking compatibility.

This change enables passing A2DP/SNK/AVP/* and A2DP/SRC/AVP/*
qualification tests.


  Commit: bc59c8df6d48162a9cdd156332e897f339b488b1
      https://github.com/bluez/bluez/commit/bc59c8df6d48162a9cdd156332e89=
7f339b488b1
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: Document error codes for A2DP MediaEndpoints


Compare: https://github.com/bluez/bluez/compare/0bb3040a52bd%5E...bc59c8d=
f6d48

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
