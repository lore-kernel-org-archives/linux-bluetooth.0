Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47F3E4C92
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110039; cv=none; b=CBRR67xPtSaja/P3vikHJNWf4Ym5ALLbNMUxwBcVg9I0OoecKfqcNESFWjjPxKf3LTrokswHPvFUBNDoslolHZ173G5u8RDGjU4Ky/AsKR0RQAEkR3KZY6ulY/Xr4cUIElc/az+1wkNBnkYemU4qOcBLfWAV1M5fRAjH7BFF4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110039; c=relaxed/simple;
	bh=fTEEYHJi0QvWuYUbLEGlhV3nd6mXWAXG9agu9WlASlo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VNawpEyqqU1Kv6E6D6C0/+/B8a5qj+oTNe7EXqpZy7Y5YA9MH51p6SWUNheICTB/xpIh/te6d/TS1vZRUP6BtZ9X61igRyayRKlYND18822X4onD/pY+TdeLYnGdijER1YV0Hc5FTh15T7Gqpw2SXO9eGfHaIvC+BOqCHNRzSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J7gyX2tn; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J7gyX2tn"
Received: from github.com (hubbernetes-node-7e243d7.va3-iad.github.net [10.48.125.78])
	by smtp.github.com (Postfix) with ESMTPA id 656694E06C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776110035;
	bh=gvcESy9kvay1YOBddmD7zQhzcnjQNQRD7Q9oZXhEogo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J7gyX2tnK+9Deen/xVDeGMIPYVHYW3l4ymAU1zAJ42Sq5RTutLKuXhonAVRV+ofU6
	 qVPfcxKnYNQzPGbIldvZ0OuaHb9Nta8oXRK+B3oKwIist9bD/4BfXLAz5n69MjK9xQ
	 MyS7CxYfRWTvtReO/gt32KUch7uSxnXbiQLqkZAk=
Date: Mon, 13 Apr 2026 12:53:55 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/516099-1ab128@github.com>
Subject: [bluez/bluez] fb0f8f: audio/player: Ensure metadata string is valid
 UTF-8
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
  Commit: fb0f8f495ace893f65ee1eaa91e84743ccf62cc9
      https://github.com/bluez/bluez/commit/fb0f8f495ace893f65ee1eaa91e84=
743ccf62cc9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-13 (Mon, 13 Apr 2026)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  audio/player: Ensure metadata string is valid UTF-8

bluetoothd crashes on reception of GetItemAttributes reply if it contains=

an invalid UTF-8 string:

> BR-ACL: Handle 11 [B8:3C:28:E8:07:69 (Apple, Inc.)] flags 0x02 dlen 680=

      Channel: 71 len 676 ctrl 0x0304 [PSM 27 mode Enhanced Retransmissio=
n
               (0x03)] {chan 7}
      I-frame: Unsegmented TxSeq 2 ReqSeq 3
      AVCTP Browsing: Response: type 0x00 label 2 PID 0x110e
        AVRCP: GetItemAttributes: len 0x029a
          Status: 0x04 (Success)
          AttributeCount: 0x01 (1)
          AttributeID: 0x00000001 (Title)
          CharsetID: 0x006a (UTF-8)
          AttributeLength: 0x0290 (656)
          AttributeValue: ...............................................=
.
.........................................................................=
.
.........................................................................=
2
009......................................................................=
.
.........................................................................=
.
.........................................................................=
.
.........................................................................=
.
.........................................................................=
.
.........................................................................=
.
................
=3D bluetoothd: profiles/audio/player.c:media_player_set_playlist_item() =
0
=3D bluetoothd: profiles/audio/player.c:media_player_set_metadata() Title=
:
  =E5=A5=A5=E5=B7=B4=E9=A9=AC=E8=A1=A8=E7=A4=BA=EF=BC=9A=E7=BE=8E=E5=9B=BD=
=E4=B9=8B=E6=89=80=E4=BB=A5=E6=B2=A1=E6=9C=89=E6=90=9E=E5=AE=9A=E4=B8=AD=E5=
=9B=BD=EF=BC=8C=E4=B8=8D=E6=98=AF=E5=9B=A0=E4=B8=BA=E4=B8=AD=E5=9B=BD=E7=9A=
=84=E5=86=9B=E4=BA=8B=E5=AE=9E=E5=8A=9B=E4=BB=A5=E5=8F=8A=E7=BB=8F=E6=B5=8E=
=E5=BC=BA=E5=A4=A7
  =EF=BC=8C=E8=80=8C=E6=98=AF=E5=9B=A0=E4=B8=BA=E4=B8=AD=E5=9B=BD=E4=BB=8E=
=E5=A7=8B=E8=87=B3=E7=BB=88=E9=83=BD=E6=B2=A1=E6=9C=89=E6=8E=89=E8=BF=9B=E6=
=88=91=E4=BB=AC=E5=AE=89=E6=8E=92=E7=9A=84=E2=80=9C=E9=99=B7=E9=98=B1=E2=80=
=9D=E3=80=82=E6=97=B6=E9=97=B4=E5=80=92=E5=9B=9E2009=E5=B9=B4=EF=BC=8C=E5=
=8C=97=E4=BA=AC
  =E9=92=93=E9=B1=BC=E5=8F=B0=E5=9B=BD=E5=AE=BE=E9=A6=86=E3=80=82=E5=A5=A5=
=E5=B7=B4=E9=A9=AC=E7=9A=84=E9=9A=8F=E8=A1=8C=E5=9B=A2=E9=98=9F=E4=B8=80=E8=
=BF=9B=E9=97=A8=EF=BC=8C=E8=BF=9E=E5=8F=A5=E5=AE=A2=E5=A5=97=E8=AF=9D=E9=83=
=BD=E6=B2=A1=E9=A1=BE=E5=BE=97=E4=B8=8A=E8=AF=B4=EF=BC=8C=E5=8F=8D=E6=89=8B=
=E5=B0=B1=E6=8A=8A
  =E9=9A=8F=E8=BA=AB=E5=B8=A6=E7=9A=84=E7=94=B5=E5=AD=90=E8=AE=BE=E5=A4=87=
=E6=8C=A8=E4=B8=AA=E6=8B=94=E4=BA=86=E7=94=B5=E6=BA=90=E3=80=81=E5=8D=B8=E4=
=BA=86=E7=94=B5=E6=B1=A0=E3=80=82=E8=BF=99=E9=98=B5=E4=BB=97=E7=9C=8B=E7=9D=
=80=E5=83=8F=E6=98=AF=E5=9C=A8=E9=98=B2=E7=9B=91=E5=90=AC=EF=BC=8C=E5=AE=9E=
=E5=88=99=E6=98=AF
  =E5=BF=83=E8=99=9A=E3=80=82=E9=82=A3=E7=BE=A4=E5=9C=A8=E9=95=BF=E6=A1=8C=
=E5=AF=B9=E9=9D=A2=E5=9D=90=E4=B8=8B=E7=9A=84=E4=BA=BA=EF=BC=8C=E5=BF=83=E9=
=87=8C=E6=AD=A3=E7=BF=BB=E8=85=BE=E7=9D=80=E4=B8=80=E7=A7=8D=E4=BB=8E=E6=9C=
=AA=E6=9C=89=E8=BF=87=E7=9A=84=E6=97=A0=E5=8A=9B=E6=84=9F=E3=80=82=E5=9B=A0=
=E4=B8=BA=E7=9C=BC
  =E5=89=8D=E7=9A=84=E8=B0=88=E5=88=A4=E5=AF=B9=E8=B1=A1=EF=BC=8C=E5=8E=8B=
=E6=A0=B9=E6=B2=A1=E6=89=93=E7=AE=97=E7=85=A7=E7=9D=80=E4=BB=96=E4=BB=AC=E5=
=85=9C=E9=87=8C=E7=9A=84=E5=89=A7=E6=9C=AC=E5=BF=B5=E5=8F=B0=E8=AF=8D=E3=80=
=82=E5=A4=9A=E5=B9=B4=E4=BB=A5=E5=90=8E=EF=BC=8C=E9=80=80=E4=B8=8B=E6=9D=A5=
=E7=9A=84=E5=A5=A5
  =E5=B7=B4=E9=A9=AC=E5=9C=A8=E5=9B=9E=E5=BF=86=E5=BD=95=E3=80=8A=E5=BA=94=
=EF=BF=BD
arguments to dbus_message_iter_append_basic() were incorrect,
  assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in file
  dbus-message.c line 2775.
This is normally a bug in some application using the D-Bus library.


  Commit: 1ab128f6d749427a5508592b3b2b587b724efccf
      https://github.com/bluez/bluez/commit/1ab128f6d749427a5508592b3b2b5=
87b724efccf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-13 (Mon, 13 Apr 2026)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: remove database from dbs list when destroyed

btd_gatt_database_new() adds btd_gatt_database to the dbs lookup queue,
but nothing removes it from there even when destroying.

Fix by removing databases from the lookup queue before destroy.

Fixes crash on adapter removal in some cases:

ERROR: AddressSanitizer: heap-use-after-free on address 0x7bd476be1308
READ of size 8 at 0x7bd476be1308 thread T0
    #0 0x00000064562a in match_db
    #1 0x000000865410 in queue_find
    #2 0x000000645671 in btd_gatt_database_get
0x7bd476be1308 is located 8 bytes inside of 128-byte region [0x7bd476be13=
00,0x7bd476be>
freed by thread T0 here:
    #0 0x7f1478cee4cf in free.part.0
    #1 0x000000621625 in gatt_database_free
    #2 0x000000645582 in btd_gatt_database_destroy


Compare: https://github.com/bluez/bluez/compare/516099a9d405...1ab128f6d7=
49

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
