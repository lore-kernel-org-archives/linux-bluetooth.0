Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F635E93C
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055915; cv=none; b=Z1tIt5kXagG7MRV8qW31MetXAkoIwbWwyaoPGiMRCMaH+qIBy+a3IagwmHClNW6yH2/FWN4Nw1e5D/otBhbBHd/J+wy5ZzrY6gPeOsCm0DGuVMoD0td12ru45DqOI154NGMtSbEGZLhUSDuHQ+HO/w/zHw5GCizO03VbFwpHZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055915; c=relaxed/simple;
	bh=67fdDgnmxqXKKJausPjD036g3icF4hdpVTCx0XT8LQY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=byKV4lHN2BnlwoYK8XV28lD2k44oM3kZGTqxNXebx9ePCUZp6g6rLWUOfBqpTDkVO0a3TCLO96W36EwrpeOf1YVhrQAfHuBDRUFkVRRStS00wJDh60HCADDBxG3veCM00wOe0JJBWlEQr5EpgSG26KdeYBv+RHFLhA0efSl/MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YXteX2UP; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YXteX2UP"
Received: from github.com (hubbernetes-node-94f6cc2.ash1-iad.github.net [10.56.225.53])
	by smtp.github.com (Postfix) with ESMTPA id E03C76C1097
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775055914;
	bh=NKARWzWdcdZ9npnAhMX1rFnlcT0rD2/pyylQf9RCIps=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YXteX2UPfxjcSHGkh3WSpAz5iw/i6c9G1UtgqL/5k2d+y8Pp/zo5rSTigpPzcWimD
	 2l5ZBX1DiOGPmbKqaFi3Z4tPIxTMS2CXCELt4xQwMT9WPcxhSPZPEMMNsGX2AHNVKU
	 6Mx3EqC7EFwhJRO7+hMXOxSQsdVWfSEsVarqNzBw=
Date: Wed, 01 Apr 2026 08:05:13 -0700
From: MengshiWu-mengshiw <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f99562-0fd01e@github.com>
Subject: [bluez/bluez] 023e57: shared/util: Add MIN/MAX implementations
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
  Commit: 023e57342a0791b586e336fecce627ecb6a2e46f
      https://github.com/bluez/bluez/commit/023e57342a0791b586e336fecce62=
7ecb6a2e46f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M src/sdpd-request.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add MIN/MAX implementations

And remove it from src/sdpd-request.c to avoid a redefinition warning
at compile-time.


  Commit: dbbfffe2c32338b96fb16def680852c3db62d2c9
      https://github.com/bluez/bluez/commit/dbbfffe2c32338b96fb16def68085=
2c3db62d2c9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Remove compile-time header only glib dep

btvirt relied on a glib header macro to use MIN/MAX, but didn't link
against it, meaning that it was dependent on other programs in the
project using glib to compile correctly.

Remove the include and use our own implementation instead.


  Commit: 0fd01e98cf94616a5c1c39749314cdd4a1654687
      https://github.com/bluez/bluez/commit/0fd01e98cf94616a5c1c39749314c=
dd4a1654687
  Author: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  src/device: Fix stored gatt cache DB Hash value not update

There is an asymmetry in behavior: when services are added during
the same connection (via Service Changed indication), the persistent
storage (disk) is not updated with the new DB hash, but when services
are removed, it is updated.

During the same connection, We check DB hash value stored at
/var/lib/bluetooth/<adaptor addr>/cache/<remote addr>.
When established connection, the stored DB Hash value is A.Then we
add new services, the stored DB Hash value is still A which should
change to B. However, if we remove the existing services, the stored
DB Hash value changed to C.

When performing addition, it goes like this:

discover_primary_cb()
  =E2=94=94=E2=94=80> gatt_db_insert_service()      =E2=86=90 NEW service=
 inserted into db
        =E2=94=94=E2=94=80> gatt_service_added()    =E2=86=90 callback fi=
res immediately
              =E2=94=94=E2=94=80> store_gatt_db()   =E2=86=90 SAVED TO DI=
SK (hash still OLD)
  ...
  =E2=94=94=E2=94=80> discovery_op_complete(success=3Dtrue)
        =E2=94=94=E2=94=80> read_db_hash(op)             =E2=86=90 sends =
ATT Read By Type
              =E2=94=94=E2=94=80> [ATT response arrives]
                    =E2=94=94=E2=94=80> db_hash_read_cb()
                          =E2=94=9C=E2=94=80> gatt_db_attribute_write(op-=
>hash, ...)
                          =E2=94=82     =E2=94=94=E2=94=80> hash UPDATED =
IN MEMORY
                          =E2=94=94=E2=94=80> discovery_op_complete(true,=
 0)
                                =E2=94=9C=E2=94=80> [no services to remov=
e, no
                                =E2=94=82    store_gatt_db called]
                                =E2=94=94=E2=94=80> service_changed_compl=
ete()

Whereas removal perform like this:
discovery_op_complete(success=3Dtrue)  [1st call]
  =E2=94=94=E2=94=80> read_db_hash(op)
      =E2=94=94=E2=94=80> op->hash is NULL =E2=86=92 sends ATT request =E2=
=86=92 early return
...
[ATT response arrives]
db_hash_read_cb()
  =E2=94=94=E2=94=80> gatt_db_attribute_write(op->hash, ) =E2=86=90 hash =
UPDATED IN MEMORY
  =E2=94=94=E2=94=80> discovery_op_complete(true, 0)          [2nd call]
      =E2=94=94=E2=94=80> read_db_hash(op)  =E2=86=92 op->hash already se=
t =E2=86=92 returns false
      =E2=94=94=E2=94=80> gatt_db_remove_service()
          =E2=94=94=E2=94=80> gatt_service_removed()
              =E2=94=94=E2=94=80> store_gatt_db() =E2=86=90 SAVED TO DISK=
 (hash is NEW)

There is a timing issue to update DB Hash value.

The gatt_client_service_changed() callback in src/device.c is called
from service_changed_complete() in gatt-client.c, which is invoked
after db_hash_read_cb() has already updated the hash. Adding
store_gatt_db(device) here guarantees the db is persisted with the
correct, up-to-date hash for both the addition and removal cases.


Compare: https://github.com/bluez/bluez/compare/f99562ebea58...0fd01e98cf=
94

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
