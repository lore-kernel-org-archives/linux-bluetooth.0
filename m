Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41D464F4D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhCPWvq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhCPWvn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 18:51:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBBDC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:51:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r17so74833220ejy.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDUAp2BwmSa8spG9F52+f1M+92d4fZoRtpyPyRog+98=;
        b=Enf6DzDwdO/uQHXIqgn36J5wp11QwYFbftK0QxORPqh4+s1JSIOZhpJAOXbBs2IwnU
         mFYbXbYQ+CxWfTl9xGvOSEtzGTp6G3NQMgeJY8PD5Viy2Yesoe11NZiXPNbHl2jyPk6M
         0bosEAtafpIMJ9yVOs/zpkZPoaY0eP7572VHZxaQ7lC5k5kTQB360lUqC52HBabM9etD
         bYo1JB9BSw59HWMN0TwqLQyxcgPcqh9DiGiQEqvOr9t1JQur5/dzhwqwfga5Xdptcgr9
         b0loxVq0wd4pwKT4uIWA24IZ8nU0K8sDjP4jy9kHMr+g+zvflX6G1bh7mYVeo9l26+hX
         CDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDUAp2BwmSa8spG9F52+f1M+92d4fZoRtpyPyRog+98=;
        b=ku/a70Xga3wC8YW93kthOPngeUEZ/doRgep7txTS9F+27pSVAt5t9P8HK45kLCUvjI
         EaZA0XOGGAeYqmiKGyfra3WNCZVCY8JmUFwDXWF6XAKXwBjwOdlxWIzX0LmYVp/CA3+V
         FOr0fPqJhNTEmr16tobuiTXMvx1hJRkle2xDj+i4jt3yMfQOKZ29kGLGSCp63/0zVAUs
         HHjy64oql+kEFyTdRJDTktRvAJWSfmwV26OdE33YMl666uy8w7afGMAOXmedYFTyB/TP
         Lf01A/CW/nB9mMr0fHLY6Yi+T3uprGEatbNTdo8q8elc1iahHRYBceOs+I4qwVrQtp2m
         UtZg==
X-Gm-Message-State: AOAM532mupPN/7ARguEdpKqs4fAhHYWxiPQZt6XSyAWULV7gDuLJSv5p
        u8s+MMijQIc37micXWeokbj+68RXy7xRriszVFvS818GTLY=
X-Google-Smtp-Source: ABdhPJxoSU9ptSGcloht40mJlNWTmleBklJOK+51atla0KQpInmZMmW/WrJ1/OIzD++/WhWs2Kd7Xy5Mn0JTm+lR7YA=
X-Received: by 2002:a17:906:1155:: with SMTP id i21mr31748038eja.218.1615935101866;
 Tue, 16 Mar 2021 15:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210304202452.1998022-1-danielwinkler@google.com>
 <20210304122005.Bluez.v2.1.I1411482bfff45aecdec1bc8c895fc7148ee3f50c@changeid>
 <CABBYNZJoGGuiCMhV-NLQ=XmwXiJdguShA_Q9wah+qx7Fz2pwGw@mail.gmail.com>
 <CAP2xMbtXcNGWKmSeSGbznzyXPVuS6bC9B5O5duEthCap2YuD-g@mail.gmail.com> <CABBYNZJyuduy6Oo38RtMhQoBNUEOQ0t8pf0ZdUqdkOvS33W2NA@mail.gmail.com>
In-Reply-To: <CABBYNZJyuduy6Oo38RtMhQoBNUEOQ0t8pf0ZdUqdkOvS33W2NA@mail.gmail.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Tue, 16 Mar 2021 15:51:30 -0700
Message-ID: <CAP2xMbtyUC4cc8ktsqQ8VH5SvFwu9CwYwosig5R50bCBy90iVA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/3] advertising: Generate advertising data
 earlier in pipeline
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Sorry for the delay. I think I understand your reservations now, and
have just uploaded a V3 that uses helpers to determine if the instance
will be scannable, rather than storing a duplicated copy of adv data
and scan response. Please take a look at your convenience.

Best,
Daniel


On Thu, Mar 4, 2021 at 3:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Daniel,
>
> On Thu, Mar 4, 2021 at 3:27 PM Daniel Winkler <danielwinkler@google.com> wrote:
> >
> > Hi Luiz,
> >
> > Can you please clarify your suggestion? The issue here is that some
> > properties (local name, for instance) aren't incorporated into the
> > bt_ad object until generate_scan_rsp is called. I decided to move the
> > generation of data/scan response to be earlier because otherwise the
> > logic to determine if the scan response was empty would require some
> > repetitive logic that already exists in generate_scan_rsp.
> >
> > Or are you suggesting that we not store adv_data_len and scan_rsp_len
> > in the btd_adv_client, but instead store it in the bt_ad object? This
> > seems possible to me, but it might require a bit more effort to keep
> > the length property in sync. I'll wait for your clarification.
>
> Yep, the included flags may have to be calculated separately, but I
> thought the whole point here is to be able to tell if there is any
> scan_rsp to be added so perhaps just return a bool would be enough to
> then set the flag so we can continue to generate the data itself at
> later stage.
>
> > Thanks!
> > Daniel
> >
> > On Thu, Mar 4, 2021 at 2:49 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On Thu, Mar 4, 2021 at 12:25 PM Daniel Winkler <danielwinkler@google.com> wrote:
> > > >
> > > > This change moves the advertising data generation to the beginning of
> > > > the registration pipeline. This is necessary for the following patch,
> > > > which will need to know whether the scan response data is existent so
> > > > that the parameter request can be populated correctly.
> > > >
> > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > >
> > > > ---
> > > >
> > > > Changes in v2: None
> > > >
> > > >  src/advertising.c | 79 +++++++++++++++++++++++++----------------------
> > > >  1 file changed, 42 insertions(+), 37 deletions(-)
> > > >
> > > > diff --git a/src/advertising.c b/src/advertising.c
> > > > index 15a343e52..f3dc357a1 100644
> > > > --- a/src/advertising.c
> > > > +++ b/src/advertising.c
> > > > @@ -80,6 +80,10 @@ struct btd_adv_client {
> > > >         uint32_t flags;
> > > >         struct bt_ad *data;
> > > >         struct bt_ad *scan;
> > > > +       uint8_t *adv_data;
> > > > +       uint8_t *scan_rsp;
> > > > +       size_t adv_data_len;
> > > > +       size_t scan_rsp_len;
> > >
> > > I'm debating if we should really just encode it early or we could just
> > > introduce something like bt_ad_length so we don't have to have copies
> > > of the same data in 2 different formats since bt_ad already represents
> > > that.
> > >
> > > >         uint8_t instance;
> > > >         uint32_t min_interval;
> > > >         uint32_t max_interval;
> > > > @@ -141,6 +145,16 @@ static void client_free(void *data)
> > > >         bt_ad_unref(client->data);
> > > >         bt_ad_unref(client->scan);
> > > >
> > > > +       if (client->adv_data) {
> > > > +               free(client->adv_data);
> > > > +               client->adv_data = NULL;
> > > > +       }
> > > > +
> > > > +       if (client->scan_rsp) {
> > > > +               free(client->scan_rsp);
> > > > +               client->scan_rsp = NULL;
> > > > +       }
> > > > +
> > > >         g_dbus_proxy_unref(client->proxy);
> > > >
> > > >         if (client->owner)
> > > > @@ -915,6 +929,22 @@ static int refresh_extended_adv(struct btd_adv_client *client,
> > > >                 flags |= MGMT_ADV_PARAM_TX_POWER;
> > > >         }
> > > >
> > > > +       client->adv_data = generate_adv_data(client, &flags,
> > > > +                                               &client->adv_data_len);
> > > > +       if (!client->adv_data ||
> > > > +               (client->adv_data_len > calc_max_adv_len(client, flags))) {
> > > > +               error("Advertising data too long or couldn't be generated.");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       client->scan_rsp = generate_scan_rsp(client, &flags,
> > > > +                                               &client->scan_rsp_len);
> > > > +       if (!client->scan_rsp && client->scan_rsp_len) {
> > > > +               error("Scan data couldn't be generated.");
> > > > +               free(client->adv_data);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > >         cp.flags = htobl(flags);
> > > >
> > > >         mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
> > > > @@ -1222,11 +1252,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
> > > >         const struct mgmt_rp_add_ext_adv_params *rp = param;
> > > >         struct mgmt_cp_add_ext_adv_data *cp = NULL;
> > > >         uint8_t param_len;
> > > > -       uint8_t *adv_data = NULL;
> > > > -       size_t adv_data_len;
> > > > -       uint8_t *scan_rsp = NULL;
> > > > -       size_t scan_rsp_len = -1;
> > > > -       uint32_t flags = 0;
> > > >         unsigned int mgmt_ret;
> > > >         dbus_int16_t tx_power;
> > > >
> > > > @@ -1248,23 +1273,8 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
> > > >
> > > >         client->instance = rp->instance;
> > > >
> > > > -       flags = get_adv_flags(client);
> > > > -
> > > > -       adv_data = generate_adv_data(client, &flags, &adv_data_len);
> > > > -       if (!adv_data || (adv_data_len > rp->max_adv_data_len)) {
> > > > -               error("Advertising data too long or couldn't be generated.");
> > > > -               goto fail;
> > > > -       }
> > > > -
> > > > -       scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
> > > > -       if ((!scan_rsp && scan_rsp_len) ||
> > > > -                       scan_rsp_len > rp->max_scan_rsp_len) {
> > > > -               error("Scan data couldn't be generated.");
> > > > -               goto fail;
> > > > -       }
> > > > -
> > > > -       param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
> > > > -                                                       scan_rsp_len;
> > > > +       param_len = sizeof(struct mgmt_cp_add_advertising) +
> > > > +                       client->adv_data_len + client->scan_rsp_len;
> > > >
> > > >         cp = malloc0(param_len);
> > > >         if (!cp) {
> > > > @@ -1273,15 +1283,11 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
> > > >         }
> > > >
> > > >         cp->instance = client->instance;
> > > > -       cp->adv_data_len = adv_data_len;
> > > > -       cp->scan_rsp_len = scan_rsp_len;
> > > > -       memcpy(cp->data, adv_data, adv_data_len);
> > > > -       memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
> > > > -
> > > > -       free(adv_data);
> > > > -       free(scan_rsp);
> > > > -       adv_data = NULL;
> > > > -       scan_rsp = NULL;
> > > > +       cp->adv_data_len = client->adv_data_len;
> > > > +       cp->scan_rsp_len = client->scan_rsp_len;
> > > > +       memcpy(cp->data, client->adv_data, client->adv_data_len);
> > > > +       memcpy(cp->data + client->adv_data_len, client->scan_rsp,
> > > > +                       client->scan_rsp_len);
> > > >
> > > >         /* Submit request to update instance data */
> > > >         mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_DATA,
> > > > @@ -1305,12 +1311,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
> > > >         return;
> > > >
> > > >  fail:
> > > > -       if (adv_data)
> > > > -               free(adv_data);
> > > > -
> > > > -       if (scan_rsp)
> > > > -               free(scan_rsp);
> > > > -
> > > >         if (cp)
> > > >                 free(cp);
> > > >
> > > > @@ -1454,6 +1454,11 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
> > > >         if (!client->scan)
> > > >                 goto fail;
> > > >
> > > > +       client->adv_data = NULL;
> > > > +       client->scan_rsp = NULL;
> > > > +       client->adv_data_len = 0;
> > > > +       client->scan_rsp_len = 0;
> > > > +
> > > >         client->manager = manager;
> > > >         client->appearance = UINT16_MAX;
> > > >         client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
> > > > --
> > > > 2.30.1.766.gb4fecdf3b7-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
