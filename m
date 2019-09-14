Return-Path: <SRS0=TpqP=XJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E03C4CEC5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Sep 2019 04:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A7E20693
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Sep 2019 04:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI3xVRJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfINEcj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:32:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42580 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfINEcj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Sep 2019 00:32:39 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so67221639iod.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2019 21:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CGltgLvZWr+jpF7Eh4h20UVnnuWSJ7i0PqYxC8DlTb8=;
        b=aI3xVRJsq7984ZhW0E7lw2TzY4MUY/rU37O5rwfWkC2ujnNUwFMXFkHxGcsh97aK7/
         zBOvdL3gGikcqmUNUjIvVhojPV8jqdLX2pSwCP2bTM0VjSS28GkzVjcdI4p5HOyYReUA
         I8hqZ0hqYE/61g2pHerDvmuA63KYhHCMg2OzAuLxQUhFU2N19AhMWnm8tJv8xSIr61vy
         4YSLIlhMO7AliC6QgZNiDamjmqImY5wRDk2VYPUA+0w0TJ4CnBM0QzfShr0F0MFN0hYI
         pOgj/xu4yHKxGkYVlkwakfdK1wcoIJAsYUUv9i9k51q2f8qrD5oPMGSvaENZHulDif4S
         L7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CGltgLvZWr+jpF7Eh4h20UVnnuWSJ7i0PqYxC8DlTb8=;
        b=onmdc1+R8DnC7Ad+ejaWroLPmMH5waDrzrPVgPnowe2GPu1jWfZt/SmT1ePWAguLof
         28it3TCFHOw+2UCXpcy8za2AUieun7IGSq9YA/aLicie6DNH2f/QYn4IIWX5EAMJxHJt
         5SJsbl2960F5GWxUbTqCg6RvY5pbli4E/kz6c5U6jKlSUs1oyfeg58w8XLlYPcP1xXpJ
         aBypgOI6QRK0fDjO7LKUrPLFhZuqtsPLIc8JnO1XAyVwnq8a2cty8ByJ0J2TAeiVbSFo
         JHvPhqcyVtvPCUO97Fp13nMVa4Ogco/aZ9NZbi54msC/ddfDFPtcnjvr2+uKpYtS8yNp
         I+RQ==
X-Gm-Message-State: APjAAAX7Egakm8/11Hd0Y5ha6LJTlhqxsYwnrTK6XrExvkOqlMsSLxYc
        YBdINRPMl+gU62+I5yjxEEvFZJ4BGeUdgCN2sYn+VeGzrd0=
X-Google-Smtp-Source: APXvYqzMEYzVhIat4vLxcH5Q5bVAR/bN6S0ZN00+1BjNW/+U/ijm3G+s7hAfoPZ4d5GmKIaRg/8RrqRJHAfGMpsjn48=
X-Received: by 2002:a6b:b291:: with SMTP id b139mr3879915iof.281.1568435556473;
 Fri, 13 Sep 2019 21:32:36 -0700 (PDT)
MIME-Version: 1.0
From:   Sonny Sasaka <sonnysasaka@gmail.com>
Date:   Fri, 13 Sep 2019 21:32:26 -0700
Message-ID: <CAHvDJkrdcTCDM9cpeD5ZdMF-whR8jk8ZGdayaeQoU1BO14wwgA@mail.gmail.com>
Subject: [PATCH BlueZ] gdbus: Properly set owner of filter data at start of
 client creation
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently at the start of client creation (g_dbus_client_new), the
|owner| in |filter_data| is not set until the |name| is resolved. This
creates a time window where the filter doesn't work properly, i.e. it
filters in more than it should. To solve this issue, this patch does the
following:
1. At the start of client creation, set the |owner| in |filter_data|
based on the current resolved |name| if any, or set it explicitly to
unknown (empty string) as opposed to NULL otherwise. The unknown |owner|
lets the filter reject any message, unlike NULL |owner| which accepts
any message.
2. Step 1 above reveals another bug: message_filter fails to accept
messages which have |sender| set directly to D-Bus service name rather
than D-Bus address. Therefore this patch relaxes the filter requirement
in message_filter to accept a message if its |sender| is equal directly
to our filter's |name|.
3. After the initial service name resolution (after GetNameOwner)
returns, immediately update our name cache with the result, otherwise
the filters' |owner| would be stuck to unknown (empty string) until
"NameOwnerChanged" signal arrives.

---
 gdbus/watch.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 447e48671..2ae0fd5a7 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -78,6 +78,8 @@ struct filter_data {
        gboolean registered;
 };

+static const char *check_name_cache(const char *name);
+
 static struct filter_data *filter_data_find_match(DBusConnection *connection,
                                                        const char *name,
                                                        const char *owner,
@@ -265,7 +267,10 @@ proceed:

        data->connection = dbus_connection_ref(connection);
        data->name = g_strdup(name);
-       data->owner = g_strdup(owner);
+       if (name)
+               data->owner = g_strdup(check_name_cache(name) ? : "");
+       else
+               data->owner = g_strdup(owner);
        data->path = g_strdup(path);
        data->interface = g_strdup(interface);
        data->member = g_strdup(member);
@@ -534,8 +539,12 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,
                if (!sender && data->owner)
                        continue;

-               if (data->owner && g_str_equal(sender, data->owner) == FALSE)
+               if (data->owner &&
+                               g_str_equal(sender, data->owner) == FALSE &&
+                               data->name &&
+                               g_str_equal(sender, data->name) == FALSE) {
                        continue;
+               }

                if (data->path && g_str_equal(path, data->path) == FALSE)
                        continue;
@@ -627,6 +636,7 @@ static void service_reply(DBusPendingCall *call,
void *user_data)
                                                DBUS_TYPE_INVALID) == FALSE)
                goto fail;

+       update_name_cache(data->name, data->owner);
        update_service(data);

        goto done;
-- 
2.21.0
