Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDB4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CAA229CA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 17:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbhAKRr5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbhAKRr4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jan 2021 12:47:56 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61840C061786
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 09:47:16 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q25so142895oij.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3zm0LJAFCmk0YjwUIl3/pOVCB5k2Lodv1qAW9xiz34=;
        b=SqSk3U04KMIcaOHV8J9KMRvoxrk2FFlynudLxfHBGiEczf+rGoE1zuRSnIZ8ArDPRR
         z71RpZD8PYcGVKplg+Tb+yM9ueIclnc9u0vcJICuWSmhjS1b2SKuqdt2JfZ87RhB7krQ
         wl6OCBSeYPAb1L45Rp6qJGIxiicm0k8m5NjXCG1VU1uGf0nBU0IUqUSVP3n/1RjBaWBZ
         thDK6Gx4darmISWkOaNnoqoPvmTumLcotiBwG89x4pT1o+ZG2d6wfXde61RbfkpPA18+
         3L2wqoFZ4qZ/hWIjAOp6FUO5Tfi6mao5W8t4InR+3m+BybTFXnBSNwIxRcJKdrxXqg2e
         34/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3zm0LJAFCmk0YjwUIl3/pOVCB5k2Lodv1qAW9xiz34=;
        b=SvvS5Ws+HfgIIcOS2gqUb09b3oT4Ja786ab/5U4ndxTVEe97b3q4w9tZYqPhU4e9HF
         LE+mQ8CIwPnYJ79CwiKq0JAfTIy7rgFvLZljvUGZcKwq2rXOyfvTWb3mnVH8BwhUAc7P
         GebyDgt9x0okxUrlxnQ2O7yclUR1EaStaUfOA53jVSDSfXTGzXjmLk1281sTG7E/dpDQ
         FLHdA7QoWc6aBsKm7utR0UwNF5YX13NFHElWcF4mH5ElRzTxCh0vzsa9zBDkjJjhneGF
         QZ6qmx76VifAz9p/tKwxKC4FQAiIe6+zyRVeOI87MBR2sNJaBJtSUgmY14DU04+bMUpi
         G1XA==
X-Gm-Message-State: AOAM530IlRn9+wLWQAm/UCIrzegpYKBIbSldTeDPqT8uXzr432fR6M6y
        BnaaajTsUBUbKkzUqatzbI5DOMlJ7wnujEvVkIc=
X-Google-Smtp-Source: ABdhPJy8F4qTmZdzM+SwLbD/Z3suljvLGFP6SzUXDdY6lNbcH5HcQ7k+K5FsaiIhco+ZfNDTpvcW1OJWwv8LAX/mNok=
X-Received: by 2002:aca:f456:: with SMTP id s83mr3608oih.58.1610387235675;
 Mon, 11 Jan 2021 09:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20210110003033.2528-1-sonnysasaka@chromium.org>
In-Reply-To: <20210110003033.2528-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 11 Jan 2021 09:47:04 -0800
Message-ID: <CABBYNZJBo2oM=U-FA8sw31aMzVqr-k4Qq=mhC0LX-AWB6xW=0g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input/hog: Fix double registering report value callbacks
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Sat, Jan 9, 2021 at 4:34 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> In commit 23b69ab3e484 ("input/hog: Cache the HID report map"), we
> optimized HOG reconnection by registering report value callbacks early,
> but there was a bug where we also re-register the same report value
> callbacks after at CCC write callback. We should handle this case by
> avoiding the second callback register if we know we have done it
> earlier.
>
> ---
>  profiles/input/hog-lib.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 1f132aa4c..089f42826 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -80,6 +80,7 @@ struct bt_hog {
>         struct bt_uhid          *uhid;
>         int                     uhid_fd;
>         bool                    uhid_created;
> +       bool                    report_value_cb_registered;
>         gboolean                has_report_id;
>         uint16_t                bcdhid;
>         uint8_t                 bcountrycode;
> @@ -336,6 +337,13 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>                 return;
>         }
>
> +       /* If we already had the report map cache, we must have registered UHID
> +        * and the report value callbacks. In that case, don't re-register the
> +        * report value callbacks here.
> +        */
> +       if (hog->report_value_cb_registered)
> +               return;
> +

Can't we check the report->notifyid instead of introducing yet another
flag that seems to have the same intent of tracking if the report has
been subscribed? In fact it seem there is something odd related to how
we handle the CCC here, we do read it on ccc_read_cb but we don't
check if its value is already set. Pehaps something like the following
would be more complete solution, though we should really look into
convert hog-lib to use bt_gatt_client instead of keep using GAttrib:

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 1f132aa4c..34a4d7c3b 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -360,15 +360,30 @@ static void ccc_read_cb(guint8 status, const
guint8 *pdu, guint16 len,
 {
        struct gatt_request *req = user_data;
        struct report *report = req->user_data;
+       uint16_t value;

        destroy_gatt_req(req);

-       if (status != 0) {
+       if (status || !len) {
                error("Error reading CCC value: %s", att_ecode2str(status));
                return;
        }

-       write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
+       if (len == 1)
+               value = *pdu;
+       else
+               value = get_le16(pdu);
+
+       if (!value) {
+               write_ccc(report->hog, report->hog->attrib, report->ccc_handle,
+                         report);
+               return;
+       }
+
+       report->notifyid = g_attrib_register(report->hog->attrib,
+                                       ATT_OP_HANDLE_NOTIFY,
+                                       report->value_handle,
+                                       report_value_cb, report, NULL);
 }
