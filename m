Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD7418A46;
	Tue, 13 Oct 2026 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861608; cv=none; b=tH2ZUI1P8iC1uel/8HxKpGjTMgnW/Kq5gnrcCzgekVgM+AlbcKoSl1ns/Q91E0Tcle5QVM4TM9EmG2KKey13/fbuYrOwrF5iMI/PPqdi2/ikYKRWPAF/4eM2X75CzUlj3ml7UaXC4c60DCLHLs8xjThk01xYIcORUr+6UeXy+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861608; c=relaxed/simple;
	bh=9ZcLP/wiS6yfOqCEy+UUeVI0Yd06dr975LtFJkBVl5M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FgONkAKlZFu9Junu0whNPcIOk3iagjQ3umzuC+zagk8l5lv/4V4VJyAKChCkM8+SZDHw9S9rLFBCiuCY82xiwNiUVygtVphDcRphiFcWoXNUS7reOIg6XObZkaJ4fkTu6Izzg1gVFAcSC8ktbPBwnkzrzlOd9px2cNf03dkFoj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WTAoi1eT; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WTAoi1eT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791861603; x=1792120803;
	bh=frkNg8NqyYW3v9G6WLW/NUGDBIAwXJTkGr0PdRlAV0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WTAoi1eTO75ArOIfKJiNfQilSQockkGfufDwk9owyfQyxRYrUvZAuVWTti49TDYX0
	 eq9uETzeIh/7TABG+22SChrTkVCiMXC6GypSQL8+ieA3ee/r0qDeNBG8OvYYNGQ+Pi
	 CFX/gyl78wFW+b68QtZAEFkwHS/ykb4yFgOOMtnLYXl358wbcKxQL3CqCSLXB6J6Et
	 UxoDMQe7y4+zC1EmCbYTqqHbdqGg/UAidZMJMBcn+VeH6ZHO+BaNcd3mvKVY6++TFU
	 /i+eyXGAkuVdXXkLdKL35PuCJe7H2LP0ngPsXVSFWQuYGJ9hqbZGh/sJRO8MhB91jn
	 aPI/LAQcql0zQ==
Date: Tue, 13 Oct 2026 03:19:58 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261013031943.489829-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 5e715a7472e6f12121efdd0d483cc4c441d1fe5c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A nonconforming ASHA peer sends identifier-zero credit indications
that are discarded, reducing usable transmit credits until audio stalls.

Tolerate only exact-size credit indications for a connected LE CoC.
Preserve the channel reference, lock and credit-overflow checks and do
not send a response with identifier zero. Other zero-ID commands and
BR/EDR signaling remain unchanged.

Core Vol 3 Part A section 4 forbids identifier zero. This is an
interoperability RFC requiring maintainer agreement, not a conformance
fix or a claim of automatic stream recovery.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Submission review notes (not part of the commit message):
Core specification forbids identifier zero. This is a narrow opcode
interoperability exception, not a conformance fix. N8 captures contain
zero-ID credit indications. Native malformed/overflow/teardown and
lockdep/KASAN coverage and exception policy remain review gates.

 net/bluetooth/l2cap_core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49a998804..1a0868437 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5328,6 +5328,12 @@ static inline int l2cap_le_credits(struct l2cap_conn=
 *conn,
=20
 =09l2cap_chan_lock(chan);
=20
+=09/* Tolerate identifier-zero credits only for a live LE CoC. */
+=09if (!cmd->ident &&
+=09    (!credits || chan->state !=3D BT_CONNECTED ||
+=09     chan->mode !=3D L2CAP_MODE_LE_FLOWCTL))
+=09=09goto unlock;
+
 =09max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 =09if (credits > max_credits) {
 =09=09BT_ERR("LE credits overflow");
@@ -5923,11 +5929,21 @@ static inline void l2cap_le_sig_channel(struct l2ca=
p_conn *conn,
=20
 =09BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd->code, len, cmd->ident);
=20
-=09if (len !=3D skb->len || !cmd->ident) {
+=09if (len !=3D skb->len) {
 =09=09BT_DBG("corrupted command");
 =09=09goto drop;
 =09}
=20
+=09if (!cmd->ident) {
+=09=09if (cmd->code !=3D L2CAP_LE_CREDITS ||
+=09=09    len !=3D sizeof(struct l2cap_le_credits))
+=09=09=09goto drop;
+
+=09=09/* Credits have no response or identifier-matched transaction. */
+=09=09l2cap_le_credits(conn, cmd, len, skb->data);
+=09=09goto drop;
+=09}
+
 =09err =3D l2cap_le_sig_cmd(conn, cmd, len, skb->data);
 =09if (err) {
 =09=09struct l2cap_cmd_rej_unk rej;

base-commit: 964430c038967fd06643e866f68115664e1a1bd1

