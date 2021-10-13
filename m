Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183BDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E840E6117A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhJMTC4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhJMTCy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37F6C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso4300926ybj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zDm/1HXxYpCHGqNcts6L+dNk5vE52gAdZudIn+cmvD0=;
        b=my/DlLy0Fb9/0ccQsmKEO+9lFdtVvtsfD6TYnPQ+Ys2MjMXoHl1ctbdgtdUVdcu+1Y
         t+OsRxnjn6w/gc/cT4fnK9JJBhDbdwB62EYAqhhvruCiCpifwme6B0INAFk3pS0els5o
         Pb0vvM9ZBz3x6RFG8aYj43uHGKh+oKLdrOX7F+CGOFMWxwMJV873K7q2+/w2DPLE86Mi
         QqtkaanZfBc+4vSW/KafnYiNeEqsp8LVC1WYGF1e2RqUIjgaAjVw0bv560SmYpmzsCVb
         HCmchxZ3zkCgRXZx1VDE+zS4DYj4tK33qFM9qgsq0DiNf72W7t8DgumQvG544lZbiMSV
         Td2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zDm/1HXxYpCHGqNcts6L+dNk5vE52gAdZudIn+cmvD0=;
        b=H9kouZn5GhusZwdoVi8zZXy+dgN0e+a1gULghLoMGFiIozg0bnVI30abMd20RXjoTm
         PtogR9mTetxbCMfs9A3JMroF8Z1CAyEWr6lYAFORPBIEpsRcSIrg7/njivf3DSh5I96L
         m2BUmgPvhqCxdSKmBG8Hu2dI9DnZ+LXRUFUA09OborbrwO8n5YWAhpZykbp9TDsrip93
         D2uqLL3dN5Uqa4tML2Xrvx0pS0MYfLnzaMuBbzQM3W5ThdSF5FXQFeNPQkddDNCP+ygm
         htdOKMzTo2MG13MIJYHdulZSPiIj+41G8075FShjCJ1lvVlgyi4Js2u/AEEz74sajRhf
         8K2Q==
X-Gm-Message-State: AOAM531KnNkQbMQWNBEzzgDcq2Mqe8SVbhp6MQJws9AEkOdCaWUn9ozZ
        tg5/QZJnOoF5qE90f08fzuUPqc6Knj9u7w==
X-Google-Smtp-Source: ABdhPJypkbpKFStsphuTA8/namsc1NrDLr4k5iXGx1yF4UWdNAsG99BYUCwkh27cqmuf8F0zTtKhfR9B7j23jQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:9910:f10f:1467:c3f])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:154f:: with SMTP id
 r15mr1357883ybu.441.1634151649944; Wed, 13 Oct 2021 12:00:49 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:00:34 -0700
In-Reply-To: <20211013190035.1876237-1-mmandlik@google.com>
Message-Id: <20211013115927.BlueZ.v3.2.Ied4afb8c4c882e573f4a23670fc060cbc3e319c9@changeid>
Mime-Version: 1.0
References: <20211013190035.1876237-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v3 2/3] lib: Add definition of the Adv Monitor Device
 Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds definition of the new Device Lost event to indicate that
the controller has stopped tracking a device.

---

Changes in v3:
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 lib/mgmt.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321..aaeeb297a 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1014,6 +1014,12 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_DEVICE_LOST		0x002f
+struct mgmt_ev_adv_monitor_device_lost {
+	uint16_t monitor_handle;
+	struct mgmt_addr_info addr;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1152,6 +1158,7 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Removed",
 	"Controller Suspend",
 	"Controller Resume",
+	"Advertisement Monitor Device Lost",		/* 0x002f */
 };
 
 static const char *mgmt_status[] = {
-- 
2.33.0.882.g93a45727a2-goog

