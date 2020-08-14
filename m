Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A1C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 22:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A600C2068E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 22:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3orD6F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHNW6Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNW6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 18:58:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F9C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 15:58:23 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t13so7255943pjd.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DYBPrA8sCUr9nfv4S2QQxK9888V5PiTctZCZCYiPjog=;
        b=U3orD6F3Izflh9/TcLR+xnPcE9gpu7GMgVOivUGX+0/T5eFnMUJKcnArweJMGsr4Jj
         6smMB4lntcFs9sOUQz+VS6OMvC1BCbuhs4Ij5wZbOGapJdLT/aoR82X7/aLvYhihZpSO
         ePNcpjlUjWohdtOiJJK6uUorDbW1Np96+l4EI2R3EEDVDcTuaHnkYrjcjIgLEgYPsvgN
         nlYi6fgL1O5MlFHJfXvUCoKuUCepl01y/Fvll63tDj0sXVXNlGqD2aeHSrMuy3ShtKLf
         H3VjKaiY1Nkw+1lJNGgZe63DfOTx/u+UPOoP5P+DO+xBMLqNPqXhLMdwdE5CbC/EYqjR
         C7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DYBPrA8sCUr9nfv4S2QQxK9888V5PiTctZCZCYiPjog=;
        b=MqzZ1OKNQySwKh+YfjlEZAxgo5wZTJsK7ssESY40e3eIO7Hp+Zy+0B4N8LaXIAKVVP
         lUtzuSRTOCTq/XZ2vxBnEQS03vZ9PQS3dCKnLb0EsPWb+jSZYksj5t9jG/wt8SvbTKIP
         Avo1BFLf6r0DGpv+/ZTXnFaMJzACa19Dex+j+0asiI8Y2ZY8xAaEkOn7arxMkFhxjtzS
         qrpYVzqLOLelMj95O+UgTmju44/lJ0wzLTma50j824dkQpFbeny3bYZMIlLK4xQdVwKF
         LKuB3XeryL7VEvvxEOG16hxH3SDVQTG7muDuml5MbIUzF4bUSw5MP2wRKFl7ihs3MgFx
         Mw2g==
X-Gm-Message-State: AOAM530Ot15v6Zcg0AOZLkQhiK1W5C7WHbppGQwbBgUdrj7StWpoTo58
        rfVWM+a6ofupZdvyIzY3u65fMDue5sQ9M89JeAb5
X-Google-Smtp-Source: ABdhPJxFsdCZ5eF33zzvwv3OCG+LLDirDPoWvVLn13gIWyzT2e7aV1WFubmPaksOqaUCEOe4eP2iXyTEbTrr3slgB7YJ
X-Received: by 2002:a17:90b:193:: with SMTP id t19mr4018900pjs.162.1597445902591;
 Fri, 14 Aug 2020 15:58:22 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:58:18 -0700
Message-Id: <20200814155807.Bluez.1.Ia90c97ad9ec0b51b7aaae1216864e8379c1470d5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [Bluez PATCH] advertising: Fix dbus response for over-advertising
From:   Daniel Winkler <danielwinkler@google.com>
To:     simon.mikuda@streamunlimited.com, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

client_free would always send a dbus method_return to fix the case where
a request to Unregister occurred before the MGMT call returned. However,
in the code path where too many advertisements are registered, this
method_return prevents the failure from being sent properly. This patch
makes sure the reference to the register_advertisement DBusMessage is
not stored in the client structure until the end of
register_advertisement. This ensures that we only respond once, either
in register_advertisement or in client_free, not both.

It also changes the dbus response in the fast unregister_advertisement
case from a method_return to a btd_error_failed, since the registration
was never allowed to complete, and thus was not successful.

The patch was tested in the following ways:

To verify it did not break the segfault fix in
caff2b48ca54bbc57b5da3f63317767489aa5b48, I repro'd the failure by
quickly unregistering after registering, and verified that the segfault
is still fixed with this change.

Ran through our automated tests that register too many advertisements
and verify that the registration fails with the intended "Maximum
Advertisements Reached" error response.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

 src/advertising.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 076d591b6..e5f25948d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -119,9 +119,13 @@ static void client_free(void *data)
 	}
 
 	if (client->reg) {
-		g_dbus_send_message(btd_get_dbus_connection(),
-				dbus_message_new_method_return(client->reg));
+		DBusMessage *reply;
+
+		reply = btd_error_failed(client->reg,
+					"Failed to complete registration");
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 		dbus_message_unref(client->reg);
+		client->reg = NULL;
 	}
 
 	if (client->add_adv_id)
@@ -1152,8 +1156,6 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	g_dbus_client_set_proxy_handlers(client->client, client_proxy_added,
 							NULL, NULL, client);
 
-	client->reg = dbus_message_ref(msg);
-
 	client->data = bt_ad_new();
 	if (!client->data)
 		goto fail;
@@ -1216,6 +1218,8 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 
 	DBG("Registered advertisement at path %s", match.path);
 
+	client->reg = dbus_message_ref(msg);
+
 	queue_push_tail(manager->clients, client);
 
 	return NULL;
-- 
2.28.0.220.ged08abb693-goog

