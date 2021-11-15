Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3014DC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A2263211
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhKOJWO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhKOJV1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:21:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD70C061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:18:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w132-20020a25c78a000000b005c27f083240so25605727ybe.16
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DDF7rvzqvHmq625R5p02Vn6Now2KuXQQZ3he1Jdx/98=;
        b=gvItqONCSe9Lgo0mVcfxcD8u0ADitEl1DmjGuV057JIir+gsRFGNefA+DeS86rjXgB
         9+TPeytX80zHkBMkpbCS8jsY7kilYBfniHGbcingyrkN4p4ACNYz6oYzgWZHTIxXIDjD
         QgrbfTTwgOvF0a3FeFSoiQqrGpqr/c6K6Jgo2yAYEv6T9AstCy4Lfac2VeCyzAP69wtr
         npZcw1CpiWiztpvE27CkVhH0PA4FAfG9ITRw3Lpjfo41QrncpFn5h8S/MXN8q6Vayerw
         TiDQUkRybXtYl/ZL5vpf04wnKJKVUnBeAFjFmKWgZtxpg+/jQfrqXs3BXtwdTEnP83uI
         R/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DDF7rvzqvHmq625R5p02Vn6Now2KuXQQZ3he1Jdx/98=;
        b=6SzVtUpY+2FxDx84v0CV70G1Ake3ETR70EKjsq1tGr2TUXtQqDPV2GgUHWxhIK9jze
         VlbsxIbVabKNaLZSogg1aSyttA3OtQwB7SYyk9FYe6pirefU0+K6N2TfHRG6wgCAWldd
         7Ef9+1jZubT+Eme6fvkijAx+WigF43wE103CZ2eHDN8E4umUy21omU7MI/23a3K7ZvjA
         msgYEczkk9J3lF2JomAdnMfesPsZzGG74RSA+qJQ6fwXtB4IAvqh4ThDk/ncDgvpct7G
         jMGdICWfVjjPv1+jgfXGZwXF49bS6CX0Kj+PvArozCUFDhwMZ/Vjo6yJBQY3/0yDBsMi
         zJEA==
X-Gm-Message-State: AOAM532h3XbP5TVI6FNGTUS0yy7skXApJ676vZzlHtou6f57P3R3QBD/
        SYNmG+im0wPe8b7hfYabue1kwL4hDHhPTrfIENTxrg38y/f9OJgRJqP6vWb/OE8iYNNu7XwPkQo
        rC2fPY12b9E+2taixNxpZJd9cq3JdffDjl9OPIS/bMSAAJShr82EZICetiPRWWXlmCYcnGINXJq
        L/
X-Google-Smtp-Source: ABdhPJwgMN9sgvk0dg1l0x1FK4aZj77ai6ObMDU8GM0xv7Bs8/XrJHodlMYejoqmmXXHWMa2aJBmvYbbtzxC
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5c8f:7191:e5ca:14fb])
 (user=apusaka job=sendgmr) by 2002:a25:8408:: with SMTP id
 u8mr41624153ybk.258.1636967908407; Mon, 15 Nov 2021 01:18:28 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:17:50 +0800
In-Reply-To: <20211115171726.v2.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
Message-Id: <20211115171726.v2.2.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid>
Mime-Version: 1.0
References: <20211115171726.v2.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 2/2] Bluetooth: Limit duration of Remote Name Resolve
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When doing remote name request, we cannot scan. In the normal case it's
OK since we can expect it to finish within a short amount of time.
However, there is a possibility to scan lots of devices that
(1) requires Remote Name Resolve
(2) is unresponsive to Remote Name Resolve
When this happens, we are stuck to do Remote Name Resolve until all is
done before continue scanning.

This patch adds a time limit to stop us spending too long on remote
name request.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_event.c        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5f061882c10..4112907bb49d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -88,6 +88,7 @@ struct discovery_state {
 	u8			(*uuids)[16];
 	unsigned long		scan_start;
 	unsigned long		scan_duration;
+	unsigned long		name_resolve_timeout;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -1762,6 +1763,8 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_LE_FAST_ADV_INT_MIN	0x00A0	/* 100 msec */
 #define DISCOV_LE_FAST_ADV_INT_MAX	0x00F0	/* 150 msec */
 
+#define NAME_RESOLVE_DURATION		msecs_to_jiffies(10240)	/* msec */
+
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2de3080659f9..6180ab0e8b8d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2129,6 +2129,12 @@ static bool hci_resolve_next_name(struct hci_dev *hdev)
 	if (list_empty(&discov->resolve))
 		return false;
 
+	/* We should stop if we already spent too much time resolving names. */
+	if (time_after(jiffies, discov->name_resolve_timeout)) {
+		bt_dev_dbg(hdev, "Name resolve takes too long, stopping.");
+		return false;
+	}
+
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
 	if (!e)
 		return false;
@@ -2716,6 +2722,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (e && hci_resolve_name(hdev, e) == 0) {
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
+		discov->name_resolve_timeout = jiffies + NAME_RESOLVE_DURATION;
 	} else {
 		/* When BR/EDR inquiry is active and no LE scanning is in
 		 * progress, then change discovery state to indicate completion.
-- 
2.34.0.rc1.387.gb447b232ab-goog

