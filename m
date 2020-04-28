Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B9BC83001
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8293F20B80
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC/JDCo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgD1Qz1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgD1Qz0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 12:55:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C4C03C1AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 09:55:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so33764455otq.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLvJcuFRC/ZcolV+ArabZiNadHe6cSL/JS7zQoCDGmU=;
        b=OC/JDCo99Xsz5nSbOTEMGi/2NPl6LM+ERheNdEw9MfuRjJG/o5XewqbwvGc1TV1mU6
         OPRAxG5N6EAH59iRDdN7CON6D9EASMkD0kyJ5J4HGEoe6blbVdFe+LKjZS+FVcGI1o90
         JM7uKR1cZ04TrneUtwPQlhWNNIWMncyQu7W8rR7yNHkCHAZJlL0jPLRHqqPfqZmyRMbu
         6f+fmtvgncVypqKiWvb9M+pNGPrmTF/ZfO3bUJ+VL8J/mhLcNieYLK+CdVRA5m579lUu
         fqoFvO1Upo1S1CrJg1IQG9z74pWU7gfgrAmTB/NH90C8UkHFlXlqNcsZwNJ08rL/3Uis
         arMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLvJcuFRC/ZcolV+ArabZiNadHe6cSL/JS7zQoCDGmU=;
        b=NaGSFAIau4daHkHREv+UHzTnc1y3abFN4kL20e5YogcX5dntaZXkl0WDV5V9iJRIgh
         iPYchwkT+WGzo9i5rvYmRW9u7PpU/xm2L4B77R6cmTzDh3KSk7lcQlwEME6dydCYtl7f
         +RW2lKps8EQINbK1TStn6sySkwR5PzMl30Vmmr03qLbGUi/Z6Mher+3fXfsmMoGUc2gp
         E7cVU0UKtG4sWP8EL6G8cDppxWSXZSf0UgZ9YxycD7K+iOC0UBjWeqpZYaDIxpOK4645
         DYoe2O6iZae2AqaJoqrUDHsp4UTBQhL0qccBbWm6roeAS5fgsIYLhFfLb14ffQy0auXu
         PpIQ==
X-Gm-Message-State: AGi0PuadrOXf3PXkJpnBGlY3UGTdOoVRyOvCZF/3+FsxXaI5o3hrbfUr
        ZUaZfLHv7mhpelB8DPqJYVwDfFDeIRm1wroA+Ddgi16z
X-Google-Smtp-Source: APiQypJFYuYiM+u3OdGxL0B4wBE651keO6FhcqW93PhcrbbiMPlzQ1UiR23BdjZ4hey2pjOEo071+ciAqX+/9BO01pI=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr24195893otn.79.1588092925991;
 Tue, 28 Apr 2020 09:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200421155828.Bluez.v1.1.I6e4fbf41b1815dc3d497da5d9c94b18e9c912cba@changeid>
 <CAJQfnxFxJwgAj+JWFFCG+b=zDRSX04a1e0mA2cB1fCpsJmoMug@mail.gmail.com>
In-Reply-To: <CAJQfnxFxJwgAj+JWFFCG+b=zDRSX04a1e0mA2cB1fCpsJmoMug@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Apr 2020 09:55:14 -0700
Message-ID: <CABBYNZKfN370XdXAoCYnT=JrHGLdr7apGw4D457=raxgGqsFwQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] gatt: Fix service_changed characteristic permission
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Apr 27, 2020 at 9:31 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi BlueZ maintainers,
>
> Please kindly take a look at this patch, thank you!
>
> On Tue, 21 Apr 2020 at 15:59, Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to bluetooth spec Ver 5.2, Vol 3, Part G, 7.1, the
> > service_changed characteristic is not readable. Therefore, this
> > patch marks it as such.
> > ---
> >
> >  src/gatt-database.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index f2da27694..8cbe09bae 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -1197,7 +1197,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
> >
> >         bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
> >         database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
> > -                               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_INDICATE,
> > +                               BT_ATT_PERM_NONE, BT_GATT_CHRC_PROP_INDICATE,
> >                                 NULL, NULL, database);
> >
> >         database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog

Applied, thanks.


-- 
Luiz Augusto von Dentz
