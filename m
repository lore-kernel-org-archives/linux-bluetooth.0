Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A567C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiBARnJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241614AbiBARnJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 12:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643737388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3/onK8AnDtL53ai739ibWRR8ijRtGmfoRrTuaxLarqk=;
        b=ex7hzx4IdASk55opdkuKEiKZLFRjsVKndlaYWHizS/beNfVy2fdVtLobK6pHOZvDjqYcrx
        q7nfIYJDrRSqu2JrU9vi03AzgR8zdAUztSfc33IolaPiB4uafifJB6vpmNLDoiN31w8nt2
        F2LJ+ZTF2c9GduL1gHJm428P1aah3g4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-nbE7Q2x8Pb-HmicPntwa9Q-1; Tue, 01 Feb 2022 12:43:08 -0500
X-MC-Unique: nbE7Q2x8Pb-HmicPntwa9Q-1
Received: by mail-qk1-f200.google.com with SMTP id i26-20020a05620a075a00b0047ec29823c0so12704990qki.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 09:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/onK8AnDtL53ai739ibWRR8ijRtGmfoRrTuaxLarqk=;
        b=K9ZK0Ml0Z346GjY+lKCo6K6xlMxFliw0FQvKeX0nQUeFnKoQZTkFKdO9S41W/cwj74
         qY1s63AJQE5nUAnrcX4Qvf7i+tEaACYWFbT1srAhekaNmRT2Jp3Rgf70TmRdz9qVmfO+
         H9Hq5EPBI/pPhH+xQv/MYHnG2DU3vSrGETWkOsA3VS13+T0bWNaY8JuxS361xE2hlw/u
         oITgJn5X6yl8C7rZqogIdbZyFJvuw/uFQX7VFKBTdCoWRz9JvRYO9b8c08Wfob7uAvhk
         N+DhkH37HdmJ/vB7zxx71Sf9E1KpyTHfShHl4KGJBEzZxLg4RzpBEcjI9UWGT/d7f6jz
         Lu4g==
X-Gm-Message-State: AOAM5315zIGC8lfiYd3aaWePTF33RurEyInZGSCt0+G5szsPjZpaS4lG
        V7BIvU1I1xoLNLItW1DCBlLcD21Se2Iff/RfQqYrju9TcxuNkE2Y3ZIwj5ntcGa8/tncqQG9TRW
        FrwOf1YLF5xidL/X/misBp2gyLUN0
X-Received: by 2002:a05:622a:44b:: with SMTP id o11mr10694447qtx.507.1643737387527;
        Tue, 01 Feb 2022 09:43:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyADtOcufdtCgzPuWfrUXmKa/HFQ+qhMTdmjjxzdXxSj8ZJqSx+dyiOnLYrEWaALkPWKiqX+g==
X-Received: by 2002:a05:622a:44b:: with SMTP id o11mr10694429qtx.507.1643737387313;
        Tue, 01 Feb 2022 09:43:07 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d17sm11962845qkn.84.2022.02.01.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:43:06 -0800 (PST)
From:   trix@redhat.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Bluetooth: hci_sync: fix undefined return of hci_disconnect_all_sync()
Date:   Tue,  1 Feb 2022 09:42:56 -0800
Message-Id: <20220201174256.1690515-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem
hci_sync.c:4428:2: warning: Undefined or garbage value
  returned to caller
        return err;
        ^~~~~~~~~~

If there are no connections this function is a noop but
err is never set and a false error could be reported.
Return 0 as other hci_* functions do.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6e71aa6b6feae..9327737da6003 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4425,7 +4425,7 @@ static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 			return err;
 	}
 
-	return err;
+	return 0;
 }
 
 /* This function perform power off HCI command sequence as follows:
-- 
2.26.3

