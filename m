Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD030BBA5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506724; cv=none; b=A7XBbPTVSOTCRx6L3B0i8zTdoL7v6K68ntIcTjE5OBGXMCSxMRwunviLLx8VbAcgyy8UJVcE/fL0jnavMnZU6dSQ4AkF6hhSXMojZMMhPvDwChyzqhUF+vq6Q50XLwx/srJdDAYQ3rza7RDIQXClqsrc8AfxSarEtG+1RvNSNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506724; c=relaxed/simple;
	bh=c7qwm6aEK2nIBSadiFwiX0b2eIrCTouLh0IYNmSfcno=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UGJhMPLdT5r22svf5H4itc9w50FPaIJ8LZyhDgVC6BrgXgfuTa3aD9WzF8NyUQLUqexnim/5SaGATXMC7s87GAXnacTHZijMuqEuMmtdUmHXBnHpT4zco7C+n4Qn6hGh33gg3LMPmMQSnFsCtjVLNfTXPKh+cs4Ce0NphrzaCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AOpEtp1g; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AOpEtp1g"
Received: from github.com (hubbernetes-node-6c4cf0f.ash1-iad.github.net [10.56.209.104])
	by smtp.github.com (Postfix) with ESMTPA id 8E6BB921297
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 01:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762506721;
	bh=k/pMEnRg3c6j8OxRqjrYt7YTkBuco8JVPah1mqBSAsU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AOpEtp1gU0jH88rATjiSzbLD/JemOkjJsW6RCvIzLTq6QBdTKbGZFX7MF6vK+ke55
	 8wzCEPdABLpkuTAhHWcQ9+WVb+5hXtznbIj5AOAuS8mE02NJpyVIdzyzYQif3uzPM8
	 cs7CbDWBQ53gTQLUGEzV/eeAq6FT4qOLY9hf1dlY=
Date: Fri, 07 Nov 2025 01:12:01 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020791/000000-cb6846@github.com>
Subject: [bluez/bluez] cb6846: avrcp: fix AVRCP_STATUS_INVALID_PARAM
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

  Branch: refs/heads/1020791
  Home:   https://github.com/bluez/bluez
  Commit: cb684625e35a538901c208e07011a57db9e372c9
      https://github.com/bluez/bluez/commit/cb684625e35a538901c208e07011a57db9e372c9
  Author: Pavel Bozhko <pvbozhko@salutedevices.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  avrcp: fix AVRCP_STATUS_INVALID_PARAM

The first AVRCP_EVENT_VOLUME_CHANGED event triggers
an AVRCP_STATUS_INVALID_PARAM response.

When pairing, the org.bluez.MediaTransport1 instance
may not have time to be created, but the org.bluez.Device1
instance has already been created.
avrcp_handle_register_notification receives an
AVRCP_EVENT_VOLUME_CHANGED event and
media_transport_get_device_volume will return a Volume
of -1 from the org.bluez.Device1 object, resulting in
an AVRCP_STATUS_INVALID_PARAM being sent to the audio source.
After receiving the first AVRCP_STATUS_INVALID_PARAM,
the Audio-Source will consider volume changes
from the Audio-Sink unsupported.
Relevant for all iPhone models as Audio Source.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
