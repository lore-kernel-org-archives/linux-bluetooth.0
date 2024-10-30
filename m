Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E41EB9F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295689; cv=none; b=DcLDlTFNBl98XTeVelIjPzr6N/g3JF7UXmTC1x9UUUvx9LVmmPn+5hSnrcay0VdsNjYb7saO51rQ8nS2FIszgqpSt/HqiK5UTVV0Nv3Sv0F3bbiOkVYY+wfV00p9+KII1AyasV/aaHhpgTYcGrIiMseksUDdJHwGFGxummoEd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295689; c=relaxed/simple;
	bh=1nLuoduLorp22X0NqZdt5Bq2kfjMrJTbXVIJ/DbrSQY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s5ztJnAjFg0oi8tkj7OHs0qZv4Yn/Bcx3uRG/WZ39y3Wpg6raa5ZAF4Z8pqagbIXbfOm4Otugnki2i8Q5HFThJJkkZihEOXKP/LfD1EDmhVyKiHmDmTVwcSJIwx6QgRzdDzVi8ONfuqFLTnuhbUsnWmefpp19L7S4a3QO2S1C4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NNfQ4axS; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NNfQ4axS"
Received: from github.com (hubbernetes-node-09ef7e6.ash1-iad.github.net [10.56.157.34])
	by smtp.github.com (Postfix) with ESMTPA id EF5EA14115B
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730295685;
	bh=M/co0xxm7tVWIkT+KEXSMCKqjSAdRVlzqLC4Z+FwXBA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NNfQ4axSoTSsPnkk4vAtEx8qOtAAxeng88AsEdmvqeEK27c6zF9LuD53O9aW6wNZI
	 1WWBwr2fVjneGilWELJTC5B/HnUf/tkCUGLZflvt5q+w92Lq51xpT62INEDZ4EzUdR
	 6ZVlpqgJLuzDdVLVxGcLUJ9eilYSsOaisvGGq7LQ=
Date: Wed, 30 Oct 2024 06:41:25 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6d55c7-9e0bc3@github.com>
Subject: [bluez/bluez] 0cd34b: gdbus: Add g_dbus_pending_property_get_sender
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
  Commit: 0cd34b18158754ca20b482f2478a52233fbd0d16
      https://github.com/bluez/bluez/commit/0cd34b18158754ca20b482f2478a5=
2233fbd0d16
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-10-29 (Tue, 29 Oct 2024)

  Changed paths:
    M gdbus/gdbus.h
    M gdbus/object.c

  Log Message:
  -----------
  gdbus: Add g_dbus_pending_property_get_sender

This function allows to retrieve D-Bus message sender name in a property
setter callback. Message sender name might be required to limit write
access to authorized clients only.


  Commit: 6847b38ea3c943023a1d743dec4bbaad5c78aeb0
      https://github.com/bluez/bluez/commit/6847b38ea3c943023a1d743dec4bb=
aad5c78aeb0
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-10-29 (Tue, 29 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Allow to set A2DP transport delay property

In order to properly synchronize audio/video playback it is required
to report audio delay to the A2DP source. This commit allows connected
media application to update the Delay property of the A2DP transport
which will inform remote source about the playback delay.

In case when the transport is not acquired, everyone is allowed to set
the delay. However, when the transport is acquired only the owner can
modify the delay. This restriction is here to prevent interference
caused by 3rd party actors.

The functionality was tested by streaming audio between two hosts
running BlueZ Bluetooth stack.


  Commit: e2e439156ae516965b29a68fccc78e2992b4d4d5
      https://github.com/bluez/bluez/commit/e2e439156ae516965b29a68fccc78=
e2992b4d4d5
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-10-29 (Tue, 29 Oct 2024)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  org.bluez.MediaTransport: Document policy for setting transport delay


  Commit: cbd68596121b7de0bfcab7145a4cdd089623971d
      https://github.com/bluez/bluez/commit/cbd68596121b7de0bfcab7145a4cd=
d089623971d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-30 (Wed, 30 Oct 2024)

  Changed paths:
    M gdbus/gdbus.h
    M gdbus/object.c

  Log Message:
  -----------
  gdbus: Add g_dbus_set_debug

This adds g_dbus_set_debug which can be used to set a debug function to
be invoked on incoming/outgoing message.


  Commit: e062a44edd9f3f20bb13eb918ac7b8f963c45dab
      https://github.com/bluez/bluez/commit/e062a44edd9f3f20bb13eb918ac7b=
8f963c45dab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-30 (Wed, 30 Oct 2024)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Add call to g_dbus_set_debug

This adds a call to g_dbus_set_debug which enabled debugging of D-Bus
messages when dynamic debug is enabled for main.c:

bluetoothd[3672799]: [:1.38799:method_call] > org.bluez.Device1.Connect [=
#761]
bluetoothd[3672799]: [:1.38799:error] < org.bluez.Error.Failed [#761]


  Commit: 9e0bc3e63c924037fb483f3b1f08e5348399f8a2
      https://github.com/bluez/bluez/commit/9e0bc3e63c924037fb483f3b1f08e=
5348399f8a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-30 (Wed, 30 Oct 2024)

  Changed paths:
    M profiles/input/manager.c

  Log Message:
  -----------
  build: Fix missing include

This fixes the following build error:

profiles/input/manager.c:102:4: error: implicit declaration of function =E2=
=80=98free=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  102 |    free(uhid_enabled);
      |    ^~~~


Compare: https://github.com/bluez/bluez/compare/6d55c7d7fd0d...9e0bc3e63c=
92

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
