Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBC0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FF364DA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 06:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhA1Gyz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhA1Gyw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 01:54:52 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9538DC061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 22:54:12 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d7so4259425otf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 22:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3S+nmWZyAGdBBeh93o5nXd2a7/HF9g2hu7DFy8+sdAw=;
        b=j0moPGVTlB9CPilP5BMO4AODBKFbecsvX8gcmg50YLgGw6nrfuMT7xqdtVnz/PCMXz
         Q4iUi45+yJbpmT1xpa4Fntq3qoAULLf6BXG8smHAm8ExsFOn2smK7TSJd9GUQ8DHuOHY
         QHDdZgXvsPXDFq2AIBYlx/dACxAxj9RljTYOt9Dr5VFjAFq5ydPZW/PZmWLILf2fQgOp
         ghcB25YQzMzegZKvkjI5neiTU378UUBtuuRUMxCyRetk568ygJ9162UU60s17uGDYBN9
         wjvEM6+m47NJBPZzFecRBaQa4MfPFSUwqt3JXY+XrV9J1bwmckitvG3V/kzKJSnZ4F9S
         vXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3S+nmWZyAGdBBeh93o5nXd2a7/HF9g2hu7DFy8+sdAw=;
        b=LD62/b1pyl9UycdRuS1QDIhwbWCKhz/k9Q1Ej98UgIrzZbqVQPHLyMf4+JYhaqMZE/
         PnOTpQmgpDGyi0BfwQa64NcLYbLP5TJHGsson2QxPkmvNznGxDV8E3nAjhjyaYhj1n28
         rQm7mDsBdajb7AaoOCBxpI+WZu4q2kzBbVHmaWxrlHMEbWT/x9YAoLdkRF6F8H/kkJYh
         zYDvv/mZioKrpsnDm34s08ADVqz9PEOPJkYaMKMaApKtDttypx329nbfS5L4c7ae3aSG
         xSXlzI0AiH2585YHr31rl0UW0jLjCxSmHcwutzMFYuACkmLFRnziuD+Vt4d+07RpaN7s
         Iy0g==
X-Gm-Message-State: AOAM533zwczU53evGBPNl5WU0g28l+bxfbbGRca+lSPnA0LlCCC9JFTL
        fkgkufYWAZmMgdbK20QfptSXf4St/+QA6VKHfw7dGAJTbZZlXA==
X-Google-Smtp-Source: ABdhPJw4NK0fhzEWX0Ad5Ce1KesTIiZQrs60aYQpdrBVFrPbnIe1OFKjy5u4hrH8JSi02p0NJrfNc+sl/veUxbJJNgY=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr10019689ota.44.1611816851972;
 Wed, 27 Jan 2021 22:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20210128063901.1362-1-sonnysasaka@chromium.org>
In-Reply-To: <20210128063901.1362-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Jan 2021 22:54:01 -0800
Message-ID: <CABBYNZJNq9k0vwKVeJrPcK9t43zYE33Ct9SF0OGAJKMfXq3mPw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] input/hog: Fix crashes of UAF of hog->attr
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Jan 27, 2021 at 10:43 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> hog->attr does not own pointer, so it may be invalid when hog object
> gets re-attached at bt_hog_attach(). To solve this, this patch
> intentionally clears hog->attr at bt_hog_detach() to mark it as invalid
> so that it can be repopulated with the valid pointer at bt_hog_attach().
> The same applies to all sub-instances.
>
> Sample stack trace:
> * thread #1, stop reason = signal SIGSEGV
>   * frame #0: 0x05ad49f2 bluetoothd`<name omitted> at gatt-db.c:1428
>     frame #1: 0x05a91922 bluetoothd`bt_hog_attach at hog-lib.c:1694
>     frame #2: 0x05a9160e bluetoothd`hog_accept at hog.c:212
>     frame #3: 0x05ab4784 bluetoothd`service_accept at service.c:203
>     frame #4: 0x05aba1e6 bluetoothd`device_attach_att at device.c:4542
>     frame #5: 0x05a9c4a2 bluetoothd`connect_cb at gatt-database.c:656
>     frame #6: 0x05a98e8c bluetoothd`server_cb at btio.c:264
>     frame #7: 0xec8e6a1a libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3325
>     frame #8: 0xec8e6c58 libglib-2.0.so.0`g_main_context_iterate at gmain.c:4119
>     frame #9: 0xec8e6e52 libglib-2.0.so.0`g_main_loop_run at gmain.c:4317
>     frame #10: 0x05ad582e bluetoothd`mainloop_run at mainloop-glib.c:79
>     frame #11: 0x05ad5a64 bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201
>     frame #12: 0x05ac35ac bluetoothd`main at main.c:1103
>     frame #13: 0xec6ed0a2 libc.so.6`__libc_start_main at libc-start.c:308
>
> ---
>  profiles/input/hog-lib.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 1f132aa4c..711bda73c 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1651,12 +1651,19 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>  bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>  {
>         GSList *l;
> +       bt_uuid_t uuid;
>
>         if (hog->attrib)
>                 return false;
>
>         hog->attrib = g_attrib_ref(gatt);
>
> +       if (!hog->attr && hog->gatt_db) {
> +               bt_uuid16_create(&uuid, HOG_UUID16);
> +               gatt_db_foreach_service(hog->gatt_db, &uuid,
> +                                       foreach_hog_service, hog);
> +       }
> +
>         if (!hog->attr && !hog->primary) {
>                 discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
>                 return true;
> @@ -1744,6 +1751,15 @@ void bt_hog_detach(struct bt_hog *hog)
>                 bt_hog_detach(instance);
>         }
>
> +       /* hog->attr doesn't own pointer, so it may be invalid when this hog
> +        * object gets re-attached with bt_hog_attach(). So intentionally mark
> +        * it as invalid and remove all instances so that the instances can be
> +        * re-attached at bt_hog_attach().
> +        */
> +       hog->attr = NULL;
> +       g_slist_free_full(hog->instances, hog_free);
> +       hog->instances = NULL;

We can actually what watches instead of cleanup always like this, see:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/gatt-db.h#n275

> +
>         for (l = hog->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
