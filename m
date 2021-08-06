Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138ADC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA19611C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhHFXsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 19:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhHFXsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 19:48:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1603C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 16:48:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so24935356pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/v5YdSfSK2NlCQR8nRqLSC6Gwz4x10pGtcYt2DDgWzA=;
        b=FYmiSXHrlH5gxkav1GdecMB2tso0ZSGmofm4bA5P+5m1O8CE1Cw71rq6Alt8L4gKlE
         qB+ivtrPo1471WQV1eBC+0bP3S5DGYaVcKXblAyDrImLkCutVYoUjQMsGIheXvQ/PDp2
         Ee545AcqB7byUbD8ffud8D3uwqvIzNTaBJKuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v5YdSfSK2NlCQR8nRqLSC6Gwz4x10pGtcYt2DDgWzA=;
        b=h7LCc6luckC37X8VOrNS6QrKxa5xfYbBhBVcpFTIfunyPqYYZ5VT3k86KkZIm0lbh3
         vZ90vHJzxG8NXIwL0vCvSmXcxcbz0Z+KMUXYi9Xy5mIaKFuL3F295O197zfMP1S+Av+d
         V7sdLVXSCMOMF+DznElGt/s7Oqo89p9qXuV+MvyO6N23QQzn9KiPKnBxR2CYm6cJjSIm
         OPemo0KLJPjnzi1xnL4ZJpCvEfpA3DX4JTBobpBOvhhbAtakh64b/ohzC5puDZl0IYFC
         vhGpnpziI4NKu11xTIenR4NEfbF+Lf9wB1y8LuXUiAZDftgKtaLR8LNC3ACk9KXeD1jb
         HCvA==
X-Gm-Message-State: AOAM533OCpN3oTh6chl93RsIrWv2vARXwIY1M/9DBTUq/Sckm214ilGl
        6EfmSdLJoH3D9WEz0h6kI8Gi0gDs7ontHw==
X-Google-Smtp-Source: ABdhPJxnoiyehVbkFhDguOe0BY/gzgxNdsbTJVYfYjkKQXA5EbhAxQ6gKURQPyu91aC31LfqFuVZuQ==
X-Received: by 2002:a05:6a00:150d:b029:3c8:e86e:79ec with SMTP id q13-20020a056a00150db02903c8e86e79ecmr2584820pfu.62.1628293715973;
        Fri, 06 Aug 2021 16:48:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:48a2:9887:4da1:32a4])
        by smtp.gmail.com with UTF8SMTPSA id x26sm11690832pfm.77.2021.08.06.16.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 16:48:35 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 1/4] doc: Add errors.txt to describe errors of D-Bus method returns
Date:   Fri,  6 Aug 2021 16:47:20 -0700
Message-Id: <20210806164624.BlueZ.v5.1.Ide6362da19898d001b053656ee8bf76e183633d8@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806234720.286157-1-mcchou@chromium.org>
References: <20210806234720.286157-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes in v5:
- Remove the use of error codes.

 doc/errors.txt | 233 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 doc/errors.txt

diff --git a/doc/errors.txt b/doc/errors.txt
new file mode 100644
index 000000000..047610c74
--- /dev/null
+++ b/doc/errors.txt
@@ -0,0 +1,233 @@
+D-Bus Method Return Error Codes
+===============================
+
+The motivation of having detailed error is to provide context-based failure
+reasons along with D-Bus method return so that D-Bus clients can build metrics
+and optimize their application based on these failure reasons. For instance, a
+client can build retry mechanism for a connection failure or improve the
+bottleneck of use scenario based on actionable metrics.
+
+These error codes are context-based but not necessarily tied to interface or
+method calls. For instance, if a pairing request failed due to connection
+failure, connection error would be attached to the method return of Pair().
+
+BR/EDR connection already connected
+===================================
+	errno:	EALREADY, EISCONN
+
+	Either the profile is already connected or ACL connection is in place.
+
+BR/EDR connection page timeout
+==============================
+	errno:	EHOSTDOWN
+
+	Failed due to page timeout.
+
+BR/EDR connection profile unavailable
+=====================================
+	errno:	ENOPROTOOPT
+
+	Failed to find connectable services or the target service.
+
+BR/EDR connection SDP search
+============================
+	errno:	none
+
+	Failed to complete the SDP search.
+
+BR/EDR connection create socket
+===============================
+	errno:	EIO
+
+	Failed to create or connect to BT IO socket. This can also indicate
+	hardware failure in the controller.
+
+BR/EDR connection invalid arguments
+===================================
+	errno:	EHOSTUNREACH
+
+	Failed due to invalid arguments.
+
+BR/EDR connection not powered
+=============================
+	errno:	EHOSTUNREACH
+
+	Failed due to adapter not powered.
+
+BR/EDR connection not supported
+===============================
+	errno:	EOPNOTSUPP, EPROTONOSUPPORT
+
+	Failed due to unsupported state transition of L2CAP channel or other
+	features either by the local host or the remote.
+
+BR/EDR connection bad socket
+============================
+	errno:	EBADFD
+
+	Failed due to the socket is in bad state.
+
+BR/EDR connection memory allocation
+===================================
+	errno:	ENOMEM
+
+	Failed to allocate memory in either host stack or controller.
+
+BR/EDR connection busy
+======================
+	errno:	EBUSY
+
+	Failed due to other ongoing operations, such as pairing, busy L2CAP
+	channel or the operation disallowed by the controller.
+
+BR/EDR connection concurrent connection limit
+=============================================
+	errno:	EMLINK
+
+	Failed due to reaching the concurrent connection limit to a device.
+
+BR/EDR connection timeout
+=========================
+	errno:	ETIMEDOUT
+
+	Failed due to connection timeout
+
+BR/EDR connection refused
+=========================
+	errno:	ECONNREFUSED
+
+	Refused by the remote device due to limited resource, security reason
+	or unacceptable address type.
+
+BR/EDR connection aborted by remote
+===================================
+	errno:	ECONNRESET
+
+	Terminated by the remote device due to limited resource or power off.
+
+BR/EDR connection aborted by local
+==================================
+	errno:	ECONNABORTED
+
+	Aborted by the local host.
+
+BR/EDR connection LMP protocol error
+====================================
+	errno:	EPROTO
+
+	Failed due to LMP protocol error.
+
+BR/EDR connection canceled
+==========================
+	errno:	none
+
+	Failed due to cancellation caused by adapter drop, unexpected device
+	drop, orincoming disconnection request before connection request is
+	completed.
+
+BR/EDR connection unknown error
+===============================
+	errno:	ENOSYS
+
+	Failed due to unknown reason.
+
+LE connection invalid arguments
+===============================
+	errno:	EINVAL
+
+	Failed due to invalid arguments.
+
+LE connection not powered
+=========================
+	errno:	EHOSTUNREACH
+
+	Failed due to adapter not powered.
+
+LE connection not supported
+===========================
+	errno:	EOPNOTSUPP, EPROTONOSUPPORT
+
+	Failed due to unsupported state transition of L2CAP channel or other
+	features (e.g. LE features) either by the local host or the remote.
+
+LE connection already connected
+===============================
+	errno: EALREADY, EISCONN
+
+	Either the BT IO is already connected or LE link connection in place.
+
+LE connection bad socket
+========================
+	errno: EBADFD
+
+	Failed due to the socket is in bad state.
+
+LE connection memory allocation
+===============================
+	errno: ENOMEM
+
+	Failed to allocate memory in either host stack or controller.
+
+LE connection busy
+==================
+	errno:	EBUSY
+
+	Failed due to other ongoing operations, such as pairing, connecting,
+	busy L2CAP channel or the operation disallowed by the controller.
+
+LE connection refused
+=====================
+	errno:	ECONNREFUSED
+
+	Failed due to that LE is not enabled or the attempt is refused by the
+	remote device due to limited resource, security reason or unacceptable
+	address type.
+
+LE connection create socket
+===========================
+	errno:	EIO
+
+	Failed to create or connect to BT IO socket. This can also indicate
+	hardware failure in the controller.
+
+LE connection timeout
+=====================
+	errno:	ETIMEDOUT
+
+	Failed due to connection timeout
+
+LE connection concurrent connection limit
+=========================================
+	errno:	EMLINK
+
+	Failed due to reaching the synchronous connection limit to a device.
+
+LE connection abort by remote
+=============================
+	errno:	ECONNRESET
+
+	Aborted by the remote device due to limited resource or power off.
+
+LE connection abort by local
+============================
+	errno:	ECONNABORTED
+
+	Aborted by the local host.
+
+LE connection link layer protocol error
+=======================================
+	errno:	EPROTO
+
+	Failed due to link layer protocol error.
+
+LE connection GATT browsing
+===========================
+	errno:	none
+
+	Failed to complete the GATT browsing.
+
+LE connection unknown error
+===========================
+	errno:	ENOSYS
+
+	Failed due to unknown reason.
-- 
2.32.0.605.g8dce9f2422-goog

