Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765CC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 10:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIUKZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 06:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIUKZa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 06:25:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307AD46DB3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 03:25:28 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 63so7401742ybq.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n0tFFViZBX4xHdOeVYfpfbDFdQTEAge3AC3dFt1g4cs=;
        b=pweAfEE0PMqHvxIemYFx1yvbzpiC0862ZPk284c2x+VC0YAMnzN0X7FSYhJNFIPBlT
         PC6Wk+XJHlAq/H0yz4bpPF6fVYAFL7y4Bvmd6ZRJeB5qfLmfhRbm949ErLp+QTTP5PEM
         CZBWJbi7AdWPLqzt2gpL6Sxt2PpHXXPfOyDk4NpxrYoPgsrk8dc9EP+7Je0dAI0JYN3j
         o5F/OTbNIFdQYXEjF2Q3UUpulEvWcM8HNFV2uMIhEYJtejzA9gOnbpdaC08Af9qZ1B0q
         VZGlMo55VfJXa4JSOuKnUWdbf9otVongQzAxqk1DH6BKUgJhFHQV0suFi6vVTH5lAhQK
         UmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n0tFFViZBX4xHdOeVYfpfbDFdQTEAge3AC3dFt1g4cs=;
        b=yCVgVCVPX4Uq9p0MSFCRTFeIhmYgiV6PY8PKSb8rKQVwVTM0cFtcdPXdLPH7obdRcO
         fqxy7T2Z5JPR6JlIc6cC8sf2p80ap8RPZ2YBIDgFWkASjCyc+HQNSWEjFY0xhOqeTNoT
         gwGHWe4hrw7p73J5ndXIWPhWQ9piHj/badbctdvQYcVqP563yyrxmpqi+XrEPuceFvUf
         G+q1DvS3tXg7NmPUYIstP0POqG5jMfU1bajdaeMf0/uOABQWcilXEtbESY83T+AX5eq3
         qWFfcYDm9xIgbNm3UyglSk75ZkEQ00xSTYJKIpqc4NYLZqsNo7FBBl67yp7JlYQzvCYJ
         5KKw==
X-Gm-Message-State: ACrzQf208iZeAEMmquqlDU3mQaBxqyq9/ktT85iZ/W9ZzzfKAxcaSBnh
        7DkcggigH1JflBY2U5VvI3yfCP95EWZfe3Qv4Pk=
X-Google-Smtp-Source: AMsMyM7/1Dr5qdCTq369psfWekDRjklWmFnWfCa8xQ+5q7nuoTZqKZxXh3O7lIzjRdB2KTvd9YI5UJdMk0yjUS1HsTE=
X-Received: by 2002:a05:6902:1245:b0:6ae:325e:166a with SMTP id
 t5-20020a056902124500b006ae325e166amr24173288ybu.206.1663755926988; Wed, 21
 Sep 2022 03:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220920102847.599893-1-sathish.narasimman@intel.com> <CABBYNZK5-sL8Ls+1F2f7+NO7rK5B1z7tgfq+=Yh66Xgcesu7wg@mail.gmail.com>
In-Reply-To: <CABBYNZK5-sL8Ls+1F2f7+NO7rK5B1z7tgfq+=Yh66Xgcesu7wg@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 21 Sep 2022 15:55:15 +0530
Message-ID: <CAOVXEJJgOHdp_3xmZVkAM5hnmO_GdCna+ezRzsd17GquicUGqA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] sharaed/vcp: Add bt_vcp_set_debug
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Wed, Sep 21, 2022 at 2:14 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
> On Tue, Sep 20, 2022 at 3:29 AM Sathish Narasimman
> <sathish.narasimman@intel.com> wrote:
> >
> > This enables debug with bt_vcp_set_debug.
> > ---
> >  profiles/audio/vcp.c |   7 ++
> >  src/shared/vcp.c     | 238 +++++++++++++++++++++++++++----------------
> >  src/shared/vcp.h     |   5 +
> >  3 files changed, 163 insertions(+), 87 deletions(-)
> >
> > diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
> > index e7e84174e7d4..b42b0a4f79dd 100644
> > --- a/profiles/audio/vcp.c
> > +++ b/profiles/audio/vcp.c
> > @@ -62,6 +62,11 @@ struct vcp_data {
> >
> >  static struct queue *sessions;
> >
> > +static void vcp_debug(const char *str, void *user_data)
> > +{
> > +       DBG_IDX(0xffff, "%s", str);
> > +}
> > +
> >  static int vcp_disconnect(struct btd_service *service)
> >  {
> >         DBG("");
> > @@ -87,6 +92,8 @@ static void vcp_data_add(struct vcp_data *data)
> >                 return;
> >         }
> >
> > +       bt_vcp_set_debug(data->vcp, vcp_debug, NULL, NULL);
> > +
> >         if (!sessions)
> >                 sessions = queue_new();
>
> Let's have the above changes as a separate patch.
Sure will send as 2 seperate patches
>
> > diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> > index 4f8dc37e3c3e..3d0ff016d805 100644
> > --- a/src/shared/vcp.c
> > +++ b/src/shared/vcp.c
> > @@ -26,7 +26,9 @@
> >  #include "src/shared/gatt-server.h"
> >  #include "src/shared/gatt-client.h"
> >  #include "src/shared/vcp.h"
> > -#include "src/log.h"
> > +
> > +#define DBG(_vcp, fmt, arg...) \
> > +       vcp_debug(_vcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> >
> >  #define VCP_STEP_SIZE 1
> >
> > @@ -87,8 +89,11 @@ struct bt_vcp {
> >         unsigned int vstate_id;
> >         unsigned int vflag_id;
> >
> > +       struct queue *notify;
> >         struct queue *pending;
> >
> > +       bt_vcp_debug_func_t debug_func;
> > +       bt_vcp_destroy_func_t debug_destroy;
> >         void *debug_data;
> >         void *user_data;
> >  };
> > @@ -262,11 +267,23 @@ void bt_vcp_unref(struct bt_vcp *vcp)
> >         vcp_free(vcp);
> >  }
> >
> > +static void vcp_debug(struct bt_vcp *vcp, const char *format, ...)
> > +{
> > +       va_list ap;
> > +
> > +       if (!vcp || !format || !vcp->debug_func)
> > +               return;
> > +
> > +       va_start(ap, format);
> > +       util_debug_va(vcp->debug_func, vcp->debug_data, format, ap);
> > +       va_end(ap);
> > +}
> > +
> >  static void vcp_disconnected(int err, void *user_data)
> >  {
> >         struct bt_vcp *vcp = user_data;
> >
> > -       DBG("vcp %p disconnected err %d", vcp, err);
> > +       DBG(vcp, "vcp %p disconnected err %d", vcp, err);
> >
> >         bt_vcp_detach(vcp);
> >  }
> > @@ -301,17 +318,17 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         uint8_t *change_counter;
> >
> > -       DBG("");
> > +       DBG(vcp, "Volume Down");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
>
> While at it please fix the typos s/availalbe/available, there are
> quite a few of those.
Fixed and sent new patch sets.
>
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VSTATE not availalbe");
> > +               DBG(vcp, "error: VSTATE not availalbe");
> >                 return 0;
> >         }
> >
> > @@ -320,7 +337,7 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (*change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -340,17 +357,17 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         uint8_t *change_counter;
> >
> > -       DBG("");
> > +       DBG(vcp, "Volume Up");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VCP database not availalbe!!!!");
> > +               DBG(vcp, "error: VCP database not availalbe!!!!");
> >                 return 0;
> >         }
> >
> > @@ -359,7 +376,7 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (*change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -379,17 +396,17 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         uint8_t *change_counter;
> >
> > -       DBG("");
> > +       DBG(vcp, "Un Mute and Volume Down");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VCP database not availalbe!!!!");
> > +               DBG(vcp, "error: VCP database not availalbe!!!!");
> >                 return 0;
> >         }
> >
> > @@ -398,7 +415,7 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (*change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -419,17 +436,17 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         uint8_t *change_counter;
> >
> > -       DBG("");
> > +       DBG(vcp, "UN Mute and Volume Up");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VSTATE not availalbe");
> > +               DBG(vcp, "error: VSTATE not availalbe");
> >                 return 0;
> >         }
> >
> > @@ -438,7 +455,7 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (*change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -459,17 +476,17 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         struct bt_vcs_ab_vol *req;
> >
> > -       DBG("");
> > +       DBG(vcp, "Set Absolute Volume");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VSTATE not availalbe");
> > +               DBG(vcp, "error: VSTATE not availalbe");
> >                 return 0;
> >         }
> >
> > @@ -478,7 +495,7 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (req->change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -498,17 +515,17 @@ static uint8_t vcs_unmute(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         uint8_t *change_counter;
> >
> > -       DBG("");
> > +       DBG(vcp, "Un Mute");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VSTATE not availalbe");
> > +               DBG(vcp, "error: VSTATE not availalbe");
> >                 return 0;
> >         }
> >
> > @@ -517,7 +534,7 @@ static uint8_t vcs_unmute(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (*change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -537,17 +554,17 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >         struct vol_state *vstate;
> >         uint8_t *change_counter;
> >
> > -       DBG("");
> > +       DBG(vcp, "MUTE");
> >
> >         vdb = vcp_get_vdb(vcp);
> >         if (!vdb) {
> > -               DBG("error: VDB not availalbe");
> > +               DBG(vcp, "error: VDB not availalbe");
> >                 return 0;
> >         }
> >
> >         vstate = vdb_get_vstate(vdb);
> >         if (!vstate) {
> > -               DBG("error: VSTATE not availalbe");
> > +               DBG(vcp, "error: VSTATE not availalbe");
> >                 return 0;
> >         }
> >
> > @@ -556,7 +573,7 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
> >                 return 0;
> >
> >         if (*change_counter != vstate->counter) {
> > -               DBG("Change Counter Mismatch Volume not decremented!");
> > +               DBG(vcp, "Change Counter Mismatch Volume not decremented!");
> >                 return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >         }
> >
> > @@ -622,16 +639,16 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
> >         struct vcs_op_handler *handler;
> >         uint8_t ret = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> >
> > -       DBG("");
> > +       DBG(vcp, "VCP Control Point Write");
> >
> >         if (offset) {
> > -               DBG("invalid offset %d", offset);
> > +               DBG(vcp, "invalid offset %d", offset);
> >                 ret = BT_ATT_ERROR_INVALID_OFFSET;
> >                 goto respond;
> >         }
> >
> >         if (len < sizeof(*vcp_op)) {
> > -               DBG("invalid len %ld < %ld sizeof(*param)", len,
> > +               DBG(vcp, "invalid len %ld < %ld sizeof(*param)", len,
> >                                                         sizeof(*vcp_op));
> >                 ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> >                 goto respond;
> > @@ -639,14 +656,12 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
> >
> >         vcp_op = iov_pull_mem(&iov, sizeof(*vcp_op));
> >
> > -       DBG("op: %x", *vcp_op);
> > -
> >         for (handler = vcp_handlers; handler && handler->str; handler++) {
> >                 if (handler->op != *vcp_op)
> >                         continue;
> >
> >                 if (iov.iov_len < handler->size) {
> > -                       DBG("invalid len %ld < %ld handler->size", len,
> > +                       DBG(vcp, "invalid len %ld < %ld handler->size", len,
> >                             handler->size);
> >                         ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
> >                         goto respond;
> > @@ -656,11 +671,11 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
> >         }
> >
> >         if (handler && handler->str) {
> > -               DBG("%s", handler->str);
> > +               DBG(vcp, "%s", handler->str);
> >
> >                 ret = handler->func(vcs, vcp, &iov);
> >         } else {
> > -               DBG("Unknown opcode 0x%02x", *vcp_op);
> > +               DBG(vcp, "Unknown opcode 0x%02x", *vcp_op);
> >                 ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
> >         }
> >
> > @@ -676,8 +691,6 @@ static void vcs_state_read(struct gatt_db_attribute *attrib,
> >         struct bt_vcs *vcs = user_data;
> >         struct iovec iov;
> >
> > -       DBG("");
> > -
> >         iov.iov_base = vcs->vstate;
> >         iov.iov_len = sizeof(*vcs->vstate);
> >
> > @@ -693,8 +706,6 @@ static void vcs_flag_read(struct gatt_db_attribute *attrib,
> >         struct bt_vcs *vcs = user_data;
> >         struct iovec iov;
> >
> > -       DBG("vf: %x", vcs->vol_flag);
> > -
> >         iov.iov_base = &vcs->vol_flag;
> >         iov.iov_len = sizeof(vcs->vol_flag);
> >
> > @@ -797,6 +808,22 @@ void bt_vcp_add_db(struct gatt_db *db)
> >         vcp_db_new(db);
> >  }
> >
> > +bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t func,
> > +                       void *user_data, bt_vcp_destroy_func_t destroy)
> > +{
> > +       if (!vcp)
> > +               return false;
> > +
> > +       if (vcp->debug_destroy)
> > +               vcp->debug_destroy(vcp->debug_data);
> > +
> > +       vcp->debug_func = func;
> > +       vcp->debug_destroy = destroy;
> > +       vcp->debug_data = user_data;
> > +
> > +       return true;
> > +}
> > +
> >  unsigned int bt_vcp_register(bt_vcp_func_t attached, bt_vcp_func_t detached,
> >                                                         void *user_data)
> >  {
> > @@ -871,40 +898,28 @@ done:
> >         return vcp;
> >  }
> >
> > -static void vcp_vstate_register(uint16_t att_ecode, void *user_data)
> > -{
> > -       DBG("");
> > -       if (att_ecode)
> > -               DBG("VCS register failed: 0x%04x", att_ecode);
> > -}
> > -
> > -static void vcp_vflag_register(uint16_t att_ecode, void *user_data)
> > -{
> > -       DBG("");
> > -       if (att_ecode)
> > -               DBG("VCS register failed: 0x%04x", att_ecode);
> > -}
> > -
> > -static void vcp_vstate_notify(uint16_t value_handle, const uint8_t *value,
> > -                               uint16_t length, void *user_data)
> > +static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
> > +                               const uint8_t *value, uint16_t length,
> > +                               void *user_data)
> >  {
> >         struct vol_state vstate;
> >
> >         memcpy(&vstate, value, sizeof(struct vol_state));
> >
> > -       DBG("Vol Settings 0x%x", vstate.vol_set);
> > -       DBG("Mute Status 0x%x", vstate.mute);
> > -       DBG("Vol Counter 0x%x", vstate.counter);
> > +       DBG(vcp, "Vol Settings 0x%x", vstate.vol_set);
> > +       DBG(vcp, "Mute Status 0x%x", vstate.mute);
> > +       DBG(vcp, "Vol Counter 0x%x", vstate.counter);
> >  }
> >
> > -static void vcp_vflag_notify(uint16_t value_handle, const uint8_t *value,
> > -                               uint16_t length, void *user_data)
> > +static void vcp_vflag_notify(struct bt_vcp *vcp, uint16_t value_handle,
> > +                            const uint8_t *value, uint16_t length,
> > +                            void *user_data)
> >  {
> >         uint8_t vflag;
> >
> >         memcpy(&vflag, value, sizeof(vflag));
> >
> > -       DBG("Vol Flag 0x%x", vflag);
> > +       DBG(vcp, "Vol Flag 0x%x", vflag);
> >  }
> >
> >  static void read_vol_flag(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
> > @@ -918,17 +933,17 @@ static void read_vol_flag(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
> >         };
> >
> >         if (!success) {
> > -               DBG("Unable to read VCP Vol State: error 0x%02x", att_ecode);
> > +               DBG(vcp, "Unable to read Vol Flag: error 0x%02x", att_ecode);
> >                 return;
> >         }
> >
> >         vol_flag = iov_pull_mem(&iov, sizeof(*vol_flag));
> >         if (!vol_flag) {
> > -               DBG("Unable to get Vol State");
> > +               DBG(vcp, "Unable to get Vol Flag");
> >                 return;
> >         }
> >
> > -       DBG("Vol Flag:%x", *vol_flag);
> > +       DBG(vcp, "Vol Flag:%x", *vol_flag);
> >  }
> >
> >  static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
> > @@ -942,19 +957,19 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
> >         };
> >
> >         if (!success) {
> > -               DBG("Unable to read VCP Vol State: error 0x%02x", att_ecode);
> > +               DBG(vcp, "Unable to read Vol State: error 0x%02x", att_ecode);
> >                 return;
> >         }
> >
> >         vs = iov_pull_mem(&iov, sizeof(*vs));
> >         if (!vs) {
> > -               DBG("Unable to get Vol State");
> > +               DBG(vcp, "Unable to get Vol State");
> >                 return;
> >         }
> >
> > -       DBG("Vol Set:%x", vs->vol_set);
> > -       DBG("Vol Mute:%x", vs->mute);
> > -       DBG("Vol Counter:%x", vs->counter);
> > +       DBG(vcp, "Vol Set:%x", vs->vol_set);
> > +       DBG(vcp, "Vol Mute:%x", vs->mute);
> > +       DBG(vcp, "Vol Counter:%x", vs->counter);
> >  }
> >
> >  static void vcp_pending_destroy(void *data)
> > @@ -991,7 +1006,7 @@ static void vcp_read_value(struct bt_vcp *vcp, uint16_t value_handle,
> >                                                 vcp_pending_complete, pending,
> >                                                 vcp_pending_destroy);
> >         if (!pending->id) {
> > -               DBG("Unable to send Read request");
> > +               DBG(vcp, "Unable to send Read request");
> >                 free(pending);
> >                 return;
> >         }
> > @@ -999,6 +1014,60 @@ static void vcp_read_value(struct bt_vcp *vcp, uint16_t value_handle,
> >         queue_push_tail(vcp->pending, pending);
> >  }
> >
> > +static void vcp_register(uint16_t att_ecode, void *user_data)
> > +{
> > +       struct bt_vcp_notify *notify = user_data;
> > +
> > +       if (att_ecode)
> > +               DBG(notify->vcp, "VCP register failed: 0x%04x", att_ecode);
> > +}
> > +
> > +static void vcp_notify(uint16_t value_handle, const uint8_t *value,
> > +                               uint16_t length, void *user_data)
> > +{
> > +       struct bt_vcp_notify *notify = user_data;
> > +
> > +       if (notify->func)
> > +               notify->func(notify->vcp, value_handle, value, length,
> > +                                               notify->user_data);
> > +}
> > +
> > +static void vcp_notify_destroy(void *data)
> > +{
> > +       struct bt_vcp_notify *notify = data;
> > +       struct bt_vcp *vcp = notify->vcp;
> > +
> > +       if (queue_remove_if(vcp->notify, NULL, notify))
> > +               free(notify);
> > +}
> > +
> > +static unsigned int vcp_register_notify(struct bt_vcp *vcp,
> > +                                       uint16_t value_handle,
> > +                                       vcp_notify_t func,
> > +                                       void *user_data)
> > +{
> > +       struct bt_vcp_notify *notify;
> > +
> > +       notify = new0(struct bt_vcp_notify, 1);
> > +       notify->vcp = vcp;
> > +       notify->func = func;
> > +       notify->user_data = user_data;
> > +
> > +       notify->id = bt_gatt_client_register_notify(vcp->client,
> > +                                               value_handle, vcp_register,
> > +                                               vcp_notify, notify,
> > +                                               vcp_notify_destroy);
> > +       if (!notify->id) {
> > +               DBG(vcp, "Unable to register for notifications");
> > +               free(notify);
> > +               return 0;
> > +       }
> > +
> > +       queue_push_tail(vcp->notify, notify);
> > +
> > +       return notify->id;
> > +}
> > +
> >  static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
> >  {
> >         struct bt_vcp *vcp = user_data;
> > @@ -1006,7 +1075,6 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
> >         bt_uuid_t uuid, uuid_vstate, uuid_cp, uuid_vflag;
> >         struct bt_vcs *vcs;
> >
> > -       DBG("");
> >         if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> >                                                 NULL, NULL, &uuid))
> >                 return;
> > @@ -1016,7 +1084,7 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
> >         bt_uuid16_create(&uuid_vflag, VOL_FLAG_CHRC_UUID);
> >
> >         if (!bt_uuid_cmp(&uuid, &uuid_vstate)) {
> > -               DBG("VCS Volume state found: handle 0x%04x", value_handle);
> > +               DBG(vcp, "VCS Vol state found: handle 0x%04x", value_handle);
> >
> >                 vcs = vcp_get_vcs(vcp);
> >                 if (!vcs || vcs->vs)
> > @@ -1025,16 +1093,15 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
> >                 vcs->vs = attr;
> >
> >                 vcp_read_value(vcp, value_handle, read_vol_state, vcp);
> > -               vcp->vstate_id = bt_gatt_client_register_notify(vcp->client,
> > -                                               value_handle,
> > -                                               vcp_vstate_register,
> > -                                               vcp_vstate_notify, vcp, NULL);
> > +
> > +               vcp->vstate_id = vcp_register_notify(vcp, value_handle,
> > +                                                    vcp_vstate_notify, NULL);
> >
> >                 return;
> >         }
> >
> >         if (!bt_uuid_cmp(&uuid, &uuid_cp)) {
> > -               DBG("VCS Volume CP found: handle 0x%04x", value_handle);
> > +               DBG(vcp, "VCS Volume CP found: handle 0x%04x", value_handle);
> >
> >                 vcs = vcp_get_vcs(vcp);
> >                 if (!vcs || vcs->vol_cp)
> > @@ -1046,7 +1113,7 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
> >         }
> >
> >         if (!bt_uuid_cmp(&uuid, &uuid_vflag)) {
> > -               DBG("VCS Vol Flaf found: handle 0x%04x", value_handle);
> > +               DBG(vcp, "VCS Vol Flag found: handle 0x%04x", value_handle);
> >
> >                 vcs = vcp_get_vcs(vcp);
> >                 if (!vcs || vcs->vf)
> > @@ -1055,12 +1122,10 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
> >                 vcs->vf = attr;
> >
> >                 vcp_read_value(vcp, value_handle, read_vol_flag, vcp);
> > -               vcp->vflag_id = bt_gatt_client_register_notify(vcp->client,
> > -                                               value_handle,
> > -                                               vcp_vflag_register,
> > -                                               vcp_vflag_notify, vcp, NULL);
> > -       }
> > +               vcp->vflag_id = vcp_register_notify(vcp, value_handle,
> > +                                                   vcp_vflag_notify, NULL);
> >
> > +       }
> >  }
> >
> >  static void foreach_vcs_service(struct gatt_db_attribute *attr,
> > @@ -1069,7 +1134,6 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
> >         struct bt_vcp *vcp = user_data;
> >         struct bt_vcs *vcs = vcp_get_vcs(vcp);
> >
> > -       DBG("");
> >         vcs->service = attr;
> >
> >         gatt_db_service_set_claimed(attr, true);
> > diff --git a/src/shared/vcp.h b/src/shared/vcp.h
> > index 1a999c7776fd..26db5732d19b 100644
> > --- a/src/shared/vcp.h
> > +++ b/src/shared/vcp.h
> > @@ -33,6 +33,8 @@
> >
> >  struct bt_vcp;
> >
> > +typedef void (*bt_vcp_destroy_func_t)(void *user_data);
> > +typedef void (*bt_vcp_debug_func_t)(const char *str, void *user_data);
> >  typedef void (*bt_vcp_func_t)(struct bt_vcp *vcp, void *user_data);
> >
> >  struct bt_vcp *bt_vcp_ref(struct bt_vcp *vcp);
> > @@ -43,6 +45,9 @@ void bt_vcp_add_db(struct gatt_db *db);
> >  bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client);
> >  void bt_vcp_detach(struct bt_vcp *vcp);
> >
> > +bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t cb,
> > +                       void *user_data, bt_vcp_destroy_func_t destroy);
> > +
> >  struct bt_att *bt_vcp_get_att(struct bt_vcp *vcp);
> >
> >  bool bt_vcp_set_user_data(struct bt_vcp *vcp, void *user_data);
> > --
> > 2.25.1
> >
>
>
> --
> Luiz Augusto von Dentz


Sathish N
