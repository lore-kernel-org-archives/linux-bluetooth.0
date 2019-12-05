Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54276C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C620801
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 16:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sig3GpjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfLEQPY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:15:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43436 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfLEQPY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 11:15:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so4210128ljm.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWfXrS7pkV7bWALzCDZMNyE4I1aM9p6Vgp6avHsupyk=;
        b=sig3GpjQpXeq4uUi0Ux4wJy76Le8Pml2m4vdIRz07CCQEJpihsjBQgm61VtdZsB9k8
         3My6zGACVfBISR6/yjKYoQAvl+BLDP2ISdy1Re8KINpAjPYq6oATC/t0FxWrSqLbGfLr
         yeSp2CV1OTp65XwYsN6L8VMt30SXbejNMWwYsojSBsXi/s1LNgfbHoN6xmZ1M3KkZR/1
         oFHh0cD1+esVcIkMyww69/sAkFu+26SWik0FsetLvK8trq0CV/rltQyBg3460Jtm8BeI
         6j4n70jqS44Bi8qrQgcs+2/o8fmH/VsXP1iVEznBrTA0eb2z1wr7547G6he4JtcZHYBi
         Plew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWfXrS7pkV7bWALzCDZMNyE4I1aM9p6Vgp6avHsupyk=;
        b=k6HmmuQRKaUI69R4fx6gAcc8UawEBJP/Mrum+6vXG3hKMnGkGkpydL6qq8kp++Jbqy
         bVx5OpOWIvC67GZKVcyLRspdC5wKVHB11E0/HCGs5ddyeQSG2bR91xE+geKkDa5Cbidb
         /dXqOLgtLrtr249/bVvMNKVKTL8H0cxjdRhZroTex54qXJcL7kYadkVXvAcHRVm5s//l
         GefHLWxSjsP7n5z9jiRGXZBfl0RTnD6GSHo6B50fOPBaZb5WA/RQ1v98G2iqSi1bmCw+
         oeUZhXnG6/r7JEYq84OFEetkSOiJvJjsupS3XJW70FZXSOPaEP86vmHgzRJs+Cof/hYY
         E9FQ==
X-Gm-Message-State: APjAAAX5NBON8AkKfC4MwAL/BKBhFeepALHw+tNbb7/sXc/kXOYXJCk3
        0qFkd0+mjnSJa9IasXuww1sMGxPmEgOlGsB2IaPe7g==
X-Google-Smtp-Source: APXvYqy+B0F7u30Opb+3BE4pPiJIX/pe9gGvDMgIuZ6DhFy2aBM22nuKW5KYN/2XIVehTAEPskVRCn1IQJHgU4F5rzk=
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr5901903ljk.245.1575562521386;
 Thu, 05 Dec 2019 08:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20191204013306.29935-1-alainm@chromium.org> <D5E83A6A-608A-461D-8C8F-50C7A6F79C1B@holtmann.org>
In-Reply-To: <D5E83A6A-608A-461D-8C8F-50C7A6F79C1B@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 5 Dec 2019 11:15:09 -0500
Message-ID: <CALWDO_Xg4sEYQdNEQp9_AtyPLk8M5iOuLB3MMVLLTbcweCZ0gw@mail.gmail.com>
Subject: Re: [RFC BlueZ] Adding support for blocking keys and mgmt tests.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks again for the feedback Marcel.  Some comments inline, will send
a v2 shortly to address your comments.

On Thu, Dec 5, 2019 at 2:54 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > Would love feedback on this.  Corresponding kernel change also sent for
> > comments.
> >
> > ---
> > lib/mgmt.h       | 12 +++++++++
> > src/adapter.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++----
> > unit/test-mgmt.c | 33 ++++++++++++++++++++++++
> > 3 files changed, 107 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index 570dec997..fa50a3656 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -583,6 +583,18 @@ struct mgmt_cp_set_phy_confguration {
> >       uint32_t        selected_phys;
> > } __packed;
> >
> > +#define MGMT_OP_SET_BLOCKED_KEYS     0x0046
> > +struct mgmt_blocked_key_info {
> > +     uint8_t type;
> > +     uint8_t val[16];
> > +} __packed;
> > +
> > +struct mgmt_cp_set_blocked_keys {
> > +     uint16_t key_count;
> > +     struct mgmt_blocked_key_info keys[0];
> > +} __packed;
> > +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
> > +
> >
> > #define MGMT_EV_CMD_COMPLETE          0x0001
> > struct mgmt_ev_cmd_complete {
> > diff --git a/src/adapter.c b/src/adapter.c
> > index cef25616f..1b451af30 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -99,6 +99,19 @@
> > #define DISTANCE_VAL_INVALID  0x7FFF
> > #define PATHLOSS_MAX          137
> >
> > +/**
> > + * These are known security keys that have been compromised.
> > + * If this grows or there are needs to be platform specific, it is
> > + * conceivable that these could be read from a config file.
> > +*/
> > +static const struct mgmt_blocked_key_info blocked_keys [] = {
> > +     // Google Titan Security Keys
> > +     { 0x01 /* LTK */, {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
> > +                                     0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
> > +     { 0x02 /* IRK */, {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
> > +                                     0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
> > +};
> > +
> > static DBusConnection *dbus_conn = NULL;
> >
> > static bool kernel_conn_control = false;
> > @@ -8827,6 +8840,40 @@ failed:
> >       btd_adapter_unref(adapter);
> > }
> >
> > +static void set_blocked_ltks_complete(uint8_t status, uint16_t length,
> > +                                     const void *param, void *user_data)
> > +{
> > +     struct btd_adapter *adapter = user_data;
> > +
> > +     if (status != MGMT_STATUS_SUCCESS) {
> > +             btd_error(adapter->dev_id,
> > +                             "Failed to set blocked LTKs: %s (0x%02x)",
> > +                             mgmt_errstr(status), status);
> > +             return;
> > +     }
> > +
> > +     DBG("Successfully set blocked keys for index %u", adapter->dev_id);
> > +}
> > +
> > +static bool set_blocked_keys(uint16_t index, struct btd_adapter *adapter)
> > +{
> > +     uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
> > +                                     sizeof(blocked_keys)] = { 0 };
> > +     struct mgmt_cp_set_blocked_keys *cp =
> > +                                     (struct mgmt_cp_set_blocked_keys *)buffer;
> > +     int i;
> > +
> > +     cp->key_count = G_N_ELEMENTS(blocked_keys);
> > +     for (i = 0; i < cp->key_count; ++i) {
> > +             cp->keys[i].type = blocked_keys[i].type;
> > +             memcpy(cp->keys[i].val, blocked_keys[i].val, sizeof(cp->keys[i].val));
> > +     }
> > +
> > +     return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, index,
> > +                                     sizeof(buffer), buffer, read_info_complete, adapter, NULL);
>
> wrong callback here.
[alain] Oups, indeed, nice catch. Fixed.
>
> > +}
> > +
> > +
> > static void index_added(uint16_t index, uint16_t length, const void *param,
> >                                                       void *user_data)
> > {
> > @@ -8861,15 +8908,25 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
> >        */
> >       adapter_list = g_list_append(adapter_list, adapter);
> >
> > -     DBG("sending read info command for index %u", index);
> > +     DBG("Setting blocked keys for index %u", index);
> > +     if (!set_blocked_keys(index, adapter)){
> > +             btd_error(adapter->dev_id,
> > +                     "Failed to set blocked keys for index %u", index);
> > +             // TODO: Until the MGMT is ported to all kernels, this is best effort.
> > +     }
>
> Just check if the command is supported. We have a list of supported commands.
[alain] Thanks, I couldn't find that originally, but found a similar
check for MGMT_OP_ADD_DEVICE now.

> >
> > -     if (mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
> > -                                     read_info_complete, adapter, NULL) > 0)
> > -             return;
> > +     DBG("sending read info command for index %u", index);
> >
> > -     btd_error(adapter->dev_id,
> > +     if (!mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
> > +                                     read_info_complete, adapter, NULL) > 0) {
> > +             btd_error(adapter->dev_id,
> >                       "Failed to read controller info for index %u", index);
> > +                     goto unload;
> > +     }
> > +
> > +     return;
>
> We need to keep the read info the first command. The blocked keys setting should happen either just before loading the keys or right after.
[alain] My logic was to actually set the block before the other modes
are set in read_info_complete. I moved it in the next version, please
let me know if that makes more sense to you.
>
> >
> > +unload:
> >       adapter_list = g_list_remove(adapter_list, adapter);
> >
> >       btd_adapter_unref(adapter);
> > diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
> > index c67678b9a..d73c03f61 100644
> > --- a/unit/test-mgmt.c
> > +++ b/unit/test-mgmt.c
> > @@ -256,6 +256,33 @@ static const struct command_test_data command_test_3 = {
> >       .rsp_status = MGMT_STATUS_INVALID_INDEX,
> > };
>
> Separate patch for the tests please and I think something went wrong in your email client or editor.
[alain] Since the tests also depends on the mgmt.h changes, do you
have a proposal on how best to organize these to avoid conflicts since
they both depend on the mgmt.h changes?  I'm also not sure what you
mean about the formatting, I used git send-email...
>
> >
> > +static const unsigned char invalid_key_buffer[] =
> > + { 0x01, 0x02 };
> > +
> > +static const struct command_test_data command_test_set_blocked_keys1 = {
> > + .opcode = MGMT_OP_SET_BLOCKED_KEYS,
> > + .index = MGMT_INDEX_NONE,
> > + .cmd_data = invalid_key_buffer,
> > + .cmd_size = sizeof(invalid_key_buffer),
> > + .rsp_data = NULL,
> > + .rsp_size = 0,
> > + .rsp_status = MGMT_STATUS_INVALID_PARAMS,
> > +};
> > +
> > +static const unsigned char valid_keys_buffer1[] =
> > + { 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
> > + 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
> > +
> > +static const struct command_test_data command_test_set_blocked_keys2 = {
> > + .opcode = MGMT_OP_SET_BLOCKED_KEYS,
> > + .index = MGMT_INDEX_NONE,
> > + .cmd_data = valid_keys_buffer1,
> > + .cmd_size = sizeof(valid_keys_buffer1),
> > + .rsp_data = NULL,
> > + .rsp_size = 0,
> > + .rsp_status = MGMT_STATUS_SUCCESS,
> > +};
> > +
> > static const unsigned char event_index_added[] =
> >                               { 0x04, 0x00, 0x01, 0x00, 0x00, 0x00 };
> >
> > @@ -441,6 +468,12 @@ int main(int argc, char *argv[])
> >       g_test_add_data_func("/mgmt/response/2", &command_test_3,
> >                                                               test_response);
> >
> > +     g_test_add_data_func("/mgmt/command/set_blocked_keys1",
> > +                                             &command_test_set_blocked_keys1, test_command);
> > +
> > +     g_test_add_data_func("/mgmt/command/set_blocked_keys2",
> > +                                             &command_test_set_blocked_keys2, test_command);
> > +
> >       g_test_add_data_func("/mgmt/event/1", &event_test_1, test_event);
> >       g_test_add_data_func("/mgmt/event/2", &event_test_1, test_event2);
>
> Regards
>
> Marcel
>
