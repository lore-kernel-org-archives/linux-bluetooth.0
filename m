Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0102C12002
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC47161005
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGOBNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGOBNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 21:13:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140BAC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:10:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 62so4358422pgf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YoKr/Pqdy8ER5rFYwXCCTJh6avldbNPa1f0IpeH8WGY=;
        b=S2VlYM24nC0DTElbYtLGQN5W97y7cOim6OJmAtVNIDO0ohlk/NbrCHN/IwtPobUZff
         jAwCwxYgIjSNknzcPdnCTk+ZMT3vFtJpkmJgbBDqBsJnjnAo844jYOAFo/oXPec0J1wf
         PBlv4i/ml75EZGFw0ILMIUMk2Fo1Y8yXDrq9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YoKr/Pqdy8ER5rFYwXCCTJh6avldbNPa1f0IpeH8WGY=;
        b=NmtCTbMkC5sn39uwFw0SOKvWiF9tgD91n9co3hijjEb6rP8uAUoqcW3ho1KxAgkrBg
         L7RnodWgR12LAMrxbORPA2Nmd8E7kfGGr0t148cuJKFEvZbkHMijM9yGtQ5Qo5w1A9mM
         JbwXvRNxgzrkeqIQwzz5w652QcLuSzEZX0kWv2DSyciE/TTC9acdGT3iN8WmoiOGpGYV
         PO+i6hgsCNWoeUwMJG/oDPF7/j+jHyrlozkx/yOTABwEtgp85S+bXmW/GbkVH0HHPjfm
         8juZUwms6wl7BiEBtTr1aGuzIPFpY77nACxEfKi4jh4xyjR7dzu60BBS/UhvufJJXbO1
         HKZg==
X-Gm-Message-State: AOAM530bFyxmAyaW/s44LasdSYo1n1n9mdRCr6PUjNyYzTAOBGca60s+
        OC2aKa6+aYhIJsEpsDEyy5fOvwrSx/ZvTQ==
X-Google-Smtp-Source: ABdhPJxbUKkDjjXPWhdjyZtXDEJ9YZILiJXCb/AXFP9Ni3OSDfjcMy5C4hTnTlDskVeLr8cGJe1bIA==
X-Received: by 2002:a63:f44e:: with SMTP id p14mr907444pgk.143.1626311441292;
        Wed, 14 Jul 2021 18:10:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:20b7:5dcc:d530:a8df])
        by smtp.gmail.com with UTF8SMTPSA id q21sm4124229pff.55.2021.07.14.18.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 18:10:40 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 1/4] doc: Add error-codes.txt to describe error codes of D-Bus method returns
Date:   Wed, 14 Jul 2021 18:09:49 -0700
Message-Id: <20210714180917.BlueZ.v3.1.Ide6362da19898d001b053656ee8bf76e183633d8@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210715010951.963176-1-mcchou@chromium.org>
References: <20210715010951.963176-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

(no changes since v1)

 doc/error-code.txt | 266 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)
 create mode 100644 doc/error-code.txt

diff --git a/doc/error-code.txt b/doc/error-code.txt
new file mode 100644
index 000000000..af8300467
--- /dev/null
+++ b/doc/error-code.txt
@@ -0,0 +1,266 @@
+D-Bus Method Return Error Codes
+===============================
+
+The motivation of having detailed error codes is to provide context-based
+failure reasons along with D-Bus method return so that D-Bus clients can
+build metrics and optimize their application based on these failure reasons.
+For instance, a client can build retry mechanism for a connection failure or
+improve the bottleneck of use scenario based on actionable metrics.
+
+These error codes are context-based but not necessarily tied to interface or
+method calls. For instance, if a pairing request failed due to connection
+failure, connection error would be attached to the method return of Pair().
+
+BR/EDR connection already connected
+===================================
+	code:	0x0001
+	errno:	EALREADY, EISCONN
+
+Either the profile is already connected or ACL connection is in place.
+
+BR/EDR connection page timeout
+==============================
+	code:	0x0002
+	errno:	EHOSTDOWN
+
+Failed due to page timeout.
+
+BR/EDR connection profile unavailable
+=====================================
+	code:	0x0003
+	errno:	ENOPROTOOPT
+
+Failed to find connectable services or the target service.
+
+BR/EDR connection SDP search
+============================
+	code:	0x0004
+	errno:	none
+
+Failed to complete the SDP search.
+
+BR/EDR connection create socket
+===============================
+	code:	0x0005
+	errno:	EIO
+
+Failed to create or connect to BT IO socket. This can also indicate hardware
+failure in the controller.
+
+BR/EDR connection invalid arguments
+===================================
+	code:	0x0006
+	errno:	EHOSTUNREACH
+
+Failed due to invalid arguments.
+
+BR/EDR connection not powered
+=============================
+	code:	0x0007
+	errno:	EHOSTUNREACH
+
+Failed due to adapter not powered.
+
+BR/EDR connection not supported
+===============================
+	code:	0x0008
+	errno:	EOPNOTSUPP, EPROTONOSUPPORT
+
+Failed due to unsupported state transition of L2CAP channel or other features
+either by the local host or the remote.
+
+BR/EDR connection bad socket
+============================
+	code:	0x0009
+	errno:	EBADFD
+
+Failed due to the socket is in bad state.
+
+BR/EDR connection memory allocation
+===================================
+	code:	0x000A
+	errno:	ENOMEM
+
+Failed to allocate memory in either host stack or controller.
+
+BR/EDR connection busy
+======================
+	code:	0x000B
+	errno:	EBUSY
+
+Failed due to other ongoing operations, such as pairing, busy L2CAP channel or
+the operation disallowed by the controller.
+
+BR/EDR connection concurrent connection limit
+=============================================
+	code:	0x000C
+	errno:	EMLINK
+
+Failed due to reaching the concurrent connection limit to a device.
+
+BR/EDR connection timeout
+=========================
+	code:	0x000D
+	errno:	ETIMEDOUT
+
+Failed due to connection timeout
+
+BR/EDR connection refused
+=========================
+	code:	0x000E
+	errno:	ECONNREFUSED
+
+Refused by the remote device due to limited resource, security reason or
+unacceptable address type.
+
+BR/EDR connection aborted by remote
+===================================
+	code:	0x000F
+	errno:	ECONNRESET
+
+Terminated by the remote device due to limited resource or power off.
+
+BR/EDR connection aborted by local
+==================================
+	code:	0x0010
+	errno:	ECONNABORTED
+
+Aborted by the local host.
+
+BR/EDR connection protocol error
+================================
+	code:	0x0011
+	errno:	EPROTO
+
+Failed due to LMP protocol error.
+
+BR/EDR connection canceled
+==========================
+	code:	0x0012
+	errno:	none
+
+Failed due to cancellation caused by adapter drop, unexpected device drop, or
+incoming disconnection request before connection request is completed.
+
+BR/EDR connection unknown error
+===============================
+	code:	0x0013
+	errno:	ENOSYS
+
+Failed due to unknown reason.
+
+LE connection invalid arguments
+===============================
+	code:	0x0101
+	errno:	EINVAL
+
+Failed due to invalid arguments.
+
+LE connection not powered
+=========================
+	code:	0x0102
+	errno:	EHOSTUNREACH
+
+Failed due to adapter not powered.
+
+LE connection not supported
+===========================
+	code:	0x0103
+	errno:	EOPNOTSUPP, EPROTONOSUPPORT
+
+Failed due to unsupported state transition of L2CAP channel or other features
+(e.g. LE features) either by the local host or the remote.
+
+LE connection already connected
+===============================
+	code:	0x0104
+	errno: EALREADY, EISCONN
+
+Either the BT IO is already connected or LE link connection in place.
+
+LE connection bad socket
+========================
+	code:	0x0105
+	errno: EBADFD
+
+Failed due to the socket is in bad state.
+
+LE connection memory allocation
+===============================
+	code:	0x0106
+	errno: ENOMEM
+
+Failed to allocate memory in either host stack or controller.
+
+LE connection busy
+==================
+	code:	0x0107
+	errno:	EBUSY
+
+Failed due to other ongoing operations, such as pairing, connecting, busy
+L2CAP channel or the operation disallowed by the controller.
+
+LE connection refused
+=====================
+	code:	0x0108
+	errno:	ECONNREFUSED
+
+Failed due to that LE is not enabled or the attempt is refused by the remote
+device due to limited resource, security reason or unacceptable address type.
+
+LE connection create socket
+===========================
+	code:	0x0109
+	errno:	EIO
+
+Failed to create or connect to BT IO socket. This can also indicate hardware
+failure in the controller.
+
+LE connection timeout
+=====================
+	code:	0x010A
+	errno:	ETIMEDOUT
+
+Failed due to connection timeout
+
+LE connection concurrent connection limit
+=========================================
+	code:	0x010B
+	errno:	EMLINK
+
+Failed due to reaching the synchronous connection limit to a device.
+
+LE connection abort by remote
+=============================
+	code:	0x010C
+	errno:	ECONNRESET
+
+Aborted by the remote device due to limited resource or power off.
+
+LE connection abort by local
+============================
+	code:	0x010D
+	errno:	ECONNABORTED
+
+Aborted by the local host.
+
+LE connection link layer protocol error
+=======================================
+	code:	0x010E
+	errno:	EPROTO
+
+Failed due to link layer protocol error.
+
+LE connection GATT browsing
+===========================
+	code:	0x010F
+	errno:	none
+
+Failed to complete the GATT browsing.
+
+LE connection unknown error
+===========================
+	code:	0x0110
+	errno:	ENOSYS
+
+ Failed due to unknown reason.
-- 
2.32.0.93.g670b81a890-goog

