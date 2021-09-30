Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3524C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD53761882
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhI3Wk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhI3Wk0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 18:40:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC4C06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:38:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j4so3572483plx.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2Je87Vko3wyit+AstzMdPsC02va0SIXWyF/CRHJwac=;
        b=LOoeiM7cGU2DqP97GzXbibf6u6J0hggjSnoIsXaGPHRFMUVGswmCYFbuQbzR0t1m0W
         ycKbjROv1x3dLobtUPuWQ91mRHRFBQjodTIQSZ18CFvVFP0+W6OlZmXYODKpDOMD4qc8
         cpAizxoEXFgJH0/0CrWQ2gy33X2/eCiMhYn/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2Je87Vko3wyit+AstzMdPsC02va0SIXWyF/CRHJwac=;
        b=fnqXxpcCSZgAHntBzTFgqEXNKxawfyroHTKXK40ToezoEJmo0DO5Uvbek4B9pXOL0V
         A+WjPHX/n6OTH2kyzDIpBU+v2eUK1F7Ul7Hs3WpeexwT88SfWfyvxxWwz8kVzikv2BPh
         1Q23t8xQj14NBWV5j9vDpjpqPxJPCxyKhYHZhukA34XYozd0w5QvAPR0wNQW3P/1WMAq
         If1TKAjkUH6RmobkgKNTbUsuIGg6J+r6mKJsRim3JReyoEwsHiqOnNTLXg4eD2qP5L+V
         pCtg/suKHVHgwQw63McaWGrkGoLzlruuRhWgae7s61a7RTKr52GoziQx8VVJSycs8w7F
         13nQ==
X-Gm-Message-State: AOAM530VyZrk+qQ7/zTuGRREaRiDtdaYcxhJnyaahEBKEgTTduSGE70M
        y9RFQRAa6yzsoXoys8kuUWu5m3TL04NBkw==
X-Google-Smtp-Source: ABdhPJy4mChvIS4uYZ0An1hWTWP/kb5Hr1y2NMQzr01Fv9TEMHBZTVOBQygpWHR9bpkJTrA+y6EFMw==
X-Received: by 2002:a17:90a:4801:: with SMTP id a1mr15478468pjh.156.1633041522489;
        Thu, 30 Sep 2021 15:38:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb71:bb5c:56a6:693f])
        by smtp.gmail.com with UTF8SMTPSA id i15sm4044220pgo.4.2021.09.30.15.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 15:38:42 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 1/4] doc: Add errors.txt to describe errors of D-Bus method returns
Date:   Thu, 30 Sep 2021 15:37:24 -0700
Message-Id: <20210930153703.BlueZ.v7.1.Ide6362da19898d001b053656ee8bf76e183633d8@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930223726.2886139-1-mcchou@chromium.org>
References: <20210930223726.2886139-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---

(no changes since v5)

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
2.33.0.800.g4c38ced690-goog

