Received: from o6.sgmail.github.com (o6.sgmail.github.com [192.254.113.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B132DDD12
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356082; cv=none; b=IpbXQCnF7GI1PTqY4+R1D1EKxk1PwttUHyn7ghVRzB6dB1b7SFzxyYUbfrY8UqcKDvIg6tXm+5IJSnpwgmf3c9apTgITGinMVmnuylE7CvRh8FSkU7XLk6XeeYBms4/eeW0JKFK7RPTD6GlOhSJQQXYfxkt0MjiKGYjNG34SK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356082; c=relaxed/simple;
	bh=onYpFdsu1rcb103zuMSnEzkYsaOlZkxlMw5SsIvTNos=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=EaJauc6a6mNaQqHfe5NyIaUPszcNoGvyW4/gBvFObskPW1HC3/ZI/+odw8k1+1H/n4gpfZmAjkCbVr6goB3v8iUbK0j4TJjCCwrXabSd3+oWmKk7YLXSdiL0P97V6sjMI5WAc8dT4n0cngU18VST3z5hMTh6+hXqdTu3incc3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qc+vKz3m; arc=none smtp.client-ip=192.254.113.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qc+vKz3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=dCoM5gaFRFvLhNmHNO0av1uQV4GUI7Jg5vzeePQfc3U=;
	b=Qc+vKz3mr8b/N2c5tHVGoD8lBRv/b9PCWF1HBSZmlF6KwOLdBqTrLOWfHjpO4EG9+6xQ
	ss7wcsaHKwrYY0WQ+sMc4NIMXLsrzdNvk/RF17lYjE7NXJEyDjTYNGdBuK5DjrtO4DKIhO
	GnI65eM2yEaF3O+oFRRVP9ZO7JFhq8UBE=
Received: by recvd-7974cd866d-gr5kb with SMTP id recvd-7974cd866d-gr5kb-1-6808052F-40
	2025-04-22 21:07:59.570508347 +0000 UTC m=+1205997.563383716
Received: from out-25.smtp.github.com (unknown)
	by geopod-ismtpd-13 (SG)
	with ESMTP id dvTcu51PTASad0ctmt7zSg
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 22 Apr 2025 21:07:59.550 +0000 (UTC)
Received: from github.com (hubbernetes-node-2e89563.ash1-iad.github.net [10.56.158.27])
	by smtp.github.com (Postfix) with ESMTPA id CF072140932
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 14:07:51 -0700 (PDT)
Date: Tue, 22 Apr 2025 21:07:59 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/e3c5f6-3616d5@github.com>
Subject: [bluez/bluez] 73ae3f: shared/gatt-db: fix crash on bad attribute
 index i...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIApL3VVXt6tXh?=
 =?us-ascii?Q?5lcJMMyH6I93VelFlHKUGjfRZO4Ao4wdDn8U5lS?=
 =?us-ascii?Q?GN2z8xgA+ZiCEd0yIRKmyFxQs9LDg1I2xzMxeCr?=
 =?us-ascii?Q?kOelyou0qbfktLTIaGOY83FVogPwZJ6HZcTRTA2?=
 =?us-ascii?Q?Nmr7jMMnbXtAlgZx81Q+o5RscHaOYVj2M9EgFO7?=
 =?us-ascii?Q?QMz1VIMKczoIqw+21pKA4pjBvw=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 73ae3fb93d271c1a3536a7a280b911808dc5c9c4
      https://github.com/bluez/bluez/commit/73ae3fb93d271c1a3536a7a280b911808dc5c9c4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-21 (Mon, 21 Apr 2025)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: fix crash on bad attribute index in get_char_data

Fix AddressSanitizer: heap-buffer-overflow when index == 0.


  Commit: 578a6fd688b0b90b59ed15aca13d2ae87e91b0a6
      https://github.com/bluez/bluez/commit/578a6fd688b0b90b59ed15aca13d2ae87e91b0a6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-21 (Mon, 21 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix crash when removing PAC

When PAC is removed, streams need to go through RELEASING flow, which in
some cases is not immediate. Access to stream->lpac is UAF during this
time, e.g. in profiles/audio/bap.c:bap_find_setup_by_stream

Allow stream->lpac == NULL. This should occur only if stream is
RELEASING.

When releasing streams due to removed PAC, do RELEASING->IDLE as we
can't cache config then.


  Commit: d5ef57305b7943201e7856a8a4470985781e5100
      https://github.com/bluez/bluez/commit/d5ef57305b7943201e7856a8a4470985781e5100
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-21 (Mon, 21 Apr 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: don't track streams without setup except for ucast server

data->streams is is used for determining which streams can connect to
listening socket. This stream list is specific to ucast server.

Rename the variable to data->server_streams, and only put ucast server
streams there.

Fixes data->streams accumulating dead stream pointers.


  Commit: 99deeea86f156d4ab89a3f1edc35f6d1c51d56b6
      https://github.com/bluez/bluez/commit/99deeea86f156d4ab89a3f1edc35f6d1c51d56b6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-21 (Mon, 21 Apr 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Decode Broadcast Name

This adds support for decoding Broadcast Name:

> HCI Event: LE Meta Event (0x3e) plen 57
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0000
            Props: 0x0000
            Data status: Complete
          Address type: Random (0x01)
          Address: XX:XX:XX:XX:XX:XX (Non-Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: LE 2M
          SID: 0x02
          TX power: 127 dBm
          RSSI: -67 dBm (0xbd)
          Periodic advertising interval: 180.00 msec (0x0090)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1f
        06 16 52 18 2f 92 f3 05 16 56 18 04 00 11 30 4c  ..R./....V....0L
        75 69 7a 27 73 20 53 32 33 20 55 6c 74 72 61     uiz's S23 Ultra
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 15962671 (0xf3922f)
        Service Data: Public Broadcast Announcement (0x1856)
          Data[2]: 0400
        Broadcast Name: Luiz's S23 Ultra


  Commit: e4c1d03ef73c442b3d2414669ed96500cc3227d7
      https://github.com/bluez/bluez/commit/e4c1d03ef73c442b3d2414669ed96500cc3227d7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-21 (Mon, 21 Apr 2025)

  Changed paths:
    M src/eir.c
    M src/eir.h

  Log Message:
  -----------
  eir: Use Broadcast Name as Device.Name

This makes use of Broadcast Name advertising data field as device name
so it can be identified by upper layer.


  Commit: 3616d514faddcbeb5c222d881007af5903796a29
      https://github.com/bluez/bluez/commit/3616d514faddcbeb5c222d881007af5903796a29
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-22 (Tue, 22 Apr 2025)

  Changed paths:
    A .github/workflows/ci.yml

  Log Message:
  -----------
  workflows: Add CI action

This adds CI action which was previously under BlueZTestBot.


Compare: https://github.com/bluez/bluez/compare/e3c5f6050a8b...3616d514fadd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
