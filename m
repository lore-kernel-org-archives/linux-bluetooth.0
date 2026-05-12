Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E038333C
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613817; cv=none; b=a9RBRStHHCy/+ukzDDt8P99dkvjLwjj/ZUbodlXUQoK5Hd1yDtke9kV5nTJ7A24OvaPfgm6+LWG1WifdkHtumW7UnSnzA4H66x3TXsskwDR3ip0mC0Raw/RKvlZXy/g7+hRfJprLBlcOfl7p/HXrjIFkZSrfiav7zI6Rf9eG564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613817; c=relaxed/simple;
	bh=hA/rXFdntUNKb6YbI7FIYZar78JUT9YfjMWkqorP4pY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s5mD+usnz0g4ISV8aA6kKLxueUoei2aeoTirZQhD00ORpyMPsuPjOjjgNCxa1eAcwaBcNinW5LbfoXGrUVEr5067H3w2jXt36mErp/01bpOjJTYyZEORRPU+qi6Y+IwxNxgo2WFEOLS2d3PIYGtGtqd0vg18IfJ5M2QDotvIHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gxUNHGte; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gxUNHGte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778613815;
	bh=wwSV2rE2lo8zTz+eouYzmJZ2PM/AsCtilW2S5hqqBx0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gxUNHGteNv51trVUTN9B5VKglPgl0QmkFjDFcvMh41kj8sCe4XKVIayeAwI13boZv
	 M9Sa4Y4W5K7yR9vv4mSsT0IAm6mBsSljgQHi+QgPVEYDxtDNkcoQTlufcUqxjs7I2U
	 StpTCA8TyDlKgQoTWUbVcF9sTV/OAq3n5k1xDo5M=
Received: from github.com (hubbernetes-node-5a91c0d.ash1-iad.github.net [10.56.192.48])
	by smtp.github.com (Postfix) with ESMTPA id 2FC5F180E10
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 12:23:35 -0700 (PDT)
Date: Tue, 12 May 2026 12:23:35 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7cd27f-6ba04f@github.com>
Subject: [bluez/bluez] 4cedd8: monitor: Fix RAS CS step mode parsing issues
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
  Commit: 4cedd8f9b886221f857c67295b1c1ed6b285ea3d
      https://github.com/bluez/bluez/commit/4cedd8f9b886221f857c67295b1c1=
ed6b285ea3d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix RAS CS step mode parsing issues

Fix double space typo in print_ranging_steps signature.

Fix ToA_ToD sign extension using proper cast via (uint32_t)(int16_t)
instead of unconditionally OR-ing with 0xFFFF0000 which corrupts
positive values.

Refactor print_step_mode_3 to reuse print_step_mode_1 and
print_step_mode_2 eliminating ~90 lines of duplicated code.

Initialize first_segment to false so the error path via goto done
does not incorrectly print remaining data when the segmentation
header was never parsed.

Improve Mode 0 step data length heuristic with better alignment
check and clearer documentation of the limitation.

Assisted-by: OpenCode:claude-opus-4.6


  Commit: ca2b39b0c08e810643eb53fb3fa3f7a49ff24dcd
      https://github.com/bluez/bluez/commit/ca2b39b0c08e810643eb53fb3fa3f=
7a49ff24dcd
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M lib/bluetooth/hci.c
    M src/main.c
    M src/shared/gatt-server.c

  Log Message:
  -----------
  all: Remove more unneeded MIN/MAX macro definition


  Commit: 2e0533f977cc5f1c3a62270aedebbefd14fa7a5a
      https://github.com/bluez/bluez/commit/2e0533f977cc5f1c3a62270aedebb=
efd14fa7a5a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M src/shared/util.h
    M unit/test-util.c

  Log Message:
  -----------
  shared/util: Add helper for "cleanup" variable attribute

Use the widespread "cleanup" variable attribute:
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup

It is implemented by both GCC and clang on platforms where bluez is
used, and can help reduce memory leaks, while improving readability.

This implements:
- generic cleanup (_cleanup_free_)
- cleanup with specific free function (_cleanup_())
- cleanup for specific types (_cleanup_type_(type))
- cleanup for file descriptors
- capturing a variable before it is freed (so it is only freed in error
  paths for example, _steal_() and _steal_fd())

This commit includes tests which should cover all those new helpers.

See also:
https://systemd.io/CODING_STYLE/#memory-allocation
https://docs.gtk.org/glib/auto-cleanup.html


  Commit: 9ba6c13df5fb461237e5f4e44f81eee3a21b415a
      https://github.com/bluez/bluez/commit/9ba6c13df5fb461237e5f4e44f81e=
ee3a21b415a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M doc/maintainer-guidelines.rst

  Log Message:
  -----------
  doc: Recommend using _cleanup_ and friends


  Commit: 140e3569295c662a8a9e12aec1cdc72c027361d6
      https://github.com/bluez/bluez/commit/140e3569295c662a8a9e12aec1cdc=
72c027361d6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify configuration parsing

Use helpers to simplify temporary string usage, and cleanup in error
paths.


  Commit: e33f5027b898a84e664752d92b16a2b8ac25eda3
      https://github.com/bluez/bluez/commit/e33f5027b898a84e664752d92b16a=
2b8ac25eda3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client: Use _cleanup_fd_ to simplify urandom access

fd gets auto-closed before exiting the scope.


  Commit: 02aa9a8cfe6af80d59cca0851608ed87a708e0ed
      https://github.com/bluez/bluez/commit/02aa9a8cfe6af80d59cca0851608e=
d87a708e0ed
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M tools/btattach.c

  Log Message:
  -----------
  btattach: Use _cleanup_fd_ to simplify error paths

Use _cleanup_fd_ and _steal_fd() to simplify error paths, and only
"steal" the file descriptor on success.


  Commit: f95b524e5a1d5a851ada7532160b80fa44dd4721
      https://github.com/bluez/bluez/commit/f95b524e5a1d5a851ada7532160b8=
0fa44dd4721
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


  Commit: 3940d9cf85a2a62ec2ad60ee50b2ac70b801cdf9
      https://github.com/bluez/bluez/commit/3940d9cf85a2a62ec2ad60ee50b2a=
c70b801cdf9
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


  Commit: 7b2b51ac6f6482e531dd23af7c6761f8c786cd13
      https://github.com/bluez/bluez/commit/7b2b51ac6f6482e531dd23af7c676=
1f8c786cd13
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


  Commit: ec223f0782ef1265823b5233fccea0f3f552bab0
      https://github.com/bluez/bluez/commit/ec223f0782ef1265823b5233fccea=
0f3f552bab0
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


  Commit: 6ba04fad369f1dced3892944df6779c5f99b359c
      https://github.com/bluez/bluez/commit/6ba04fad369f1dced3892944df677=
9c5f99b359c
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


Compare: https://github.com/bluez/bluez/compare/7cd27f4f66aa...6ba04fad36=
9f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
