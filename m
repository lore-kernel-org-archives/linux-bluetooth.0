Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520439;
	b=zMS/+b5a/Ny1IZ0LNyJnA8yn4j+XCKXT3j5JVg2EmfUFqhfD+Ifmn5igVu9opUJbG+J9
	 4SFpRdd0M2lSr19my+YAOjVagdOlrzxLnONL7+pm46rD4oiW28Je+teieeSXzlNYe1vo3
	 Hgd7G1LOCprQI5x00GAFCiEwHmNKWHKT+xQc/Tk0mCgKcJeCfJqLQN/7MH2tYSdmc8u9e
	 w9qLiGNk7JZD4glr1ct/sVaOTsqPADbtIgF9f17cD94UAA8BWP4MRS1QsjCt8XN6hZNe8
	 ZupXrDbgPqJJi6pary4yKPgw+a/yUIx4wGrCbDmwe5rWzM781Qt8yZytLjbnLwo422A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=je92C+vaCEDdOR/XKUWIhrnHz48JLykjrcACjyk2a6w=;
	b=v8AShdz93ZZLSE91FMQ+OhZ4PQ6XpeIjcslYMakjDJXaus0Ecn+Vmnp+najkB+HSckZL
	 R+OAcvzUvoyMfFJ3/4u9GgRypxZLeyKe6SFTP7IPUSStrB9PBVZqILkOcDllGseMkgCcs
	 BipZ5i3anZf1/6/x9mi5pAnNsInBJ+nWWL8YlOTO7pLf1u058KiE2vGfz+f7utQyXKjyr
	 FHGrSpq7q9ce3R3FqiCp91GpmoGbtLAQW4QMRfImJtvkpEB4vpAHo1NrxF09sb+c0xCEA
	 2+tCO2lc+Lgzsd9/IABWhvoTki2PX40n9CWfM/DjstLiGVUYljE9eY6wERBC+OYPjWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=yQyiy8JG;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76795606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76795606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=yQyiy8JG
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso3719710f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795520438; x=1796125238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=je92C+vaCEDdOR/XKUWIhrnHz48JLykjrcACjyk2a6w=;
        b=yQyiy8JGeI8HXDG5PrXNl1vm2nYPQNoCkFDZlIu8qDdbqjcjVGPd8HZFXYwyKtV+D+
         JmnwFrQRVxCODoMoo3zoGu51f+y/rHmVBX7sqnz+JVaXVe3k4pzPoj0yUs3Iy08ZSkaf
         m/4mbbNLXIagKVRAzdma5MYyBetnk7VDP0knY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520438; x=1796125238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=je92C+vaCEDdOR/XKUWIhrnHz48JLykjrcACjyk2a6w=;
        b=dujdTrejiTut824zAt9y2oooACFESUQ1hX/rBrRvrnTYm9ra3jPiWMikPyVrQAel+9
         3vuCamg0N1cnCs/cOUTWBHZjr2j3dX+0W5ePxZQhC/llJ1rT3ITLdcs80rdOctz2SVwB
         rL4MQ8pR2c+yRTUDyArl0BRSsp2+i7g0N5dq32tfd3CWrEuapkJkUCSUi10FmtrUqNG4
         KQoewOjB5cb/V6ss9bWE/1Gvmdly7giDVO156HEA30WXjJRi/CzLwXKLHD/8V0BDzOaq
         qa23XP+S2d0srlJrLgmS2dMSPaziBP4XJMZKiRRvS/4s82tLrUUcPBWOPdZWBcjzIRYo
         dnpg==
X-Gm-Message-State: APuU4Z9MqHppfWBLGqI3ZLZ2fOK3sIUfueBToCw3RuBpz5bccslI6/F4
	Z6j0W83gjreoM7qAoZN7hX5OAyCf2PdoKW+pcGCmErIiAiNKGb962vSVYrsIqBwMqnadv08Xx+n
	jejwq
X-Gm-Gg: AZFdTZedZ6BGy/W56PNsSD/xlqOKSAAaXYmeTH1jUNBqGAmEnZc7WGpFY7hXtPJ3E2q
	VCHb/UitLdB/0jhuCHwvbkPISfIQ/NKV/I4OHxrGjZYSNGkLGPiYWdliC23YlS98akdFAJBnpP7
	eWCh7+lmRcF1RIq2fThvJcPb4Ft05T+SKOkT8+YhJj53xAM+M0M5ql9cXIfkxE93WpzAwc+mfAl
	FvUiclNkFtbrOwfgXFtwuW13MNSlCveaap1TDdfGolBW0NEWqToMPl4kU5fy8LOmfhifaoivMcB
	7KYcWTtvpWkJSi3sXZOJ6k1iVY96CYso+WO3Jg6w7aFpLIoPvxjNT72zRgdJrlhA7lUB7CwXTxx
	GVajn+gB61xoLFDiYJ97y6giuAEOupLhwXwkDtGplEykgPtjfkoFwx+PS0IxeMfAagbRmB6/bh2
	Btp0e58wED1VFrvaBWhiJ85Wphhgqy5XckHD/JX+lURlu3yW7zhz0COFJNcvBG8yXCqPOv3e3an
	a6MSdh6/jU6LNz9EORcKlQXZMbk2iVa4vHsWb/s22VY2Nepg/t29p8dMdMZth6fmOh1sq1/zmyC
	aFPS5wbxz9GGVawfWc8n8ZUfec+dtY0GMbqdarA5H8WGbKWxIr8erVIu/RP1voaAmK877s9h
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id 5b1f17b1804b1-4bb88813462mr255174885e9.20.1795520437796;
        Tue, 24 Nov 2026 03:40:37 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm616516115e9.11.2026.11.24.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:40:37 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] Bluetooth: ISO: Don't drop the hold of a closed BIS socket twice
Date: Tue, 24 Nov 2026 12:40:35 +0100
Message-ID: <20261124114035.1698961-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A broadcast source BIS socket that is shut down and then closed while its
BIG is being created drops its hold on the BIS in shutdown() and frees its
iso_conn in close(). When LE Setup ISO Data Path of that BIS completes,
iso_connect_cfm() creates a new iso_conn for it, and freeing that iso_conn
drops the hold a second time.

The first BIS of a BIG is the parent of the others, so the extra drop
deletes it together with them while the BIG is still running. The sockets
of the other BISes get ECONNRESET, and the BIG is terminated twice. The
controller rejects the second LE Terminate BIG. In this capture the first
socket was shut down and closed about 10 ms before LE Create BIG was sent:

    < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
            Handle: 0x00
            Advertising Handle: 0x01
            Number of BIS: 2
    ...
    > HCI Event: LE Meta Event (0x3e)
          LE Broadcast Isochronous Group Complete (0x1b)
            Status: Success (0x00)
            Handle: 0x00
    ...
            Connection Handle #0: 16
            Connection Handle #1: 17
    < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e)
            Handle: 16
    ...
    < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e)
            Handle: 17
    ...
    < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a)
            BIG Handle: 0x00
    ...
    < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a)
            BIG Handle: 0x00
            Reason: Connection Terminated By Local Host (0x16)
    > HCI Event: Command Status (0x0f)
          LE Terminate Broadcast Isochronous Group (0x08|0x006a)
            Status: Command Disallowed (0x0c)

The kernel logs the rejected command:

    Bluetooth: hci1: Opcode 0x206a failed: -16

close() alone does not trigger this: the socket then stays in BT_DISCONN
with its iso_conn.

Fix this by looking up the iso_conn that a source BIS got in connect()
instead of creating a new one. If it is gone, the socket is closed and
there is nothing to make ready. The lookup takes hcon->proto_lock, as
iso_conn_del() does, because the closing socket frees the iso_conn after
clearing hcon->iso_data under that lock.

Steps to reproduce, here with an nRF54L15 DK running Zephyr's controller
(no second device is needed):
1. Run btmon.
2. Open two broadcast source BIS sockets for one BIG (BIG handle 0x00) and
   connect them non-blocking, the first with BT_DEFER_SETUP. The second
   connect() creates the BIG.
3. Right after the second connect(), before LE BIG Complete, call
   shutdown(SHUT_WR) and then close() on the first socket.
4. The second socket gets ECONNRESET, and btmon shows LE Terminate BIG
   twice, the second one failing with Command Disallowed (5 of 5 runs).

Fixes: fdfde532ab1c ("Bluetooth: ISO: fix refcounting of iso_conn")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
Changes in v2:
- Steps: shutdown() and then close(); close() alone does not trigger it.
- Trace: btmon output of the reproduction, which ran on a kernel with
  the Bluetooth code of bluetooth-next as of 2026-10-07 (7.3-rc2); v1's
  was condensed and not from this tree.
- Status of the second LE Terminate BIG as captured: Command Disallowed.
- No code change.

 net/bluetooth/iso.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 06f1e7ba2cb1..fd33a1ec53d6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2680,7 +2680,14 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 	    test_bit(HCI_CONN_PA_SYNC_FAILED, hcon->flags)) {
 		struct iso_conn *conn;
 
-		conn = iso_conn_add(hcon);
+		if (hcon->type == BIS_LINK && hcon->role == HCI_ROLE_MASTER) {
+			spin_lock(&hcon->proto_lock);
+			conn = iso_conn_hold_unless_zero(hcon->iso_data);
+			spin_unlock(&hcon->proto_lock);
+		} else {
+			conn = iso_conn_add(hcon);
+		}
+
 		if (conn) {
 			iso_conn_ready(conn);
 			iso_conn_put(conn);

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

