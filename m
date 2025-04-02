Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5E1853
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579177; cv=none; b=nROFHL9i2msNiOApdkSSZ09EizwbWO94so8QLpA7ojEtMrQYmshsQtqVq0Z0d1VZ3V66hlMUbF6GXq+nbWexXa/jOEdoq/KERNPk5ps9Ya7HHBqv7Lus+35CTbUjL0Olb0jvG1panMb0XScv9UGjl+bU3Pp+5Q9oaANCbRNwI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579177; c=relaxed/simple;
	bh=QyztU5i9bTtLMsXOND8EIKo41Vt1DUzUhvoSSNtJQ74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OBQjG3h3ZQhInQhWZaC/hERa/g3p+jfPrOh6LOaJRoWTd3YyZXil3+Fj7vKQdvRdDY1U81iExHENMy9V4fblyRKB1jtqeEBue/abCjCnCBu+vWqzabE8fqy/t4Q2besmv04Zis5mAAWsCEmqhdFagCWKdtUR08GWHZkqrdNDOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR+S6SCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR+S6SCp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D65FDC4CEDD;
	Wed,  2 Apr 2025 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743579176;
	bh=QyztU5i9bTtLMsXOND8EIKo41Vt1DUzUhvoSSNtJQ74=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pR+S6SCplkMT6Bv1i0TcCAO8vebAPTBp3HWepw5rETcOb1SuqL4rmC21Ed9o9MvWz
	 ATyrnLFi5fhAwBM4HQP15I1NN4su9IseAqk5XVObDDkElx/548rJqOQfOW+30Nt8E2
	 Bfaibn9lFhPpxG+0Hl5BdGLAAQofES1QZDEggSLzYWvQviOgplShKzCYWOUDHOkBZ6
	 1zQB+8c49zyLUpEQ4wF51lU18ZL3d1aLFd9dy+UYP4d7tgyTQrvYMAKcNDY4ovJv+n
	 EcsvbzgI6IACx2BF3kUP2N8n+VcwZ9K9/QaL6pGDOU5aLGAL62x3ONX6ZAiSssEeDv
	 XSFQLpgV24GnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7DC28B20;
	Wed,  2 Apr 2025 07:32:56 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 02 Apr 2025 15:32:54 +0800
Subject: [PATCH BlueZ bluez] bass: Clear the temporary flag of the BIS
 source device
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
X-B4-Tracking: v=1; b=H4sIACXo7GcC/x3M0QpAQBBA0V/RPNsaG6v8ijzsMJjS0k4k2n+3e
 Tx1uy8oR2GFrngh8iUqe8ioygLG1YeFjUzZYNE2WKM15FWNcxaRqGXyFeT0iDzL/W96oO3kB4a
 UPh8Hc5hdAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743579174; l=922;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=QSfYmm2mgc8SYKsTlpsDr1wat08xLba+iuzY6AJMKU4=;
 b=7xWSjt34nTUaIld//3ahEY+YUCh57SaFo1rGnPpwGz6tKjU/LntePK0pJglWX7MCiUjDfKGjL
 YstMXAXn4ZQB3BdXtYndBpAtOXUfbsSvc8CAjZKXObIC2+YvLvoJhsI
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When BIG sync succeeds, remove the temporary timer. Otherwise,
the device will timeout and be removed, triggering the automatic
termination of BIG.

issue: https://github.com/bluez/bluez/issues/1144

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 profiles/audio/bass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index c36f43277..99f1decce 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -565,6 +565,9 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 	g_io_channel_ref(io);
 	dg->io = io;
 
+	/* Clear temporary flag*/
+	btd_device_set_temporary(dg->device, false);
+
 	/* Update Broadcast Receive State characteristic value and notify
 	 * peers.
 	 */

---
base-commit: 6d20a300642f312290af0bc9869a0e1b416c58dc
change-id: 20250402-bass-66200bb7eba1

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


