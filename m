Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2181C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D22F20675
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE4t8Ik4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCGIYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:24:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40695 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGIYw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 03:24:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id v20so13361387otk.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2019 00:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OXGtXEWtZe+Tx7RGczeg61cvqZhsLm4oKzG0ADiYg6w=;
        b=gE4t8Ik4a+/RoDbGQ1FkSMJ9AjvPwtv7YvQAGox1mqq4f33QnLbeI+6jeXEf2mnTrD
         lIcO4DrV1WizfWtJHXCKPkrbPYj9oY3bqZc2L02WVK0CULAO7ghOpTp/A9+pEgB5Ucpm
         PuzMFcKmyMsJ4TPHQy0KepJQHMpveyOrF7sXHaTPJWZGaJw4EJ9+pgjJcX1myfPl+f5v
         jbLmUfSYyvidkzpIuaUgYvZBR+q2OBhhSt6nKV5g6toO35Sx7H9kdLkh8crlQ5GWOSpO
         DxKBdrDDp48OljYtLmqQfuQnO9tYBuzOOobS+bO5Z5RYtpGfrxddpo3SPIz9R11yo2kZ
         Zypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OXGtXEWtZe+Tx7RGczeg61cvqZhsLm4oKzG0ADiYg6w=;
        b=MCaWdqVR33RE1FOJAw1vXyDCI6Maqzy/XHpOme71oY/Frcwl4FrUjC6HuChObqSz6S
         xXBkysdEZisuB1ugM68YJJR5bpP4WW9+QF32y2d4BO3BtyautM9/SfHYtQdYZA/JUMJ1
         WvKLAT+A/iV2ksohtpIdfLnqJKW+YQwqjeN8lP4tJFuR9MuOihruDfh3YIXMwg32pkBE
         I5oO2JKNi4epVoSQmrQA8Xya47g4pIwWangCkxV0ZUGaVKPlYJ+dLJmZH5dAwCIbgTMQ
         9WYIwN8cENWbbVUMn2Nvvu9O34HJNJSRgNI/QcW+oJwkUFpZmWv3MvOJPIxXumOfCcGb
         cmqQ==
X-Gm-Message-State: APjAAAVw9of3C6Mdd9lLyNdM0JxUuzYj/vQKgoRfWTSphZM9sXyMoaEk
        ss58T6AvUXkjycbz2pp+14IMVSNnHNhAgB9ep0nBkxvQ
X-Google-Smtp-Source: APXvYqxCmMT5ux4fD3o+bAjA/znAfrtFsKD3D9nSWiNabNZn1ZiFahBLBLAfGnW2fi0CO51P70Hidvf0zBLVdt8rGDk=
X-Received: by 2002:a05:6830:1543:: with SMTP id l3mr7496376otp.84.1551947091468;
 Thu, 07 Mar 2019 00:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20190306125224.14427-1-luiz.dentz@gmail.com>
In-Reply-To: <20190306125224.14427-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Mar 2019 10:24:40 +0200
Message-ID: <CABBYNZJA079QausGy73rwBLQqcXWdY4vTdHKt8HfoKr8KQc41g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix length calculation of filter UUIDs on
 big endian
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Wed, Mar 6, 2019 at 2:52 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The management interface expect all values to be in little endian
> thus the length of uuids needs to be converted on big endian.
> ---
>  src/adapter.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index b8a6bb6e2..160a6ca52 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1602,10 +1602,12 @@ static gboolean start_discovery_timeout(gpointer user_data)
>         sd_cp = adapter->current_discovery_filter;
>
>         DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
> -                               sd_cp->rssi, sd_cp->type, sd_cp->uuid_count);
> +                               sd_cp->rssi, sd_cp->type,
> +                               btohs(sd_cp->uuid_count));
>
>         mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
> -                 adapter->dev_id, sizeof(*sd_cp) + sd_cp->uuid_count * 16,
> +                 adapter->dev_id, sizeof(*sd_cp) +
> +                 btohs(sd_cp->uuid_count) * 16,
>                   sd_cp, start_discovery_complete, adapter, NULL);
>
>         return FALSE;
> @@ -2076,7 +2078,7 @@ static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
>
>         cp->type = discovery_type;
>         cp->rssi = rssi;
> -       cp->uuid_count = uuid_count;
> +       cp->uuid_count = htobs(uuid_count);
>         populate_mgmt_filter_uuids(cp->uuids, uuids);
>
>         g_slist_free(uuids);
> --
> 2.17.2
>

Applied.

-- 
Luiz Augusto von Dentz
