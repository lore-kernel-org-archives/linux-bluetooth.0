Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423F21129C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156089; cv=none; b=aJFXVp49snphkTVRJ0YHDpyfj2Ohx9ExkdU1tWmlam8mFpLCKKr0UmBTRjdVoTkMam61QuMZoGXYKtmdud6Q3kYkVKM0EC+3t4ZZseXNaDh3cQxZcXhb5bmdiTTFNijV+ZMkguNPGSEc/uzsSlfjW26PvUKeGCFO8qRGSEI7hXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156089; c=relaxed/simple;
	bh=zTH9LTwwRKuisfn2FWVYm8aOSpq+ry6yHNEi522rBEo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kSo408JzM7FHiKIHNsZf8SIsNKGpxuLsKBBv77/qwcUM8W+gtOUtk1MondVW3JZFhsJv2XvYLJbyVpj0eX3vnybfMBS3EAx8UjpHzvkJQt5nJjhoWbJOq4dd2eN8MZxZZpSINyfcg6csg7lzIT6Rgn6SkiNs/qSnzYDY2ZzLuIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GLGkGp7N; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GLGkGp7N"
Received: from github.com (hubbernetes-node-ecd4611.ac4-iad.github.net [10.52.130.41])
	by smtp.github.com (Postfix) with ESMTPA id 9DC5221278
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740156086;
	bh=Ff1eGGOJvfbR10IqjmJpDU3Phl6R9H04t0e46VZSrk8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GLGkGp7NmFBXtgENiBer9Z6YljwILVDot5VhCHm7P6k1ZDnRKY60scr8FHHFe37mh
	 POi9zWL+9CGGAZkuDUl7ImvGdqwuHzH+YpVPRAHqawCUXF3+Aay3DKmH7HPxmKBPaE
	 BeqHzzhSk7yS4UTL+EdEnYOrxDh/cCIVOgFG+EM4=
Date: Fri, 21 Feb 2025 08:41:26 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/65fbc4-fc7be1@github.com>
Subject: [bluez/bluez] 790a0c: bap: Do not clear user_data before detaching
 bt_bap
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
  Commit: 790a0c5d75ec98697edd5173236da49544cefc3e
      https://github.com/bluez/bluez/commit/790a0c5d75ec98697edd5173236da=
49544cefc3e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Do not clear user_data before detaching bt_bap

After detaching a bt_bap session, each plugin that registered a bap
detached callback will be notified. The bt_bap user data should be
set when calling these callbacks, so the bt_bap session can be
matched to the associated service and the cleanup is handled
accordingly.


  Commit: cfb233b4c6b3020627014a4fffbfe16e2db8e891
      https://github.com/bluez/bluez/commit/cfb233b4c6b3020627014a4fffbfe=
16e2db8e891
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Do not set adapter as bt_bap user_data

In case of a BAP Broadcast Source session, it is not necessary to set the=

adapter as bt_bap user data. Plus, setting it makes it confusing for
plugins to know the type of pointer to parse, distinguishing between
Broadcast Source sessions and other types of sessions that hold a service=

reference as user data.

For a BAP Broadcast Source, the bt_bap user data can remain unset, since
the session is not associated with any remote device/service.


  Commit: fefeb495dd227c7fb13d68cafe641183fdd05d47
      https://github.com/bluez/bluez/commit/fefeb495dd227c7fb13d68cafe641=
183fdd05d47
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Add checks for bap user data

This adds checks before parsing bt_bap user data in bap attached/detached=
,
to avoid accessing NULL pointers in case the user data has been cleared
or has not been set before attaching a BAP session.


  Commit: 1c4f5276723627a5844c92f8f23bfa552145939a
      https://github.com/bluez/bluez/commit/1c4f5276723627a5844c92f8f23bf=
a552145939a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M obexd/client/map.c

  Log Message:
  -----------
  obexd/client/map: Add SupportedTypes property to MessageAccess1

This lists the message types supported the remote MSE.
Possible values are: EMAIL, SMS_GSM, SMS_CDMA, MMS and IM.

Those values can be used as message type when sending a message
using PushMessage method.


  Commit: 41431caf8af3399385b27115977124847ae76489
      https://github.com/bluez/bluez/commit/41431caf8af3399385b2711597712=
4847ae76489
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M doc/org.bluez.obex.MessageAccess.rst

  Log Message:
  -----------
  doc: Add SupportedTypes property to MessageAccess1


  Commit: fc7be1e8677158796c321d03618df13cdca270b4
      https://github.com/bluez/bluez/commit/fc7be1e8677158796c321d03618df=
13cdca270b4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M tools/avtest.c

  Log Message:
  -----------
  tools/avtest: Add AAC configuration

The tests A2DP/SNK/AVP/BI-01-C, A2DP/SNK/AVP/BI-02-C,
A2DP/SNK/AVP/BI-05-C and  A2DP/SNK/AVP/BI-07-C expect the IUT to
provide an AAC configuration.

This can be used by adding '--aac' to the avtest command, e.g. for
A2DP/SNK/AVP/BI-01-C test:
 tools/avtest --aac --reject setconf --reject-code 214


Compare: https://github.com/bluez/bluez/compare/65fbc47143a5...fc7be1e867=
71

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
