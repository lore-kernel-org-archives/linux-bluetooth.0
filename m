Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2BFC636CD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BDC61183
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhGRPjo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jul 2021 11:39:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:51383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhGRPjn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jul 2021 11:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626622602;
        bh=BgmVAD6kQePhUvQNif1bc8lY91CsAoONyYzXjsFONis=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Gt7yH71jOitZgFlDaeBbpkSPi1vS8fapl3iLlNLWetohQnCsLrDaN0CI6aFwVZBoA
         73dyMYkS+MoLIoCb4DrylVUw/GkA0psmGdcNuQfmqr9umBlPQN0w5YVLv7QwMZLv/I
         vHZKWgVG7pfku/rgBc++jYyeQTzsWV5q7VODul4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mof5H-1lLOuR2fwP-00p3CF; Sun, 18 Jul 2021 17:36:42 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] drivers/bluetooth: Remove all strcpy() uses
Date:   Sun, 18 Jul 2021 17:36:26 +0200
Message-Id: <20210718153626.18382-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pnlRtIpPSD8E8+0dK8xsXGYaM6qJq363xXDdVrNqbI/2gQ+DNM/
 R3/kIeJ2sr+jnUSftacP5xgOlparNV6mXNLnPWRGBxzYuHpGh9n6PpLn8+BETRLbOB++xF7
 gY8Fonr+BBkdR06JNXLhbvxXassiKLAgRQaMmzJ7+bn1traPAzNR+HyQM0gMLzSheyU2rMs
 YpErU+yeG+ptbrFNTsSZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tyTsSvmv35o=:WVSUZkX3DlAOfVYr2CJKM5
 0qWeKBKVjW/UYrTlWpM+d4UPuRo4UxZ4ho5StsWBCjW7nz++0/UCJfdaQsuzG3/3HE5Uyo0vV
 UDJMip3E7tIz3pimGSWu8k6Qd/7qTotowAyV154F3SDwcH4JJSU60UT4ikHH9QEBiuuY+wcnw
 NKgqiEsQWafhUxntF+SG/GkMIBmGuoY3K83U4oKvyjdL7gF3LjI7TanLaMQLrjMGvsn+KpEpx
 dUqN5uOzvs1nrmrHzeYc07JlFFfIcg5071+NSk3R0G7unWiwCp2kcLZhUxmQVIwQIvVnGBjfK
 P6xYt4FWyGh2yqx8fvhSOYwdHEx+vpmWTeyveq06v6F9MV6M9Aj+wyuCrdtHWdroMfJ7GoAPH
 JKoHR4krXK2cSrQYY9VNhfXOZhW1HpiNQgIm+PyaHJhtKFnB4Ew4k+Q6xDKjWbsHHsgtZct5Y
 50CGrMY3MZevcAZg9E/NhfuZcRfbZ9OZNWZxVjdgWZL39K0AhWrwRLV13W00gevQmjl/BQiDs
 Ie5IAcCKqeqJ9dY8H0OUtbMXzeFN1gw82nL5g+6OG1DxdUxRdgN3GBK0S2iUfwQBISrDIcvLI
 xYCnWOA0HiRf5KmUHXn8cFNPw9ey01e9cIH000BgGjF2G636xyFZunLod9R0rpamjH+7h3SbV
 FJ8r76V+tMS+jpoZMAgpS3VGuusaYmer128u2ydLZY9CZF1gVlPps3bFA57s9ZL6CKZCMz193
 GMgXiaUUQX6UdGmzGMkdQtoEAbDwLlDMkV/EwzG7tZ1l8blD1hab8+hnU+6S0fKj4cKVY7ron
 VcFaUI2DQdB7Ol47CSe88jHkDsR8cJrNWKpZKwNX0VXwlWpXxuxBuxGpnZwBp/swfO6A8sbnZ
 d/8ZRAtPOZooL83tJAtXDceqFKObK9X0NRMmMpMmLVQptDd9u95gApHk26Kr7raa+WjicZi1h
 XLfYKRPAN82U5OhEqpn4DuMvAGX1qMk2S/mMcPAwujvccP0zYhKstuYhzjncPuMHWEbttzbfD
 jiMdfFxxhQ6SHGG+NbnfVuC/Fe7bH7HN0fPTf1UJgz1MmPpTlAFTH2v6k0lDUCbNgeHB97j6F
 R0mveSze4IMd9NgFLNcAKTT6kUYUetG48rO
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy() but in
this case it is better to use the scnprintf to simplify the arithmetic.

This is a previous step in the path to remove the strcpy() function
entirely from the kernel.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/bluetooth/btmrvl_sdio.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sd=
io.c
index cddd350beba3..d6674b367e05 100644
=2D-- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1350,6 +1350,7 @@ static void btmrvl_sdio_coredump(struct device *dev)
 	u8 *dbg_ptr, *end_ptr, *fw_dump_data, *fw_dump_ptr;
 	u8 dump_num =3D 0, idx, i, read_reg, doneflag =3D 0;
 	u32 memory_size, fw_dump_len =3D 0;
+	int size =3D 0;

 	card =3D sdio_get_drvdata(func);
 	priv =3D card->priv;
@@ -1493,20 +1494,18 @@ static void btmrvl_sdio_coredump(struct device *de=
v)
 		struct memory_type_mapping *entry =3D &mem_type_mapping_tbl[idx];

 		if (entry->mem_ptr) {
-			strcpy(fw_dump_ptr, "=3D=3D=3D=3D=3D=3D=3D=3DStart dump ");
-			fw_dump_ptr +=3D strlen("=3D=3D=3D=3D=3D=3D=3D=3DStart dump ");
-
-			strcpy(fw_dump_ptr, entry->mem_name);
-			fw_dump_ptr +=3D strlen(entry->mem_name);
-
-			strcpy(fw_dump_ptr, "=3D=3D=3D=3D=3D=3D=3D=3D\n");
-			fw_dump_ptr +=3D strlen("=3D=3D=3D=3D=3D=3D=3D=3D\n");
-
-			memcpy(fw_dump_ptr, entry->mem_ptr, entry->mem_size);
-			fw_dump_ptr +=3D entry->mem_size;
-
-			strcpy(fw_dump_ptr, "\n=3D=3D=3D=3D=3D=3D=3D=3DEnd dump=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
-			fw_dump_ptr +=3D strlen("\n=3D=3D=3D=3D=3D=3D=3D=3DEnd dump=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
+			size +=3D scnprintf(fw_dump_ptr + size,
+					  sizeof(fw_dump_ptr) - size,
+					  "=3D=3D=3D=3D=3D=3D=3D=3DStart dump %s=3D=3D=3D=3D=3D=3D=3D=3D\n",
+					  entry->mem_name);
+
+			memcpy(fw_dump_ptr + size, entry->mem_ptr,
+			       entry->mem_size);
+			size +=3D entry->mem_size;
+
+			size +=3D scnprintf(fw_dump_ptr + size,
+					  sizeof(fw_dump_ptr) - size,
+					  "\n=3D=3D=3D=3D=3D=3D=3D=3DEnd dump=3D=3D=3D=3D=3D=3D=3D=3D\n");

 			vfree(mem_type_mapping_tbl[idx].mem_ptr);
 			mem_type_mapping_tbl[idx].mem_ptr =3D NULL;
=2D-
2.25.1

