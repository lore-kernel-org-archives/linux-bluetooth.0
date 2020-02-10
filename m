Return-Path: <SRS0=FZvY=36=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E913EC352A4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 21:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5262072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrNdy2Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBJVH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:07:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39522 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJVHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Feb 2020 16:07:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so10629934oih.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2020 13:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NQFUkkF+hurW4fzFEkfWOspDIcEJZe6/7TervLbbdAQ=;
        b=qrNdy2OakMisvXY/2yr6LETur3n8r127AbUoMdwN5cfSMX3gBuSwfCH7I/CfJi2fsr
         YZSdg8+x9lSALZGDuOZ0QeKIlakODzlqLrDR7YN+j5apUE5v8d2ej5e4loSzAYJCy1mD
         k5DvmyFSh5B3GPalTo4CtaFoQ1TZzd2pTrV7M8ub1sgHHMhk2Sti/0jyaaaq80PEJbYJ
         sSizFiLyKv9RhftRU3jgvsJKuqrDei4c4OdyqkccBDjfJ0gxhD9wbz0faLaHrcXWMcUP
         oof6wh+MxzCtzdI/itSrbifEw6hNUKOwcqE0AtMSJQkLLuwlGshyzvLrcgqnA/xh51Dq
         45iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NQFUkkF+hurW4fzFEkfWOspDIcEJZe6/7TervLbbdAQ=;
        b=WMwhuOkldaDG19kB3D9U7lJoo+ggxUbdOhhYI1K+YqS24FLoAxrAZf3CF/vscEgeZc
         dMZeHJGfdQDvCsIi8kX7U9dPRR1JxH3XEgqP+jwBeABGl2Ae14C8u//9XZnbC/7zGf8f
         QJyQDAKIiI+gEh7ZmYpeUdOBv+tYprJD37eDxmRJEci4GOJv76/fkdJBdRoajQTULudz
         ixbKCi5V1d+HnBxUR/DPlz1Xs9y6FVxejI8OT/NBD3gM9Vcx4xKXMKDWv/+xz8FeM/4X
         Ezn3GZqnbEbzvFllfUaR64D8YwMn/g/qyNsBffLpOXkqAPY+9GCVJARkI3IoqZuxMTiI
         wrVg==
X-Gm-Message-State: APjAAAWaJudAUnmy+tuPLbJJSF6yN1KkEFM485sPgno8xgenv+XWPXWy
        Di9VzfdOqGBC1Z2KBTGCnOld4KqsVKUo9bC6auY=
X-Google-Smtp-Source: APXvYqwzrBy0Ui8yWk0Andg4UpBtnkKRZXiNYl9HeHvYwCT7lbIdUG5oifgeK/Cz3c2d0UaqbP94rDH1hx26jMhrPA4=
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr678036oic.8.1581368874209;
 Mon, 10 Feb 2020 13:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20200207193741.Bluez.v1.1.Ibaab6d18071354eb57b66a22de24d0fa995d86b8@changeid>
 <2E96AC9F-37F7-4951-9033-7E865B44A6B8@holtmann.org>
In-Reply-To: <2E96AC9F-37F7-4951-9033-7E865B44A6B8@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Feb 2020 13:07:42 -0800
Message-ID: <CABBYNZJ4iS9Do+32TQU1pgxom0Wk_Zpf=OmksJquBD5A6Y1=HQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] core: Add new policy for Just-Works repairing
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Howard Chung <howardchung@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Sat, Feb 8, 2020 at 12:27 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Howard,
>
> > When kernel find out that the incoming Just-Works pairing is
> > initiated by a paired device, it is user space's responsibility to
> > decide the next action.
> >
> > This patch includes the following:
> > - add JustWorksRepairing policy as an option in main.conf
> > - handle the confirmation request from kernel
> >
> > ---
> > The Just-Works repairing policy could be one of the following:
> > - never: default; reject the repairing immediately.
> > - confirm: prompt a confirmation dialog to user.
> > - always: always accept the repairing.
> >
> > Note that the confirmation dialog is only available in command
> > line for now.
> >
> > client/agent.c | 22 +++++++++++++++++++
> > src/adapter.c  | 13 +++++++++++
> > src/agent.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > src/agent.h    |  4 ++++
> > src/device.c   | 14 +++++++++---
> > src/hcid.h     |  8 +++++++
> > src/main.c     | 27 +++++++++++++++++++++++
> > src/main.conf  |  5 +++++
> > 8 files changed, 149 insertions(+), 3 deletions(-)
>
> you also need to document this in doc/agent-api.txt and we normally split=
 patches into doc/, src/ and client/ changes.
>
> >
> > diff --git a/client/agent.c b/client/agent.c
> > index 4def1b478..544344c46 100644
> > --- a/client/agent.c
> > +++ b/client/agent.c
> > @@ -239,6 +239,25 @@ static DBusMessage *request_authorization(DBusConn=
ection *conn,
> >       return NULL;
> > }
> >
> > +static DBusMessage *request_drop_old_key(DBusConnection *conn,
> > +                                     DBusMessage *msg, void *user_data=
)
> > +{
> > +     const char *device;
> > +
> > +     bt_shell_printf("Request drop old key\n");
> > +
> > +     dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
> > +                                                     DBUS_TYPE_INVALID=
);
> > +
> > +     bt_shell_prompt_input("agent",
> > +                           "Drop the old key and accept pairing (yes/n=
o):",
> > +                           confirm_response, conn);
> > +
> > +     pending_message =3D dbus_message_ref(msg);
> > +
> > +     return NULL;
> > +}
> > +
> > static DBusMessage *authorize_service(DBusConnection *conn,
> >                                       DBusMessage *msg, void *user_data=
)
> > {
> > @@ -292,6 +311,9 @@ static const GDBusMethodTable methods[] =3D {
> >       { GDBUS_ASYNC_METHOD("RequestAuthorization",
> >                       GDBUS_ARGS({ "device", "o" }),
> >                       NULL, request_authorization) },
> > +     { GDBUS_ASYNC_METHOD("RequestDropOldKey",
> > +                     GDBUS_ARGS({ "device", "o" }),
> > +                     NULL, request_drop_old_key) },
> >       { GDBUS_ASYNC_METHOD("AuthorizeService",
> >                       GDBUS_ARGS({ "device", "o" }, { "uuid", "s" }),
>
> I am not fully convinced with the name yet. Can we start with a patch tha=
t just has the policy in main.conf for always and never.

I was thinking we should just use RequestAuthorization which according
to the documentation was introduced exactly to deal with JustWorks
pairing, the agent can then check if the device has been already
paired and reject it if it wants to, that way we don't need a fallback
mechanism (which most likely would use RequestAuthorization anyway).

> >                       NULL,  authorize_service) },
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 329c3ae0b..cecd80ea1 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -6909,6 +6909,19 @@ static void user_confirm_request_callback(uint16=
_t index, uint16_t length,
> >               return;
> >       }
> >
> > +     /*Just-Works repairing policy*/
>
> Please follow our coding style for comments.
>
> > +     if (ev->confirm_hint =3D=3D 2) {
> > +             if (main_opts.jw_repairing =3D=3D JW_REPAIRING_NEVER) {
> > +                     btd_adapter_confirm_reply(adapter, &ev->addr.bdad=
dr,
> > +                                                     ev->addr.type, FA=
LSE);
> > +                     return;
> > +             } else if (main_opts.jw_repairing =3D=3D JW_REPAIRING_ALW=
AYS) {
> > +                     btd_adapter_confirm_reply(adapter, &ev->addr.bdad=
dr,
> > +                                                     ev->addr.type, TR=
UE);
> > +                     return;
> > +             }
> > +     }
> > +
> >       err =3D device_confirm_passkey(device, ev->addr.type, btohl(ev->v=
alue),
> >                                                       ev->confirm_hint)=
;
> >       if (err < 0) {
> > diff --git a/src/agent.c b/src/agent.c
> > index e0ffcd22f..3a75e3b00 100644
> > --- a/src/agent.c
> > +++ b/src/agent.c
> > @@ -60,6 +60,7 @@ typedef enum {
> >       AGENT_REQUEST_PASSKEY,
> >       AGENT_REQUEST_CONFIRMATION,
> >       AGENT_REQUEST_AUTHORIZATION,
> > +     AGENT_REQUEST_DROP_OLD_KEY,
> >       AGENT_REQUEST_PINCODE,
> >       AGENT_REQUEST_AUTHORIZE_SERVICE,
> >       AGENT_REQUEST_DISPLAY_PINCODE,
> > @@ -239,6 +240,7 @@ void agent_unref(struct agent *agent)
> >                       break;
> >               case AGENT_REQUEST_CONFIRMATION:
> >               case AGENT_REQUEST_AUTHORIZATION:
> > +             case AGENT_REQUEST_DROP_OLD_KEY:
> >               case AGENT_REQUEST_AUTHORIZE_SERVICE:
> >               case AGENT_REQUEST_DISPLAY_PINCODE:
> >               default:
> > @@ -798,6 +800,63 @@ failed:
> >       return err;
> > }
> >
> > +static int drop_old_key_request_new(struct agent_request *req,
> > +                                             const char *device_path)
> > +{
> > +     struct agent *agent =3D req->agent;
> > +
> > +     req->msg =3D dbus_message_new_method_call(agent->owner, agent->pa=
th,
> > +                             AGENT_INTERFACE, "RequestDropOldKey");
> > +     if (req->msg =3D=3D NULL) {
> > +             error("Couldn't allocate D-Bus message");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     dbus_message_append_args(req->msg,
> > +                             DBUS_TYPE_OBJECT_PATH, &device_path,
> > +                             DBUS_TYPE_INVALID);
> > +
> > +     if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req=
->msg,
> > +                             &req->call, REQUEST_TIMEOUT) =3D=3D FALSE=
) {
> > +             error("D-Bus send failed");
> > +             return -EIO;
> > +     }
> > +
> > +     dbus_pending_call_set_notify(req->call, simple_agent_reply, req, =
NULL);
> > +
> > +     return 0;
> > +}
> > +
> > +int agent_request_drop_old_key(struct agent *agent, struct btd_device =
*device,
> > +                                             agent_cb cb, void *user_d=
ata,
> > +                                             GDestroyNotify destroy)
> > +{
> > +     struct agent_request *req;
> > +     const char *dev_path =3D device_get_path(device);
> > +     int err;
> > +
> > +     if (agent->request)
> > +             return -EBUSY;
> > +
> > +     DBG("Calling Agent.DropOldKey: name=3D%s, path=3D%s",
> > +                                             agent->owner, agent->path=
);
> > +
> > +     req =3D agent_request_new(agent, device, AGENT_REQUEST_DROP_OLD_K=
EY, cb,
> > +                             user_data, destroy);
> > +
> > +     err =3D drop_old_key_request_new(req, dev_path);
> > +     if (err < 0)
> > +             goto failed;
> > +
> > +     agent->request =3D req;
> > +
> > +     return 0;
> > +
> > +failed:
> > +     agent_request_free(req, FALSE);
> > +     return err;
> > +}
> > +
>
> You need to build in a graceful fallback for agents that are not capable =
of handling the new agent callbacks.
>
> > int agent_display_passkey(struct agent *agent, struct btd_device *devic=
e,
> >                               uint32_t passkey, uint16_t entered)
> > {
> > diff --git a/src/agent.h b/src/agent.h
> > index 1438b9e6d..ccc651dba 100644
> > --- a/src/agent.h
> > +++ b/src/agent.h
> > @@ -65,6 +65,10 @@ int agent_request_authorization(struct agent *agent,=
 struct btd_device *device,
> >                                               agent_cb cb, void *user_d=
ata,
> >                                               GDestroyNotify destroy);
> >
> > +int agent_request_drop_old_key(struct agent *agent, struct btd_device =
*device,
> > +                                             agent_cb cb, void *user_d=
ata,
> > +                                             GDestroyNotify destroy);
> > +
> > int agent_display_passkey(struct agent *agent, struct btd_device *devic=
e,
> >                               uint32_t passkey, uint16_t entered);
> >
> > diff --git a/src/device.c b/src/device.c
> > index a4fe10980..e460e034f 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -6147,12 +6147,20 @@ int device_confirm_passkey(struct btd_device *d=
evice, uint8_t type,
> >
> >       auth->passkey =3D passkey;
> >
> > -     if (confirm_hint)
> > +     switch (confirm_hint) {
> > +     case 0:
> > +             err =3D agent_request_confirmation(auth->agent, device, p=
asskey,
> > +                                             confirm_cb, auth, NULL);
> > +             break;
> > +     case 1:
> >               err =3D agent_request_authorization(auth->agent, device,
> >                                               confirm_cb, auth, NULL);
> > -     else
> > -             err =3D agent_request_confirmation(auth->agent, device, p=
asskey,
> > +             break;
> > +     case 2:
> > +             err =3D agent_request_drop_old_key(auth->agent, device,
> >                                               confirm_cb, auth, NULL);
> > +             break;
> > +     }
> >
> >       if (err < 0) {
> >               if (err =3D=3D -EINPROGRESS) {
> > diff --git a/src/hcid.h b/src/hcid.h
> > index adea85ce2..bcd2b9fa1 100644
> > --- a/src/hcid.h
> > +++ b/src/hcid.h
> > @@ -35,6 +35,12 @@ typedef enum {
> >       BT_GATT_CACHE_NO,
> > } bt_gatt_cache_t;
> >
> > +enum {
> > +     JW_REPAIRING_NEVER,
> > +     JW_REPAIRING_CONFIRM,
> > +     JW_REPAIRING_ALWAYS,
> > +} jw_repairing_t;
> > +
> > struct main_opts {
> >       char            *name;
> >       uint32_t        class;
> > @@ -58,6 +64,8 @@ struct main_opts {
> >       uint16_t        gatt_mtu;
> >
> >       uint8_t         key_size;
> > +
> > +     jw_repairing_t  jw_repairing;
> > };
> >
> > extern struct main_opts main_opts;
> > diff --git a/src/main.c b/src/main.c
> > index 1a6ab36a3..d67f469f1 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -93,6 +93,7 @@ static const char *supported_options[] =3D {
> >       "MultiProfile",
> >       "FastConnectable",
> >       "Privacy",
> > +     "JustWorksRepairing",
> >       NULL
> > };
> >
> > @@ -193,6 +194,20 @@ static bt_gatt_cache_t parse_gatt_cache(const char=
 *cache)
> >       }
> > }
> >
> > +static jw_repairing_t parse_jw_repairing(const char *jw_repairing)
> > +{
> > +     if (!strcmp(jw_repairing, "never")) {
> > +             return JW_REPAIRING_NEVER;
> > +     } else if (!strcmp(jw_repairing, "confirm")) {
> > +             return JW_REPAIRING_CONFIRM;
> > +     } else if (!strcmp(jw_repairing, "always")) {
> > +             return JW_REPAIRING_ALWAYS;
> > +     } else {
> > +             return JW_REPAIRING_NEVER;
> > +     }
> > +}
> > +
> > +
> > static void check_options(GKeyFile *config, const char *group,
> >                                               const char **options)
> > {
> > @@ -331,6 +346,18 @@ static void parse_config(GKeyFile *config)
> >               g_free(str);
> >       }
> >
> > +     str =3D g_key_file_get_string(config, "General",
> > +                                             "JustWorksRepairing", &er=
r);
> > +     if (err) {
> > +             DBG("%s", err->message);
> > +             g_clear_error(&err);
> > +             main_opts.jw_repairing =3D JW_REPAIRING_NEVER;
> > +     } else {
> > +             DBG("just_works_repairing=3D%s", str);
> > +             main_opts.jw_repairing =3D parse_jw_repairing(str);
> > +             g_free(str);
> > +     }
> > +
> >       str =3D g_key_file_get_string(config, "General", "Name", &err);
> >       if (err) {
> >               DBG("%s", err->message);
> > diff --git a/src/main.conf b/src/main.conf
> > index 40687a755..bb5ff5b15 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -72,6 +72,11 @@
> > # Defaults to "off"
> > # Privacy =3D off
> >
> > +# Specify the policy to the JUST-WORKS repairing initiated by peer
> > +# Possible values: "never", "confirm", "always"
> > +# Defaults to "never"
> > +#JustWorksRepairing =3D never
> > +
> > [GATT]
> > # GATT attribute cache.
> > # Possible values:
>
> The word =E2=80=9Crepairing=E2=80=9D always makes me question if that is =
the best name. I leave this open for comments from others.
>
> Regards
>
> Marcel
>


--
Luiz Augusto von Dentz
