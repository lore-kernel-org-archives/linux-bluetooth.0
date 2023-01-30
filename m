Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A675C636D6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbjA3SjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjA3Six (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:53 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BA23D8C
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:06 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 541231B0027A
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7x0icnorU2d5QS8/EgbEzJZVUpP8E8+GWy+CNyG/qs=;
        b=oCQi+6d5JrTL/qsPxnK47ZKCG1EGHmOxPgblNBls20lSXQ+Ck4WW33lH9QD9h87XHvpr+c
        SFRbEX9me9d4O3x4UxNhJaZc6/z489RfMoG81DNJ6hTTs0EA52ZE7p+ZlXNJRsg8tTO5Fs
        499Ly3M28AcX5MseDA1TJw1teh8+ISpJ04VP7rlJI+Q2JMgKiwU6frp93svAFEZv9hnNKJ
        8SQlj0NGcPwWAVSeQtpQTZ2goOZW/MX5ZdcmTCgtEHVSVUlhLPsKhCWdCoJ2K+/fAfbGj3
        AYbpG6uIq+6p2cHQZI8/eiNk05X47/p8xTYg5Lw8FSZtvg+iDKl8I8a4Az6gwQ==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 12163203BD;
        Mon, 30 Jan 2023 20:37:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7x0icnorU2d5QS8/EgbEzJZVUpP8E8+GWy+CNyG/qs=;
        b=CNyb5u4sYLno1BP5aaxFvLgj8OF/QsRHzUpGaPcQ3BpSljEcRj8eiGoNIzded8aJuFQcDw
        aBRtCfy1d7l8fZqQWGUjO5TuPg+auTKwKyBxCvidQMlNlccbI+kO32uCUvD/CPud/aTS/H
        r8gzQetDza9UFeo5IJG3GK7CwZxmBjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7x0icnorU2d5QS8/EgbEzJZVUpP8E8+GWy+CNyG/qs=;
        b=KQqJb++6R4wmUgNvHF/twBt4e8PccTVklbRB7SrxGEVE3F1zhl2C0wSQqh0exymALXljaa
        xrdH0dCzkwjIHY4zjs/RzISAFv+mRGWfXrv7s9R9TPwR0Dnfj4illCmhuhpCPgLx4F2QmI
        NTVb9vl1smcPGSZpVU/Ot1JvtpuxE08=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103875; a=rsa-sha256; cv=none;
        b=HrmaksdFFWSCtzZaBgtkKADTyNiSA96mBvVbbkpwryEeO1RIRKAqSTX3lNx6oIhkoB2qSk
        EjOLvN+lcuPde/qAT5iIZAGyobZb1IDRntVa1rJomfs57l0EhiAPdsVZLO4GwQEmTC02qx
        lxRA6nL/naYzgMJ7zeSDBNZ5mp2P5IY=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/8] adapter: add functions indicating adapter CIS capability
Date:   Mon, 30 Jan 2023 20:37:36 +0200
Message-Id: <32554e8adb382a7e5051f09cd06ca4e0dfe1f86b.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c | 16 ++++++++++++++++
 src/adapter.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index aadad4016..4f06bce53 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9033,6 +9033,22 @@ bool btd_adapter_ssp_enabled(struct btd_adapter *adapter)
 	return false;
 }
 
+bool btd_adapter_cis_central_capable(struct btd_adapter *adapter)
+{
+	if (adapter->current_settings & MGMT_SETTING_CIS_CENTRAL)
+		return true;
+
+	return false;
+}
+
+bool btd_adapter_cis_peripheral_capable(struct btd_adapter *adapter)
+{
+	if (adapter->current_settings & MGMT_SETTING_CIS_PERIPHERAL)
+		return true;
+
+	return false;
+}
+
 void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
 						struct oob_handler *handler)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 78eb069ae..3fcee30bc 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -226,6 +226,9 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
 
 bool btd_adapter_ssp_enabled(struct btd_adapter *adapter);
 
+bool btd_adapter_cis_central_capable(struct btd_adapter *adapter);
+bool btd_adapter_cis_peripheral_capable(struct btd_adapter *adapter);
+
 int adapter_connect_list_add(struct btd_adapter *adapter,
 					struct btd_device *device);
 void adapter_connect_list_remove(struct btd_adapter *adapter,
-- 
2.39.1

