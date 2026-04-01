Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242D402432
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045415; cv=none; b=L/5AakXtNCPTuPCNDEapHut2RzIK7+K9rwniPXR+QfVeX2REjIPQg/UqUtYcEHyZoaIR8chWCrHjk7keIDnrui3D2ZPYDCMcwlCQDeKstiatOhe2y2twgGW7jqq79awYCeGKufTHmTLwAvx6U7yLG+F8hNASvKPzVfHibVthGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045415; c=relaxed/simple;
	bh=eTA/1h5C6xEHXu90oiuzfGg52syr0qOehVKhHTdKoFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ex9dpjnGiP6SarDhLTMOcew+rFSH9K9wyjqB9yK4jCRSXTe+fqrEvs8hpVDcFfwjQeIw7NLylg2ibqEDr1sMOjHLk6SUgCXtmqWDzxRZoP1qELVBs85c8FRaXnz01/bI4w7xU/4OxLRtNFvyYMZ0EQGap7duEQ2Ytv8XN/+7y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jB1xxM9g; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jB1xxM9g"
Received: from github.com (hubbernetes-node-dd5cdec.ash1-iad.github.net [10.56.163.44])
	by smtp.github.com (Postfix) with ESMTPA id F388F1284DB
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775045413;
	bh=Uv1sR66jZ6XrFJJjGiSPvZ6TvfZd4PrPs+xZPNIOZO4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jB1xxM9gUDJfWsbt2AJPNhou5dhoavrV4xDOOTiejwc5j9hf/TfSrFsi/ilCoHZm1
	 7iKXltfbJKdyWVVqH9flYE3wzLj5NZNAROzHPTRxv/uksbmmfoOboK7q44qSENWl6S
	 UNPwrr/5wqJun2AuZ1vBah7wUTIWKeJtJzTzg68I=
Date: Wed, 01 Apr 2026 05:10:12 -0700
From: MengshiWu-mengshiw <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075787/000000-550632@github.com>
Subject: [bluez/bluez] 550632: src/device: Fix stored gatt cache DB Hash value
 no...
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

  Branch: refs/heads/1075787
  Home:   https://github.com/bluez/bluez
  Commit: 550632cf75f4c0e2867041746f96f03225b2777d
      https://github.com/bluez/bluez/commit/550632cf75f4c0e2867041746f96f=
03225b2777d
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

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
