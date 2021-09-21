Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B6EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E31861168
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhIUQuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhIUQuL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 12:50:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F931C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:48:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23so60918pji.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnnAbp8Nzz5Zz5gwdrICLzrxPOeX7imY24A4AfqiiWE=;
        b=JLcK6roqWRzk3yiEz4WMbM/Knif0RqyXZ6ugp4stNgJIAS7ridJ1rLvJXJotK06uku
         Vu+ZImMNEPGtFKpF9gOTa8v3RMEG1yYBnkKvJRamNiWsNxSJ+Wvhfm7/K7VBmP0cnmQ1
         IiRGly6afgBSDxayuRgjbu/9ZOqAovoG1ojRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnnAbp8Nzz5Zz5gwdrICLzrxPOeX7imY24A4AfqiiWE=;
        b=reNznH14ZX/rx/EaskhSqNbpdpHm4G/l9T3OtrZsm1iAjnxP0SJ85QzqGY+zN828eN
         pzATQADta28CljwAgFoPQelGGtem+Dr9AidbJ0Bv8c4XACGds6flCUAAxexE5nUm4P+H
         9U+uUQozRtHkvtT5WG15Im53+SMj2yzVgRxAwEhrlELt9jGOxS2mdG33Xc2PeohpFTv+
         ezpBGHcKKMI0RL3NwtGSGbp3VAN+Ih04owdrO30CcQimW7YRoFRaCrx7Kt/PhwtGsSHf
         cUnhZ8baiu8etfUgHi5KhAgxZ+aPxwNFsHxpIc+KLGPhJqSBvBHcIGCNopDcuI/PapkD
         IBgw==
X-Gm-Message-State: AOAM532kyDrXYIa5g39aBY+N25BfQAf36Ox6TVsnyi8aVcIhXtYMXMld
        S/Sbb5u+kwrl/TKBM5RD24dATLYT3tBsSg==
X-Google-Smtp-Source: ABdhPJygzGuMDgn5XxaQDXRuJ4WZ3UzAdIlGtpsS6XT8hXHRoJzTfcTTyxnlBPC3tdpbFr7neKAATw==
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id h4-20020a170902f704b029011acdee0490mr28093582plo.37.1632242922413;
        Tue, 21 Sep 2021 09:48:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:db3:f19e:7f67:74f])
        by smtp.gmail.com with UTF8SMTPSA id p2sm20023639pgd.84.2021.09.21.09.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:48:41 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 1/4] doc: Add errors.txt to describe errors of D-Bus method returns
Date:   Tue, 21 Sep 2021 09:47:05 -0700
Message-Id: <20210921094400.BlueZ.v6.1.Ide6362da19898d001b053656ee8bf76e183633d8@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210921164708.1497029-1-mcchou@chromium.org>
References: <20210921164708.1497029-1-mcchou@chromium.org>
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
2.33.0.464.g1972c5931b-goog

