Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0663630B7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027883; cv=none; b=J51cQ5iDMzpoKL2C78XN00qdfXTweNqRyWXIG9XjKvlr7dUea9APGiMgJSl0jxQ07s2H4LFPGPCepV6wVDOPXXGfyloPoo545tKFkuF4onvbUOcSF7WdjGvzG10sfrug+jvcJKAODzXHHCwEloea5aJuCPJfgbiJDYE+6wJgZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027883; c=relaxed/simple;
	bh=HPIkA6VduHlxOlQ0zJAOWlZbDnt9cm1AoP4Hh1qLhTY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sQtse9N+pGVrI1Ee1oXK0ITEIRO9HKqN4ut5pC8zCqUlkojomKbk4VzZT16ztB7MyKqkhW52SOq8aStLnj9itx6BJi8Q2BhPsHMbHf+0A8yON6coQwil6a6EZTwa2fPdEqWsGVsKtmN/rO5S4kmT9S4lamODXJUv6iBsEawJgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WawQoApT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WawQoApT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3A46C2BCB4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781027882;
	bh=HPIkA6VduHlxOlQ0zJAOWlZbDnt9cm1AoP4Hh1qLhTY=;
	h=From:To:Subject:Date:From;
	b=WawQoApT2UBP5NydFMiUBf2H01B0S/jA3ma7CZpIacy8Zd3pCL6s0tDLFqPtRSuHU
	 KWrrrP9k+0Q5d4fa5hq7nMLsO04Xsidx0zCPkc7ibPwQTdkE7I0M4J9iP5Jn7nNNiP
	 4EOwWGkN4oFdpGs0jo2OoUvZMgIX32z9UojVB+YMI03aBlLkR8apcTe7nkxu2H7yzU
	 r920f3Fznhh+H3eRP5qLzDYwyigzMNnYK1o4QhBJZpZc++avpuYDVVeT622rmSw6QQ
	 J95zE5otMK6dZhgbRU/P+p6HKeO4kP+6hHzss1gAa0K3vTzlYeb1SnoxZp768AZ/Zh
	 7ctUdW/xcRW5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 967A6C3279F; Tue,  9 Jun 2026 17:58:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221629] New: Bluetooth l2cap: ident leak in
 l2cap_chan_le_send_credits() stalls BLE CoC
Date: Tue, 09 Jun 2026 17:58:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: florian-evers@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221629

            Bug ID: 221629
           Summary: Bluetooth l2cap: ident leak in
                    l2cap_chan_le_send_credits() stalls BLE CoC
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: florian-evers@gmx.de
        Regression: No

Hi,

I have found a resource leak in l2cap_chan_le_send_credits() that causes
permanent stalls of BLE L2CAP Connection-Oriented Channels under sustained
traffic. Here, I couple two Linux computers using a long-lasting L2CAP CoC
channel and transmit data in both directions, but the stream freezes after a
few seconds with dmesg warnings.


Root Cause:
-----------
l2cap_chan_le_send_credits() allocates an ident via l2cap_get_ident(conn)
(which does ida_alloc_range on conn->tx_ida), then sends L2CAP_LE_CREDITS.

However, L2CAP_LE_CREDITS is a unidirectional signaling command; the remote
never sends a response.
The normal ident-free path (l2cap_put_ident via l2cap_le_sig_cmd) is only
triggered when a response opcode arrives.
Since no response exists for this opcode, the ident is never freed.

The kernel itself documents this as unexpected at line 950-954:

    /* If all idents are in use, log an error, this is
     * extremely unlikely to happen and would indicate a bug
     * in the code that idents are not being freed properly.
     */

Failure Chain:
--------------
1. Each received SDU triggers credit replenishment at
l2cap_chan_le_send_credits()
2. Each call leaks one ident slot from the 255-slot tx_ida pool
3. After 255 credits sent, ida_alloc_range returns -ENOSPC
4. l2cap_get_ident() returns 0, logs "Unable to allocate ident: -28"
5. No further credit updates can be sent
6. Remote's TX credit window drains to zero resulting in a permanent write
stall


My assumption: why it was never found yet
-----------
- This issue only affects the RECEIVING side (which must send credit update=
s).
  The sending side never calls l2cap_chan_le_send_credits().
- The pool has 255 slots, so it takes 255 SDUs to exhaust, and short test
sessions may never trigger it.
- Classic Bluetooth L2CAP uses a separate ident range (1-128) with
request/response pairs, so it is not affected.


How to Reproduce:
-----------------
Any sustained unidirectional BLE L2CAP CoC data stream where Linux is the
receiver is affected.
Transfer >255 SDUs (e.g., a 200 KB file at MPS=3D512 triggers ~400 credit
updates). After exhaustion, dmesg shows:

    Bluetooth: Unable to allocate ident: -28

and all signaling on that connection stops permanently. The stream freezes.

I have that issue on a self-compiled kernel 7.0.10-gentoo.


Proposed  Fix:
--------------
The ident can be freed immediately after l2cap_send_cmd(), since no response
will ever reference it:

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6652,6 +6652,18 @@
 chan->ident =3D l2cap_get_ident(conn);

 l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
+
+/* L2CAP_LE_CREDITS is a one-way indication: the remote never sends a
+ * response, so l2cap_put_ident() is never called for this ident.
+ * Free it immediately to prevent exhausting the 255-slot tx_ida pool
+ * under sustained CoC traffic (e.g. hours-long bulk data streams).
+ * Pool exhaustion causes credit updates to stop being sent, which
+ * drains the remote TX credit window to zero and permanently stalls
+ * all data transfer in both directions.
+ */
+if (chan->ident)
+ida_free(&conn->tx_ida, chan->ident);
+chan->ident =3D 0;
 }

This fix has been running here for 1-2 weeks without any issues. Data is
flowing now without any dmesg warnings or stalls.

Kind regards,
Florian Evers

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
