Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1D1386DF
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252905; cv=none; b=r06hOm1bBtZQu8uiIuTpyuwGCn89brQM7NL6waNdS3Nbft5YZYB8B1YhivZ/UeYhlhI7wHOXa3s7ZO3w9MTNjv3sPuhz4P+QBC6kHTVCNog/hggwHH4x2xUqu2B47fWNs7VG9M7/+ELMKZYUvYXZGAFvKi21pGMFL+67TSGpqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252905; c=relaxed/simple;
	bh=66ATmBvv0aX5VoFhy96MKJxq5YWmiJaT2YfTSSrlQR4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aofZdazpI8jwTJw3u1kM2fcaVdeqhO3mu8MFqOAV4X4eXBWMZjTVFVO3HEcc9UXvIYf3YlsueDxMAqXrePUhK7Iyaec/caOkkc9eANjJ7ovQKCJFDe9qcfln1cWGhKgplcideVyt5I9+1D9rGI3f+7axdaT5N5MgDyOGbn58ZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kuFAOFBK; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kuFAOFBK"
Received: from github.com (hubbernetes-node-83f0fd2.ac4-iad.github.net [10.52.202.28])
	by smtp.github.com (Postfix) with ESMTPA id A2E8F5E12FF
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1724252902;
	bh=L+cCHFkzKAdVBNPtTFFiW67Z0E1aaqhA7Ug/H9F8N4E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kuFAOFBKJCA12hYF8riQx+eg2O70bWrRRqIOGOBCkqN+zxz6bIQyLbVXDQnUU3S7M
	 e5SLwNzIJ0Dr3F2aqMfwCL8VUb7H7TkEDu9VK9UBw7A4iDXKSQBBAo8nN0131hZTWL
	 3nZG87RLQrV91MquicdDmWxMaf14LCi5bb5H08PA=
Date: Wed, 21 Aug 2024 08:08:22 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2f3f63-a6ac17@github.com>
Subject: [bluez/bluez] 9746e5: bluetoothctl-endpoint.1: Update documentation
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 9746e59d114952de75e019115d79cf1092460357
      https://github.com/bluez/bluez/commit/9746e59d114952de75e019115d79c=
f1092460357
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-20 (Tue, 20 Aug 2024)

  Changed paths:
    M client/bluetoothctl-endpoint.rst

  Log Message:
  -----------
  bluetoothctl-endpoint.1: Update documentation

This updates the documentation for endpoint.presets command and also add
some examples of how to enter extra capabilities/configuration and
how to setup custom presets.


  Commit: a6ac17f0e3932d6b07ced87e41fe7a108fe55149
      https://github.com/bluez/bluez/commit/a6ac17f0e3932d6b07ced87e41fe7=
a108fe55149
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-08-21 (Wed, 21 Aug 2024)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix connection error message

When trying to connect to a phone which has removed the pairing, the
DBus error message is:
- if A2DP only is supported: br-connection-key-missing (EBADE)
- if HFP only is supported: br-connection-refused (ECONNREFUSED)
- if both are supported: br-connection-unknown, while the trace shows
  ECONNREFUSED in avdtp_connect_cb()

This patch allows to return the correct error message.


Compare: https://github.com/bluez/bluez/compare/2f3f63467d72...a6ac17f0e3=
93

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
