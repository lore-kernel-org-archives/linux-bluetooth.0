Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A3EA6A
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NFRk2fbt"
Received: from github.com (hubbernetes-node-40ef780.ac4-iad.github.net [10.52.133.30])
	by smtp.github.com (Postfix) with ESMTPA id A1B0A70006A
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 08:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1702658361;
	bh=BD0UJ9xpFHA6QC6k7JTLt1K//SP4U96T6Ulb8S78Lm4=;
	h=Date:From:To:Subject:From;
	b=NFRk2fbtcbaFf13Ubv6JAMxD5pZpHPZ/7D6BGjBGObfOjWrrfuIuYmtDNePseP4Gj
	 TeY6Rut282S8mSBFkWKV+6dcJp4wy4tPz4tKidGBNGfB2qz79Al3YJ4KzjUG8EwYch
	 IsVU1FgTyfl1MYje6NuQuRfPIpPIC5cNcwEh02u8=
Date: Fri, 15 Dec 2023 08:39:21 -0800
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/477c41-04ecf6@github.com>
Subject: [bluez/bluez] 95838e: shared/vcp: Fix notification endianness
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
  Commit: 95838efc07d34c6ac121c65daa3316bf50f0374f
      https://github.com/bluez/bluez/commit/95838efc07d34c6ac121c65daa331=
6bf50f0374f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-11 (Mon, 11 Dec 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix notification endianness

4db4d5fa1c4f ("shared/vcp: Fix endianness errors") does attempt to fix
the endianness of stored volume offset but in the process it broke the
notification since the value is no longer stored in the Bluetooth byte
order (Little Endian) but instead in the cpu byte order which is then
used in the notification as is, to fix this instead of notifying using
the stored value it now uses a dedicated variable which does use the
value from the request itself.


  Commit: fb681e795027edb3e995e2c75657ebab0360a299
      https://github.com/bluez/bluez/commit/fb681e795027edb3e995e2c75657e=
bab0360a299
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2023-12-11 (Mon, 11 Dec 2023)

  Changed paths:
    M tools/avtest.c

  Log Message:
  -----------
  tools: avtest: Add reject-code option

Some PTS tests like A2DP/SNK/AVP/BI-03-C, A2DP/SNK/AVP/BI-08-C , =E2=80=A6=

request some specific rejection code to pass.
This commit adds an option to specify the rejection code during
AVDTP_SET_CONFIGURATION rejection.

E.g. "avtest --reject setconf --reject-code 195" to reject setconf with
INVALID_SAMPLING_FREQUENCY code.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


  Commit: 87477b7ffefcf3c64c821d9f700664d89aa2c5f7
      https://github.com/bluez/bluez/commit/87477b7ffefcf3c64c821d9f70066=
4d89aa2c5f7
  Author: Kiran K <kiran.k@intel.com>
  Date:   2023-12-11 (Mon, 11 Dec 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Update Available context for source

Available Context of sink was getting updated instead of source.


  Commit: d5536e0cd431e22be9a1132be6d4af2445590633
      https://github.com/bluez/bluez/commit/d5536e0cd431e22be9a1132be6d4a=
f2445590633
  Author: Xiao Yao <xiaoyao@rock-chips.com>
  Date:   2023-12-11 (Mon, 11 Dec 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix addr_type for smp_irk/ltk_info/link_key

According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
converted between each other, so the addr type can be either
BREDR or LE, so fix it.


  Commit: ba9fda12d26bf4200339da94bc198c6641f98668
      https://github.com/bluez/bluez/commit/ba9fda12d26bf4200339da94bc198=
c6641f98668
  Author: Xiao Yao <xiaoyao@rock-chips.com>
  Date:   2023-12-11 (Mon, 11 Dec 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Notify when the bdaddr_type changes

This ensures the AddressType reflects the bdaddr_type stored.


  Commit: 093d00b47ee4e3544aa80de33e869a8617c4af32
      https://github.com/bluez/bluez/commit/093d00b47ee4e3544aa80de33e869=
a8617c4af32
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-11 (Mon, 11 Dec 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Don't attempt to release if old state was releasing

If the old state was releasing there is no reason to call
bt_bap_stream_release yet again when IO could not be created as that
will likely create a loop situation when the remote stack caches the
codec configuration.


  Commit: cd00105c5b7383bffd0198059e7b1fee1e2b6c99
      https://github.com/bluez/bluez/commit/cd00105c5b7383bffd0198059e7b1=
fee1e2b6c99
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-12-13 (Wed, 13 Dec 2023)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: 04ecf635ffaa2f7f8bca89cec3a0fbdbeb016dc9
      https://github.com/bluez/bluez/commit/04ecf635ffaa2f7f8bca89cec3a0f=
bdbeb016dc9
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-12-13 (Wed, 13 Dec 2023)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.71


Compare: https://github.com/bluez/bluez/compare/477c41c683ea...04ecf635ff=
aa
