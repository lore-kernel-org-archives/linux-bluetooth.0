Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F33334385
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599145; cv=none; b=ADcB8KEp8vYRY7KXkXkJe2fVj+yspz6xpRT6Qmwx4k243U4815dI93t3TGgqVg5IAT4VLVk1kVhDHjz9dAXCbxp/f8VXn+IH5fBoGVZswbRcrLDm24E+d6QzCCXC+X3r8TNdhk73Ye1zm3pF/L36e0IZYNEID5Al5DrefKlOL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599145; c=relaxed/simple;
	bh=t+V4l21KSAJSyUt9IAMqczn9wkvKCX/1/FHrICsp9DE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uo8LUUE1M5t+NWBENDxnpeB4ltyo6Q6KKK2IITagJSf5r4mAOOIQWcs9ZGI8KaHsAlvLhcQvZG2+R8JbjPHR2aGSJBsIld5mbhjt3hZ2UrDRa/NOZbtMMuNkaqY0kNcV44XQSC3lcHqvu8vRW27B+TScYyQALn1Ec+QU59qVyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VNV+i3u2; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VNV+i3u2"
Received: from github.com (hubbernetes-node-196615f.ac4-iad.github.net [10.52.166.56])
	by smtp.github.com (Postfix) with ESMTPA id 7ABE7210D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757599143;
	bh=6CktsSZsSc6BFjpLDhR+4FDkuG6OyShWOLmsCnm13Uk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VNV+i3u2ZJM9REpC2CBkajJ0ss47IXoCgZ1IeMoFH4m/4Ot8/MpO11fsyjiJB367P
	 oqXZ1UJbFyVVxBq4TGqm8LmBP+tSMCiLwOFzzA4vUb6orHSO18/3aGV9RG0W/c244s
	 GKNIkfQCCly6DkFfupTx7n5DLSnRjbdL4wUuvn1s=
Date: Thu, 11 Sep 2025 06:59:03 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001368/000000-f426c8@github.com>
Subject: [bluez/bluez] f426c8: audio: Add support for specific error codes for
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

  Branch: refs/heads/1001368
  Home:   https://github.com/bluez/bluez
  Commit: f426c810fcd8a82d67ab7a39f256c6ed4f4382ea
      https://github.com/bluez/bluez/commit/f426c810fcd8a82d67ab7a39f256c=
6ed4f4382ea
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/avdtp.c
    M profiles/audio/media.c
    M src/error.h

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



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
