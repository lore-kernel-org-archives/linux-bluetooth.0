Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94177C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1E9206D4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 13:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1mxrPli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgG1NKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgG1NKw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 09:10:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB6C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 06:10:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so8440936ljn.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95kCl3s1NaB859WYZDS/Y6NEC7rOR7/y+2QJzEZMpfw=;
        b=I1mxrPliI5MxlTjT8QMHRt6r7t60UdvQYsDbtivwVphfSDVQ27kJKcReDTUn1RYi4j
         C6cZsodc7tfCGfzcLIiTJsHChjdyo0rqBNlqy7Oe3TvttgnIjuoDGE6pgG1llYfQEsOH
         zNDxI7ido9gsmQ0evJpJ1cuKxGUYNq1Xm85LHrCWTNBStwqHDGYV1g/9bFAAgo1jsVkx
         tyakQI03zp+gXu7aMrC7wFQBuk2/Smw04vwy7SFu6/kCIfWle+mcoBo/fulczgTP6DY+
         1G+f39zBXhqwMsyMgqluJcM/ri0bs7oPmZVNs3OK/NeKPM+yPZCYJX7NUx6tg5JrZnHO
         jQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95kCl3s1NaB859WYZDS/Y6NEC7rOR7/y+2QJzEZMpfw=;
        b=epO6TXprYf1l8zoyo5dVDAuiIqyNq6eNDHb8kreimWy0sUkgQkltPh4G2bpl+NFdav
         jLSxvKmhT/Wwx2l/yN0TGqptZD6/Fr6JHGLk3fIV91ZyNUSYhptHMtpZl4Z2V+9n2gs5
         KC88Kk/q1Zy+PBO77jFyGMViHARtfqbSa5Tbjqk1Cx2GtSLXvs5iQtRQQL2H+4rnzfq2
         S8HEPcAU7NfxSL5x6uySmGuZpfqL0WO+nF3qNhf3ZtHs+l3rt2dkHXKHT+/PC0FcOjtC
         4X0HGCfc2VQdXuQ2EHy9rjbkbgQDVUnM0Y2KOdrFpOJeRp6j1e/8DqhNAwwdyFpuDH/5
         JI2w==
X-Gm-Message-State: AOAM531h+ln5b9oLtA3sz7LctF1MIkfDsjRp3oMUyukk31hjoWbgD8E+
        SOGg1tiy7/meDTRLY75NeyiycUMxZQXPtSTNTJAuPg==
X-Google-Smtp-Source: ABdhPJx1c66cOnWZhvbkeO9iArCizfuVk6pyEYQ4en5MCSyTGq6LafLgcc4YOM2mryqHHHNMj64LuftfAiSsi81EfHw=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr11933053ljo.39.1595941850432;
 Tue, 28 Jul 2020 06:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200727173720.2700327-1-alainm@chromium.org> <17DA93F5-AB77-4C40-A5F2-38D8FE6C98A3@holtmann.org>
In-Reply-To: <17DA93F5-AB77-4C40-A5F2-38D8FE6C98A3@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 28 Jul 2020 09:10:39 -0400
Message-ID: <CALWDO_Wo23ev9DcpvUoDdfWQYqVRcSXp-mMysRgzpcC8auf3gQ@mail.gmail.com>
Subject: Re: [Bluez PATCH] main: adding configurable eir_max_name_len
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 28, 2020 at 2:58 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds support for a configurable eir_max_name_len for
> > platforms which requires a larger than 48 bytes complete name in EIR.
> >
> > From bluetoothctl:
> > [bluetooth]# system-alias
> > 012345678901234567890123456789012345678901234567890123456789
> > Changing 012345678901234567890123456789012345678901234567890123456789
> > succeeded
> > [CHG] Controller DC:71:96:69:02:89 Alias:
> > 012345678901234567890123456789012345678901234567890123456789
> >
> > From btmon:
> > < HCI Command: Write Local Name (0x03|0x0013) plen 248             #109
> > [hci0] 88.567990
> >         Name:
> > 012345678901234567890123456789012345678901234567890123456789
> >> HCI Event: Command Complete (0x0e) plen 4
> >    #110 [hci0] 88.663854
> >       Write Local Name (0x03|0x0013) ncmd 1
> >         Status: Success (0x00)
> > @ MGMT Event: Local Name Changed (0x0008) plen 260
> > {0x0004} [hci0] 88.663948
> >         Name:
> > 012345678901234567890123456789012345678901234567890123456789
> >         Short name:
> > < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
> >         FEC: Not required (0x00)
> >         Name (complete):
> > 012345678901234567890123456789012345678901234567890123456789
> >         TX power: 12 dBm
> >         Device ID: Bluetooth SIG assigned (0x0001)
> >           Vendor: Google (224)
> >           Product: 0xc405
> >           Version: 0.5.6 (0x0056)
> >         16-bit Service UUIDs (complete): 7 entries
> >           Generic Access Profile (0x1800)
> >           Generic Attribute Profile (0x1801)
> >           Device Information (0x180a)
> >           A/V Remote Control (0x110e)
> >           A/V Remote Control Target (0x110c)
> >           Handsfree Audio Gateway (0x111f)
> >           Audio Source (0x110a)
> >> HCI Event: Command Complete (0x0e) plen 4
> >       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
> >         Status: Success (0x00)
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > doc/mgmt-api.txt |  1 +
> > src/adapter.c    | 10 +++++++++-
> > src/hcid.h       |  1 +
> > src/main.c       |  5 +++++
> > src/main.conf    |  5 +++++
> > 5 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index ca0d38469..1bc0f0c12 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3279,6 +3279,7 @@ Read Default System Configuration Command
> >               0x0019  LE Connection Latency
> >               0x001a  LE Connection Supervision Timeout
> >               0x001b  LE Autoconnect Timeout
> > +             0x001c  Max EIR Name Length
>
> we can certainly do this, but I prefer that do this for LE and BR/EDR and name it that way as well.
I do think that we need distinct values for br/edr and le since the
available space is different.  I don't think a single value makes
sense for both transports.

>
> >
> >       This command can be used at any time and will return a list of
> >       supported default parameters as well as their current value.
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 5e896a9f0..3adc67b63 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -2375,7 +2375,7 @@ static bool parse_pathloss(DBusMessageIter *value,
> >       return true;
> > }
> >
> > -static bool parse_transport(DBusMessageIter *value,
> > +static bool parse_transport(DBusMessageIter *value,
> >                                       struct discovery_filter *filter)
> > {
> >       char *transport_str;
> > @@ -4435,6 +4435,14 @@ static void load_default_system_params(struct btd_adapter *adapter)
> >               len += sizeof(params[i].u16);
> >       }
> >
> > +     if (main_opts.default_params.eir_max_name_len) {
> > +             params[i].entry.type = 0x001c;
> > +             params[i].entry.length = sizeof(params[i].u16);
> > +             params[i].u16 = main_opts.default_params.eir_max_name_len;
> > +             ++i;
> > +             len += sizeof(params[i].u16);
> > +     }
> > +
>
> Do you really want to keep it as uint16_t or is that just laziness since changing the kernel to support anything other than uint16_t is complicated?
Yes, this is to re-use the existing infra without complicating the
buffer structure.  There are a couple more values that are effectively
uint8_t but use uint16_t above (like page scan type).

>
> On a side note, you need to provide a uint16_t value in little endian to the MGMT wire protocol.
Sounds like this is a separate issue that needs to be fixed for all
values then.  I'd rather keep that as a separate patch.

>
> >       err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> >                       adapter->dev_id, len, params, NULL, NULL, NULL);
> >       if (!err)
> > diff --git a/src/hcid.h b/src/hcid.h
> > index 5f249ebf9..c9b59a374 100644
> > --- a/src/hcid.h
> > +++ b/src/hcid.h
> > @@ -93,6 +93,7 @@ struct main_opts {
> >               uint16_t        le_conn_latency;
> >               uint16_t        le_conn_lsto;
> >               uint16_t        le_autoconnect_timeout;
> > +             uint16_t        eir_max_name_len;
> >       } default_params;
> >
> >
> > diff --git a/src/main.c b/src/main.c
> > index ec7a9fbd7..74876e01d 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -123,6 +123,7 @@ static const char *controller_options[] = {
> >       "LEConnectionLatency",
> >       "LEConnectionSupervisionTimeout",
> >       "LEAutoconnecttimeout",
> > +     "EirMaxNameLength",
> >       NULL
> > };
> >
> > @@ -433,6 +434,10 @@ static void parse_controller_config(GKeyFile *config)
> >                 &main_opts.default_params.le_autoconnect_timeout,
> >                 0x0001,
> >                 0x4000},
> > +             { "EirMaxNameLength",
> > +               &main_opts.default_params.eir_max_name_len,
> > +               0x0001,
> > +               0x00EE},
> >       };
> >       uint16_t i;
> >
> > diff --git a/src/main.conf b/src/main.conf
> > index f41203b96..7ecac5930 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -148,6 +148,11 @@
> > #LEConnectionSupervisionTimeout=
> > #LEAutoconnecttimeout=
> >
> > +# EIR Max Name. This is the maximum length for the COMPLETE_NAME EIR section.
> > +# If the name length exceeds this size, a SHORT_NAME section is used.
> > +# Default: 48
> > +#EirMaxNameLength = 48
> > +
> > [GATT]
> > # GATT attribute cache.
> > # Possible values:
>
> Regards
>
> Marcel
>
