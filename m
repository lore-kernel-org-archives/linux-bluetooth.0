Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAD3AE182
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619264; cv=none; b=YtANN9FZZH51TjmDIfj+2MpVIkPM8FJvWTHMl/t9A+el06s4qyRxByNy4L9bvAohP960bjbmhFXsznifL4MQJQEcoPTl1gTRZ6nMmQ01lvCas/gVIDb0GI7gH2iASooQ8e1ySsfTBQN8IfOL1mdS3BIJFqp+RB4PhHDoZ/huCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619264; c=relaxed/simple;
	bh=owqcCt0ChlKbbpJ7nfZJEmjqAnuMjSMrGU1B0sO7iuA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Jdqdo2uuSRUWc22djqCTwA7GJRuu3v3/D8a/Qd3zG1YbLnuvHmNKfLOl2ox5HIQZ2E7FIRRoBYs6UVQTJKWqw7rSk2MN/aTBz2OAipYKZ8natwja1eFQuJ/8Z1N/wPcvwuKOCdpZ7AriyhL4yRmnEJv/ofBhX5AkncXr/qcztSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cQ1TUnMR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cQ1TUnMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778619262;
	bh=NIZlFdrkMMx7yPkSN35ROCZg+yOk/lwhSBY6Svo06S8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cQ1TUnMRxMMBBP7xlT+d9TdeFn+Ra46n5hFRu3R0IIBAbAv7VuWHMwsbYMkFDGeDJ
	 fiOTw5FVu5KjbxMU23r2jhTE+AntrI+2kaa+av3pnoc4JnS8GReIybxozvpEGCjOTf
	 O3ba+VR9IKri58yc1JOKElT/j2QdRvxZ8AyduiDc=
Received: from github.com (hubbernetes-node-0e6f440.ash1-iad.github.net [10.56.207.15])
	by smtp.github.com (Postfix) with ESMTPA id 29FC9360A57
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 13:54:22 -0700 (PDT)
Date: Tue, 12 May 2026 13:54:22 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6ba04f-ee4a47@github.com>
Subject: [bluez/bluez] 4ed84c: mesh: Remove unused but set variable
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
  Commit: 4ed84c4132f42c6e61934ce7f6bc29433c3e000f
      https://github.com/bluez/bluez/commit/4ed84c4132f42c6e61934ce7f6bc2=
9433c3e000f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Remove unused but set variable

We played around with the bits, but didn't do anything with it.

mesh/net.c: In function =E2=80=98ack_received=E2=80=99:
mesh/net.c:1569:18: error: variable =E2=80=98ack_copy=E2=80=99 set but no=
t used [-Werror=3Dunused-but-set-variable=3D]
 1569 |         uint32_t ack_copy =3D ack_flag;
      |                  ^~~~~~~~


  Commit: a225faba50d1224b1191c84198fefa4f7053bb6c
      https://github.com/bluez/bluez/commit/a225faba50d1224b1191c84198fef=
a4f7053bb6c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M tools/mesh/mesh-db.c

  Log Message:
  -----------
  mesh: Fix str{r,}chr usage

Fix the code manipulating "const char *" return values from
json_object_to_json_string_ext() to modify it for printing, we're
not allowed to do that.

tools/mesh/mesh-db.c: In function =E2=80=98mesh_db_finish_export=E2=80=99=
:
tools/mesh/mesh-db.c:2598:13: error: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers=
]
 2598 |         pos =3D strrchr(hdr, '}');
      |             ^
tools/mesh/mesh-db.c:2604:13: error: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers=
]
 2604 |         pos =3D strrchr(hdr, '"');
      |             ^
tools/mesh/mesh-db.c:2613:13: error: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers=
]
 2613 |         pos =3D strchr(str, '{');
      |             ^


  Commit: 28c9f959bb3be8e311b34a6c08bd95045dabd7bf
      https://github.com/bluez/bluez/commit/28c9f959bb3be8e311b34a6c08bd9=
5045dabd7bf
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M mesh/util.c

  Log Message:
  -----------
  mesh: Fix const qualifier dropping when using strchr()

strchr() with a const string returns a const string, we don't change
that string or "next", so make both const and get rid of the warning.

mesh/util.c: In function =E2=80=98create_dir=E2=80=99:
mesh/util.c:108:14: error: assignment discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
  108 |         prev =3D strchr(dir_name, '/');
      |              ^


  Commit: 31625e481b081efb2d654d401eca2abf1274d0ed
      https://github.com/bluez/bluez/commit/31625e481b081efb2d654d401eca2=
abf1274d0ed
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: add BCAA UUID also when seen device is not discoverable

BAP v1.0.2 Sec 6.4 specifies Broadcast discovery uses observation
procedure (Core Vol 3 Part C Sec 9.1.2) which makes no reference to
device discoverability state.

However, if remote device does:

1. Send Advertising Data for some other UUID with General Discoverable
2. Send Advertising Data for BCAA UUID with no flags

then adapter.c:btd_adapter_device_found() creates device in step 1. but
in step 2. it ignores the BCAA UUID since the device exists but is not
discoverable; the monitoring=3Dtrue special case applies only for
first-seen devices.  Consequently bap plugin fails to pick up the BCAA
stream.

This sequence was observed to be produced by BlueZ + btvirt.

Fix by monitoring also previously existing but currently non-connectable
devices with BCAA UUID.

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2=
812#note_3467783
Log:
--------------------------
@ MGMT Event: Device Found (0x0012) plen 17
        LE Address: 00:AA:01:00:00:42 (Intel Corporation)
        RSSI: invalid (0x7f)
        Flags: 0x00000000
        Data length: 3
        Data[3]:
        02 01 06                                         ...
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
...
@ MGMT Event: Device Found (0x0012) plen 39
        LE Address: 00:AA:01:00:00:42 (Intel Corporation)
        RSSI: invalid (0x7f)
        Flags: 0x00000004
          Not Connectable
        Data length: 25
        Data[25]:
        06 16 52 18 56 db 55 03 03 4e 18 0d 16 4e 18 00  ..R.V.U..N...N..=

        ff 0f 0f 00 04 03 01 01 00                       .........
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 5626710 (0x55db56)
        16-bit Service UUIDs (complete): 1 entry
          Audio Stream Control (0x184e)
        Service Data: Audio Stream Control (0x184e)
          Data[10]:
        00 ff 0f 0f 00 04 03 01 01 00
--------------------------


  Commit: ee4a4775bc4f8348e2a860dc44bcdd7570279908
      https://github.com/bluez/bluez/commit/ee4a4775bc4f8348e2a860dc44bcd=
d7570279908
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: Fix not checking Database Identifier length

Database Identifier is supposed to be 16 bytes values.

A paired Bluetooth device acting as a PBAP server can overflow the
heap in obexd by up to 239 bytes into adjacent allocations by returning
a DATABASEID_TAG application parameter with an oversized length.
With both length and content fully attacker-controlled, this enables
standard glibc heap exploitation primitives (tcache/fastbin poisoning)
leading to remote code execution in the obexd process.


Compare: https://github.com/bluez/bluez/compare/6ba04fad369f...ee4a4775bc=
4f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
