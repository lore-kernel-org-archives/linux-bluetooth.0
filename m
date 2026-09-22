Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB05515987
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092009; cv=none; b=dflhq33g7KKAU3w0SOiVUAXTg7u5s+l/X2eRek6HB9ul4BQ1kbyBOKQoUvluku7P6WlhxK7dxY50X+ZWWYv+taXaasq09ci1qK3qpUTZLVxakdiIuLxOOrkGUQHVhu3LuyM3EXfUQAPoLu9j7zA91EJbaRJOktTA/WYvchvi4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092009; c=relaxed/simple;
	bh=wl5EIlSsUowJkWdp9UdTD8pSnziGcbfp2idjuOHbetA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qWf3OzxQToa/O3Q/zZ5EsMPhoHQaMZLaVIQ4Gg6tybmTF1snT/YTAI005PaYr7LH51wbrFvnRQD3g8vRyvWg+z8MQSXnnsf/sZhf679e2yf8qCpUnHuV8pginGwToB/+nc6Ss0O6LU78uYhJZvwRnT6c/l3ERKomQC1+NjH7Zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E0Dndrrk; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E0Dndrrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790092000;
	bh=GCYGjeF9HyHjqaYj0+QxT0MpjQEgMmYmvyDNAogeMpo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E0DndrrkIF7GWAXx0ljuW5k0Je5DDDfSKg23SldKl0Axfl3QuV2a+24ARY3PktaPa
	 qAcJbuF+IxSvrjDJLqTwp0Zt4CmGiR6cirNjiXNAoaqm8/emrdUn56LAiHMU20eTW+
	 gylLWeeibM04r+LBzZ+5JyrdsKFIOG0O3e5MlXIk=
Received: from github.com (hubbernetes-node-af901b6.va3-iad.github.net [10.48.76.51])
	by smtp.github.com (Postfix) with ESMTPA id 16BE034135E
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 08:46:40 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:46:40 -0700
From: Pavel Bozhko <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1171436/000000-8d2010@github.com>
Subject: [bluez/bluez] 8d2010: audio/avrcp: Add AvrcpVersion config option
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

  Branch: refs/heads/1171436
  Home:   https://github.com/bluez/bluez
  Commit: 8d20107def8c7df09ba05244931dd98711c0d7b3
      https://github.com/bluez/bluez/commit/8d20107def8c7df09ba05244931dd98711c0d7b3
  Author: Pavel Bozhko <pvbozhko@salutedevices.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  audio/avrcp: Add AvrcpVersion config option

Some devices advertise AVRCP 1.3 in SDP but still support absolute
volume (SetAbsoluteVolume and EVENT_VOLUME_CHANGED), which the
specification introduced in version 1.4.  Examples include certain
TVs such as LG webOS UM7450PLA and Xiaomi Mi TV 4A 43 when acting
as the audio source.

Add an AvrcpVersion option under [AVRCP] and apply it to the target
in target_init(), so the version check in avrcp_volume_supported()
can succeed for such peers.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
