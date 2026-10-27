Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110209;
	b=Ovse8PsoxC+murDWyrDRJc3ee9wLmm0HdVm1sMivxVCYbe8+XbW1eD0H2r9BYddufcuu
	 4NwjfwQsCKfjZiqU7KDq8oK00MwTYDjodzi+YD2Ux/UmJaqNWIaIAMoeqenFj5SENAVar
	 pur4AKpRWEtyjY5dTwi0jnbRvN0uwpWqj7wenjZJX8Lj7m2Ix7sYGI7Fqmx2qXe0D70YJ
	 0wTVBlminTNErI2yFff8i02JPrlwBwCBbs2nVaQ+kYf4eaoCubgASs2brsuMa/v+SvCmR
	 VdkkPJ1kQmDuWEcYgUAdH4MyxkDv+n4cBJuCM7YFlWQIdDx61pBXa8riCK688LeHrUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=P1Xz/23paKb2n9oF3nn0oThYUOv+TGOM0zTaFsPgXw0=;
	b=a/KSqDSy1ArhJdllBp42gLsY5NekRXxdUuo4HqLgQQtoMv85Um0mQo12B6CkU7dEBBw7
	 ss399tCUL31p0EoTUzfDPiZyBsw8jrBLmSynzmCcW/BabzvBHvEcYRitiE8BU0agjokNR
	 IctDvc4RDt8002uE961jeNkUUBoYP+6RXDYU7qufsYIMYbEiOTyG3ndBcD47cHRNl81PJ
	 Y2+1Y83swBovIcM7yvQW7ky3C/JW670gAfZnmXY9QVf6v5BF8G5Wg0RuRdK86erTWKNNb
	 DHd7dHTnAWALm/Qe5VMJ1IMEOvqAHh4wkeEOxx1LZ7HDcAKYJCCPtxlnd+FVZmt1kQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="aU5Db/6k";
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A5606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D0A5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aU5Db/6k
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eafa528803so1491885e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793110207; x=1793715007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1Xz/23paKb2n9oF3nn0oThYUOv+TGOM0zTaFsPgXw0=;
        b=aU5Db/6k/PKRQpHgdaWIh5JP7cPoejc9jPNYH0K+/XmLfDtF5sKS1Eqii5/5Xst/Q8
         U7qWTAo8idOk3mjxyAduAkWIY7S7yj5AesZiOz2ERQFQ8x0644vlX+N4jlbz1pJkUhuC
         bJ+Zl26YGSXFCssVeGR3EQV3GjVEXprhRDxVtOSdokilRzFYCxVrf+ghnmlWWIkRUEKO
         7NUM4njitqBoqus87cqHdqqUsFV12bucNdt+TLvgjI3z4priXN4mzp4GnG/jbxtDSIgU
         +pKbDRTPoACcrMw0y1gYEIebGv8sKOUGia16ODdorwCPduzflPI4o+VFrlhNKerhCdoh
         rAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110207; x=1793715007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P1Xz/23paKb2n9oF3nn0oThYUOv+TGOM0zTaFsPgXw0=;
        b=RlJKzHSrOJfbvtFg/2E6canICAsT29YeyqJh9IJ35GOjhy92ZNEKFGk12h3m6HQo/X
         Ay/jI/9jHW72n7GQVyqdVtjrLS5r0ke19Vi8frzteliexr9rQGqLVMLY+LLaM0rkB40J
         LBcCInUy4RVz85u0AVOdOIDQnrK0wpwlP9GSj4iO1SVt5yZoRA7Xvd/alY6D/PUVFLOY
         o8nzDQKQ+YUfa6N1Mb6E70QZm9nxu2z7yN/kBwpUCg+Tbz1hGXzEY8P62oznST9md9kV
         JObvrB/qX+Tgd32pfFb7Moce3Aqrm0wNcf9IpllMgEbaLwBp5yQkFi78nLWKrs3TufQP
         pjoQ==
X-Gm-Message-State: AFq9FYJPTaYW/kAAP0ixuHJo7vFWB0OL8JBBq5XpC5KhlUi1KEF4sMKk
	hbJn9b5rlGfsOa1agnT31Kpb+OqIEkvzKkciQktxdveuIdpBNb6trGiSMk0aOw==
X-Gm-Gg: AYBFou0X6x51rL13sZxl0wsjHhPmpFbixAkjq6PmsEHPx0qZmgdW9zYcYrL4Zh74bff
	VDgjDPK80sHTgRuNy3A58LQvZ3wBo5fcWksRmjDEA+Lu07VelK5FWh+FT4JHU8tiS2hCMVcmmNZ
	bNfTemnTx1Ne3r8QxCCqf1WEbc5Yp1K5RQ0hstZaKnN1KfLgMWhjvSnNLNLVZy7bNCE6o6k37+j
	V1+THqwRom4tGMKNLtUt+6R2aus/O8Zw1HSSccFOUG0ZzEKR4XcQ49FH/cR5RK+Fm2/EGKwiUyU
	aQmKdFTg5tZ+Lv44Q4QnI/Z+BcEhkD5wovzyvYJL8Y38xKRBg+g2tNIYtwVZ0lgxuMIXXROQLUb
	3UNlgvTDv8Zhy3tldSGjm6jUYPfUHW9ZIJ9iYAO1JypXzOckuVxTXthR69W5o/ZHifkdI9jFMlI
	aPcistSqYD3va6z7ZN7w85kNkM57t12XF1liqVlQgm31a+SzmyDLPMlZnmG1ri9pNCtHuHR+v3U
	/sxuebW+buJUxOyxcWnEwvX7p53w+BDorGRJmAzc+hwY2ZrMMV9+kayPvdhZgfSujTUEoB9vZjQ
	IwoKznwhpC0d+fde0n/EPem9wwE1GREaaps3VGRJV+vz3Q==
X-Received: by 2002:a05:6122:62a6:b0:5d4:dd7c:b22b with SMTP id 71dfb90a1353d-5ec2327bd3cmr3857916e0c.12.1793110207099;
        Tue, 27 Oct 2026 07:10:07 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec23427e92sm11837223e0c.9.2026.10.27.07.10.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:10:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] ranging: Issue CS Security Enable based on the ACL role
Date: Tue, 27 Oct 2026 10:09:52 -0400
Message-ID: <20261027140953.1854740-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CS Security Enable was only sent when the CS Config Complete reported the
local role as Initiator, and a CS Initiator that is the Peripheral of the
ACL moved to CS_STATE_HOLD, dropping all further CS events.

The CS Security Start procedure is tied to the ACL role instead
([Vol 6] Part B, 5.1.23: "The Link Layer of the Central initiates the CS
Security Start procedure", and [Vol 4] Part E, 7.8.133 disallows the
command when the Controller is the Peripheral), so send it whenever the
local device is the Central and wait for the event otherwise.

Fixes: 20cc88874d57 ("profiles: ranging: Add CS Initiator cmd and evt handling")
Assisted-by: OpenCode:claude-opus-5.5
---
 profiles/ranging/rap_hci.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index c472cedc9830..fee769e9b438 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -983,14 +983,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	cs_set_state(sm, CS_STATE_WAIT_SEC_CMPLT);
 
 	/* CS Security Enable may only be issued by the BLE Central */
-	if (rap_ev.role == 0x00) {
-		mapping = find_mapping_by_handle(sm, evt->handle);
-		if (!mapping || !mapping->is_central) {
-			error("CS Security Enable skipped: not BLE Central");
-			cs_set_state(sm, CS_STATE_HOLD);
-			return;
-		}
-
+	mapping = find_mapping_by_handle(sm, evt->handle);
+	if (mapping && mapping->is_central) {
 		if (bt_att_get_security(mapping->att, NULL) <
 						BT_ATT_SECURITY_MEDIUM) {
 			error("CS Security Enable skipped: not encrypted");
@@ -1001,8 +995,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		DBG("Central,encrypted: Sending CS Security Enable command");
 		rap_send_hci_cs_security_enable_command(sm, evt->handle);
 	} else {
-		/* Reflector role */
-		DBG("Reflector role: Waiting for security enable event...");
+		DBG("Peripheral: Waiting for security enable event...");
 	}
 
 	/* Send callback to RAP Profile */
-- 
2.56.0

