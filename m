Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2B6C4727F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 18:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825592073A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 18:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVMFitoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgIZSJE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgIZSJE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 14:09:04 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01630C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2020 11:09:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gc24so1381186pjb.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2020 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3c/59FF6UbpGkMXgjwS6ktZFhTNkfaygiMQu3wJN1UY=;
        b=vVMFitoqRXXsjBHtjdEbF+ErlbYpYAdQUrfdKS7nxxfXEim/afvY1jGS+LdAWp9ldz
         F8zzQm6hVxUbeaxhgipYPHlc+ALHhcwc3CLDp9TN/OMdo5PZJ9v+KLqfWQnS4M/N+Bca
         9d7LzAR8gVcpeMZyn6CKLTjJ0Yia+TmcI5UgAa013eGHu0dNDREuA8rerIaNWcR7+IN7
         LEQlt47fXtojfvHKKmkrb4tn/eOf3RFFuGS97opaBDMmJEa+zkEBhbeAbh43j+/J4//Q
         jByyjv2EzxZsJeMmnBaGQAqn6vWaeIJkp5rGxzW+AdJ/8+gbRhQKV7WHvvhazsltHL8V
         Pk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3c/59FF6UbpGkMXgjwS6ktZFhTNkfaygiMQu3wJN1UY=;
        b=fAaNs+kk6bQrhKZvF3E6ap8TAP7VN1jjLhrqrdMvf5S6y2eM5CEeiJig2afAzfAnm6
         ZynATpwu+jYiz4AXENI77A6BWDourz9+l0wPL/Y2VyKwVDiHrXVLaTCAmnmYTUE1QpDs
         jaDyrJqq4BJecZMcKS6HxrPY3xJxMSWbRzk2zDAy+sXI7zEjb9QVmRpCWjlT8TLkR6sz
         9bsyc6p+maQoWuXpwz2gNqr+gifv0gfEDL6jYpxy1CoxC6wWO1y9bJT4vleL4oeDv5ue
         NbBal2i24Iab0x3hvHZ7AWg2FYIoAXgHciE/rimtpgjE8MPkoq0WkA1yIvl22svkiOS8
         o7zw==
X-Gm-Message-State: AOAM532tiWz6H5CvbzE/mPMRaDRmYPIzyT/rDDDZ4kh74iZgAqDCdPhn
        BZXl3qGSfRoWHNebmF5hK7FAQW7XYbLcW5fyAZuqCK8cMDwazSAAspujI1UqO4isVZ6mvrEl7t3
        YNpMfEbmlahYRvsSuzflmH/m7PrctXIfniwIPAbDLJNR2hVrTlnkrTovquh5lCR2YHuvFd3d1dt
        mK
X-Google-Smtp-Source: ABdhPJxrk/2ljLE5fOhvOgERvCFlvfkBpQCHeJj5wS4X0CbZxpFybq64Cl5AEt1uDPdA0rl6xsRGsKVmIFDe
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:ea82:b029:d1:7ed9:5470 with SMTP
 id x2-20020a170902ea82b02900d17ed95470mr4790733plb.26.1601143743251; Sat, 26
 Sep 2020 11:09:03 -0700 (PDT)
Date:   Sun, 27 Sep 2020 02:08:57 +0800
Message-Id: <20200927020823.v2.1.Id1d24a896cd1d20f9ce7a4eb74523fe7896af89d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2] Bluetooth: send proper config param to unknown config request
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When receiving an L2CAP_CONFIGURATION_REQ with an unknown config
type, currently we will reply with L2CAP_CONFIGURATION_RSP with
a list of unknown types as the config param. However, this is not
a correct format of config param.

As described in the bluetooth spec v5.2, Vol 3, Part A, Sec 5,
the config param should consists of type, length, and optionally
data.

This patch copies the length and data from the received
L2CAP_CONFIGURATION_REQ and also appends them to the config param
of the corresponding L2CAP_CONFIGURATION_RSP to match the format
of the config param according to the spec.

Here's some btmon traces.
//------- Without Patch -------//
> ACL Data RX: Handle 256 flags 0x02 dlen 24       #58 [hci0] 21.570741
      L2CAP: Configure Request (0x04) ident 5 len 16
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00                    ..........
< ACL Data TX: Handle 256 flags 0x00 dlen 17       #59 [hci0] 21.570892
      L2CAP: Configure Response (0x05) ident 5 len 9
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        12
// Btmon parses it wrong - we sent 10 11 12 instead of just 12.

//------- With Patch -------//
> ACL Data RX: Handle 256 flags 0x02 dlen 24       #58 [hci0] 22.188308
      L2CAP: Configure Request (0x04) ident 9 len 16
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00                    ..........
< ACL Data TX: Handle 256 flags 0x00 dlen 26       #59 [hci0] 22.188516
      L2CAP: Configure Response (0x05) ident 9 len 18
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Unknown (0x10) [mandatory]
        10 00 11 02 11 00 12 02 12 00                    ..........

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

---

Changes in v2:
* Add btmon traces in the commit message

 net/bluetooth/l2cap_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1ab27b90ddcb..4e65854b2f1c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3627,7 +3627,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			if (hint)
 				break;
 			result = L2CAP_CONF_UNKNOWN;
-			*((u8 *) ptr++) = type;
+			l2cap_add_conf_opt(&ptr, type, olen, val,
+					   endptr - ptr);
 			break;
 		}
 	}
@@ -3658,7 +3659,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	}
 
 done:
-	if (chan->mode != rfc.mode) {
+	if (chan->mode != rfc.mode && result != L2CAP_CONF_UNKNOWN) {
 		result = L2CAP_CONF_UNACCEPT;
 		rfc.mode = chan->mode;
 
-- 
2.28.0.681.g6f77f65b4e-goog

