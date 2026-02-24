Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744637F75D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932408; cv=none; b=tllmG3miO5mPGQLq1S9Op1dRe10jZT9CwWFXo1hZtEO6aDlw0K91qFlbQCQQD7glhBQ6lBgzbNmEnSdHK0kL4PIrzjZiTdd5Rj7Yu8aMacPijWqvyxuOAGRMb68DWf8aZW63K5NFERRz9c9EIl+wiZRmb9dISAr9cz5XQohWn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932408; c=relaxed/simple;
	bh=I9yx5m/8ZbT73Ha0iED2I0J86SY8SlyxbQu+eaSvoSc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f8hyIgsMPqVezKEnn/vKS4Y29u5Je+e6ZJgAeYNs9OsXG1TqZeK7p/Za8XzIMzZbRu/FfJwJqnNn6r1R3/tVQGGwhCEjvZPYgleIUAqXNkTdSKBgfphrqt5J6duBaNWZAJRSy8UbKHso1uOS4yeOv6MLetAQcPyTeeaECjUq83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k8cy94AS; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k8cy94AS"
Received: from github.com (hubbernetes-node-0d4476a.va3-iad.github.net [10.51.92.32])
	by smtp.github.com (Postfix) with ESMTPA id 13B4AE0973
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 03:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771932405;
	bh=9ZK6fUNRivbYjluG4gaS7KZPEL28039AFXNrJh9hzJI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k8cy94ASZ9T3IcgemZPgJHTTMQJoKYGK/UPngrAs+6jy/Sp2Rv8vJNn8r0zcf/oG0
	 gcfaJHOvoJkVRqLbH8G9bBpazpcfRIk0TwzteIjLqvz4Mie1miNOdR6gMsoJKbT/BG
	 aJJdYQrfWzC3k7jkgVRhgVpeogFuIA5sizljX73Y=
Date: Tue, 24 Feb 2026 03:26:45 -0800
From: MengshiWu-mengshiw <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1057153/000000-cde4bf@github.com>
Subject: [bluez/bluez] cde4bf: gatt-client:Implement error handling for
 DB_OUT_OF...
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

  Branch: refs/heads/1057153
  Home:   https://github.com/bluez/bluez
  Commit: cde4bfa2c6ba4c0d62598493210bd95afc658867
      https://github.com/bluez/bluez/commit/cde4bfa2c6ba4c0d62598493210bd=
95afc658867
  Author: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
  Date:   2026-02-24 (Tue, 24 Feb 2026)

  Changed paths:
    M src/shared/att.c
    M src/shared/att.h
    M src/shared/gatt-client.c
    M src/shared/gatt-helpers.c
    M src/shared/gatt-helpers.h

  Log Message:
  -----------
  gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching=


Implement automatic retry logic for GATT operations that fail with
DB_OUT_OF_SYNC error (0x12).

This implementation follows the GATT caching specification and provides
robust error recovery while minimizing unnecessary service discovery
operations.

When a DB_OUT_OF_SYNC error occurs, the implementation:

1. Pauses the failed operation in a pending_db_sync state
2. Notifies the GATT client layer via db_sync_callback
3. Reads the remote Database Hash characteristic (0x2B2A)
4. Compares it with the locally cached hash value
5. If hashes match: Retries the operation (database is in sync)
6. If hashes differ: Triggers full service discovery

Workflow:
---------

Hash Match Case:
  App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
                                      =E2=86=93 (DB_OUT_OF_SYNC error)
  App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
                =E2=86=93
         Read DB Hash (0x2B2A)
                =E2=86=93
         Compare with local cache
                =E2=86=93 (Match)
         bt_att_resend(att, id, ...)
                =E2=86=93
  App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device (=
retry)
                                      =E2=86=93 (Success)
  App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device

Hash Differ Case:
  App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
                                      =E2=86=93 (DB_OUT_OF_SYNC error)
  App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
                =E2=86=93
         Read DB Hash (0x2B2A)
                =E2=86=93
         Compare with local cache
                =E2=86=93 (Differ)
         bt_att_cancel(att, id)
                =E2=86=93
         Trigger Service Discovery
                =E2=86=93
  App =E2=86=90 GATT Client (operation failed, discovery in progress)

Service Changed Ind Received (Handle Outside Affected Range):
  App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
                                      =E2=86=93 (DB_OUT_OF_SYNC error)
  App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
                =E2=86=93
         Service Changed Ind arrives
                =E2=86=93
         Check error handle vs affected range
                =E2=86=93 (Outside range)
         bt_att_resend(att, id, ...)
                =E2=86=93
  App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device (=
retry)
                                      =E2=86=93 (Success)
  App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device

Service Changed Ind Received (Handle Inside Affected Range):
  App =E2=86=92 GATT Client =E2=86=92 ATT Layer =E2=86=92 Remote Device
                                      =E2=86=93 (DB_OUT_OF_SYNC error)
  App =E2=86=90 GATT Client =E2=86=90 ATT Layer =E2=86=90 Remote Device
                =E2=86=93
         Service Changed Ind arrives
                =E2=86=93
         Check error handle vs affected range
                =E2=86=93 (Inside range)
         bt_att_cancel(att, id)
                =E2=86=93
         Service Discovery already in progress
                =E2=86=93
  App =E2=86=90 GATT Client (operation failed, discovery in progress)

btmon traffics:
--------------

Hash Match Case:

bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7   #1 [hci1]
13.675271
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5         #2 [hci1]
> 13.694287
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9                      #3 [hci1]
> 13.728279
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11  #4 [hci1]
13.730759
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5         #5 [hci1]
> 13.754290
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 24                     #6 [hci1]
> 13.820283
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: f74347d19eef647d97f0b2f7af502e33
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11  #7 [hci1]
13.822792
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5         #8 [hci1]
> 13.842581
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9                      #9 [hci1]
> 13.880369
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7   #10
[hci1] 13.880999
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5         #11
> [hci1] 13.904288
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 6                      #12
> [hci1] 13.940273
      ATT: Read Response (0x0b) len 1

--------------------
Hash differ case:

bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5
> #17 [hci1] 50.171857
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9
> #18 [hci1] 50.171970
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
> #20 [hci1] 50.201854
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 24
> #21 [hci1] 50.268291
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 5fa98eed072ee317aa521990be294bf3
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
> #23 [hci1] 50.291849
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9
> #24 [hci1] 50.419999
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5
> #26 [hci1] 50.471607
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 24
> #27 [hci1] 50.471663
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0011
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0012-0x0014
        UUID: Device Information (0x180a)
--------------------

Changes from v4:
 - Fix errors reported by bluez.test.bot
 - Link to v4
   https://lore.kernel.org/all/20260210011347.3237740-1-mengshi.wu@oss.qu=
alcomm.com/

Changes from v3:
 - Reuses existing bt_att_resend() and bt_att_cancel() functions
 - Add new structure pending_db_sync
 - Link to v3
   https://lore.kernel.org/all/20260121083804.4010106-1-mengshi.wu@oss.qu=
alcomm.com/

Changes from v2:
 - Detects DB_OUT_OF_SYNC errors during GATT operations
 - Extracts affected handles from the original request PDU
 - Checks if Service Changed indications overlap with those handles
 - Verifies database consistency using Database Hash characteristic
 - Automatically retries the original request if DB is consistent
 - Automatically retries the original request if handle is not affected
 - Link to v2
   https://lore.kernel.org/all/20260105103828.105346-1-mengshi.wu@oss.qua=
lcomm.com/

Changes from v1:
 - Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
   received from the remote device.
 - Link to v1
   https://lore.kernel.org/all/20251208101915.247459-1-mengshi.wu@oss.qua=
lcomm.com/

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
