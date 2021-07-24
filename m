Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8301DC4320A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DDB60E97
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 12:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhGXLll (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 07:41:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:50909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhGXLll (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 07:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627129330;
        bh=+TaYaR257ozdshQtS3WXdm4kpGQ/mYuT4adntj9dZDY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bT9i9lP/InlqryozYGyHe4lmQHhXjUlvWRRMaUpGg4OCcUA/vFIiuNGdBq51WhQ5Z
         1JgT4+bA4f5okfTR34YelgzLESEyeqcKiJEVXF61uIC09ndFU3edDy/JDtDHoHMbu+
         QgCRddmwVNnoLrSS41sQECl2+BYGwJnNBv9CswlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M6DWi-1m0h5e0o1I-006gAx; Sat, 24 Jul 2021 14:22:10 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>, Adam Sampson <ats@offog.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] drivers/bluetooth: Remove all strcpy() uses
Date:   Sat, 24 Jul 2021 14:21:52 +0200
Message-Id: <20210724122152.7133-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hm/ltCsIDwdfostYMasJW+pVyd6MwCTeYo7M76GOcqZWmlJx65k
 iJrCA36FnpXehauOo6MZUu593MJwh0Mc+gnHGGgOswqVsDcF1jFwH8UCeTM+kR6Q8JL4Agt
 JPULsIfNDK5PyjfE+HcYLsGffN5NLI+6Au2eqW5Rl8i5h/7Bc1XyEUslK2jbBXGEHGyB4Ub
 YPKJDZoS5Iv7t8RboZ0+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u08/bVCs2Ew=:V8u3M2AOPSIWZn0otgm7Tz
 iKQMhvkF5FdURooAExnnfd4YL2eeocfZckFgPSmx79pjr9yqK0FWOPxP6JNYZpD7hFuArBAoU
 GJ+tDAaPhGCRIEvBzTz5UlKILfKsJ5DSnjU19jcHPv0wrarpexPZTggx/cwrTqDCohSNRCPIE
 2csIoYpnPftArqUfK7CuTpMIy+w4MY0fIFNer2c58dUQweesjwzYULqWnluQGg4UbvUPXxbNd
 JrswwG8n6BAZNm81+AmG9s2uRDnMTzaF8/XGIYWJiAwA1aKFN4F7E3QP8BQIvMPFs1pWR1rGW
 cDhBiKidzKZX5TTk14Z5YRnCqtzVoXn2faaSam0LDSCgcSvJWMI0USPUEardujmIYn3uUc2Bs
 AzFOA56kh5AHycnRQhIr+G0SAgQDME3y10M61vlB4glx5t/F9gAhvj7rJ4C+EBi5qNzhClr/S
 auWtLdmKLb3PANr08rGfyaFBSiZq80uIlg6EmYkPrBWhXz0dO8PoS6E2JAB312B2+DQwz9j0l
 7YkTFqCOSdGlBaeAJGNgzBjWqv8EKr+VjIBVKdE4xd7RGo3jEkqnPfeJfGMakTZSG45vCHz2d
 tdINvwfLa7plyVGITyWiVZB0ZcBqc3P6dYT69tZboCcvoYuDPp3ENjCriZqsZBi+sU4fvtts9
 RgsUOLAPzfdtEqEwYPYguPGgd4qgbuHjuU1o1bF4D7YtwKnXLdqX0SWqT6gG5MiBVeevLUYMP
 toJPAA15O68Nr/87/A8yyq8sw1mPkCkzfzNpZr379nCuIJCk/HJREhdL/olJATbnE8zT5TTCO
 wKH9zn+Xvu7Cou62GP0C2amZ3BLsdbYe+XZfp+QdACPZZ+kNXbrjUSbE9uHuis4V846rIUuOa
 zKRQlq0c3vO2GGgE5zDhaTVd/arG7I9VUmVQ8Y2TrmfcPgLakMb6gIE68JbZEZvYjNLMcAFZ7
 /jBXmFTUZOrOupm74HBa5fDf3cwsdNrcE6OwEjNcQ11Qh8At1f4YkT1w4v/xXViGPkvC2bvgW
 tNpw+QMHowQJ1mRw12y6ugTH0+ESdH2ioO7eyQYAH51yULMGd7a3ZPKEzt3khqI1MHpAUVtyk
 7tFEpWwOrA0l7XtoIqNVSVM88lxARD/gbQt
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
Changelog v1 -> v2
- Add spaces to the "plus" sign.
- Use the correct size for the fw_dump_ptr buffer (Adam Sampson)

 drivers/bluetooth/btmrvl_sdio.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sd=
io.c
index cddd350beba3..68378b42ea7f 100644
=2D-- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1350,6 +1350,7 @@ static void btmrvl_sdio_coredump(struct device *dev)
 	u8 *dbg_ptr, *end_ptr, *fw_dump_data, *fw_dump_ptr;
 	u8 dump_num =3D 0, idx, i, read_reg, doneflag =3D 0;
 	u32 memory_size, fw_dump_len =3D 0;
+	int size =3D 0;

 	card =3D sdio_get_drvdata(func);
 	priv =3D card->priv;
@@ -1478,7 +1479,7 @@ static void btmrvl_sdio_coredump(struct device *dev)
 	if (fw_dump_len =3D=3D 0)
 		return;

-	fw_dump_data =3D vzalloc(fw_dump_len+1);
+	fw_dump_data =3D vzalloc(fw_dump_len + 1);
 	if (!fw_dump_data) {
 		BT_ERR("Vzalloc fw_dump_data fail!");
 		return;
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
+					  fw_dump_len + 1 - size,
+					  "=3D=3D=3D=3D=3D=3D=3D=3DStart dump %s=3D=3D=3D=3D=3D=3D=3D=3D\n",
+					  entry->mem_name);
+
+			memcpy(fw_dump_ptr + size, entry->mem_ptr,
+			       entry->mem_size);
+			size +=3D entry->mem_size;
+
+			size +=3D scnprintf(fw_dump_ptr + size,
+					  fw_dump_len + 1 - size,
+					  "\n=3D=3D=3D=3D=3D=3D=3D=3DEnd dump=3D=3D=3D=3D=3D=3D=3D=3D\n");

 			vfree(mem_type_mapping_tbl[idx].mem_ptr);
 			mem_type_mapping_tbl[idx].mem_ptr =3D NULL;
=2D-
2.25.1

