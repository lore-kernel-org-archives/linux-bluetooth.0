Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629E4C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHIUFj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjHIUFi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 16:05:38 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A28210B
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 13:05:30 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 553B5240101
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 22:05:28 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RLgyv5ST5z9rxN;
        Wed,  9 Aug 2023 22:05:27 +0200 (CEST)
Message-ID: <9caafe989acc5b6b63424ac45e0a92c1dc0e5569.camel@iki.fi>
Subject: Re: [PATCH BlueZ] adapter: wait for kernel exp features in adapter
 initialization
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Aug 2023 20:05:27 +0000
In-Reply-To: <CABBYNZ+_w5pk+H6pOtutfgUJZoEGrVJyh9qwDm0nEV4CE6hYEg@mail.gmail.com>
References: <429cbc5a4fcdb150c62cf368c928e1174016eefb.1691606987.git.pav@iki.fi>
         <CABBYNZ+_w5pk+H6pOtutfgUJZoEGrVJyh9qwDm0nEV4CE6hYEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ke, 2023-08-09 kello 12:52 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Wed, Aug 9, 2023 at 12:14 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Things like BAP depend on ISO sockets being enabled in kernel.  It is
> > possible the MGMT commands enabling experimental kernel features do not
> > complete, before BAP etc. initialization and probing starts, in which
> > case BAP will be mostly nonfunctional.
> > 
> > This was observed to occur always when running BlueZ in a Fedora VM,
> > requiring bluetoothd restart after every boot for BAP to work,
> > log containing lines in the order:
> > 
> > bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1
> > bluetoothd[981]: src/adapter.c:read_info_complete() index 0 status 0x00
> > bluetoothd[981]: profiles/audio/bap.c:bap_probe() BAP requires ISO Socket which is not enabled
> > bluetoothd[981]: src/adapter.c:iso_socket_complete() ISO Socket successfully set
> > 
> > Fix by waiting in adapter initialization that all MGMT exp feature
> > requests are done, before proceeding to read adapter information.
> > 
> > Also fix canceling MGMT_OP_SET_EXP_FEATURE for ISO sockets.
> > ---
> >  src/adapter.c | 90 ++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 71 insertions(+), 19 deletions(-)
> > 
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 004062e7c..608c06f9e 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -331,6 +331,8 @@ struct btd_adapter {
> > 
> >         bool is_default;                /* true if adapter is default one */
> > 
> > +       unsigned int set_exp_iso_id;
> > +       unsigned int exp_pending;
> 
> Lets use a struct queue to store these ids, since there could be more
> than one pending and there could be more of these races with other
> drivers.

Ack, I can do that maybe it is simpler.

Note though the current version does wait for all mgmt calls, and
cleanup should also be right. set_exp_iso_id is special since that's on
MGMT_INDEX_NONE so the mgmt_cancel_index cleanup in adapter_free won't
cancel it.

> 
> >         struct queue *exps;
> >  };
> > 
> > @@ -5782,6 +5784,8 @@ static void adapter_free(gpointer user_data)
> >         g_queue_free(adapter->auths);
> >         queue_destroy(adapter->exps, NULL);
> > 
> > +       adapter->exp_pending = 0;
> > +
> >         /*
> >          * Unregister all handlers for this specific index since
> >          * the adapter bound to them is no longer valid.
> > @@ -5796,6 +5800,8 @@ static void adapter_free(gpointer user_data)
> >          * since the adapter bound to them is no longer valid.
> >          */
> >         mgmt_cancel_index(adapter->mgmt, adapter->dev_id);
> > +       if (adapter->set_exp_iso_id)
> > +               mgmt_cancel(adapter->mgmt, adapter->set_exp_iso_id);
> > 
> >         mgmt_unref(adapter->mgmt);
> > 
> > @@ -6895,6 +6901,8 @@ static void adapter_remove(struct btd_adapter *adapter)
> > 
> >         g_slist_free(adapter->msd_callbacks);
> >         adapter->msd_callbacks = NULL;
> > +
> > +       adapter->exp_pending = 0;
> >  }
> > 
> >  const char *adapter_get_path(struct btd_adapter *adapter)
> > @@ -9824,6 +9832,8 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
> >         .func = _func, \
> >  }
> > 
> > +static void exp_complete(void *user_data);
> > +
> >  static void set_exp_debug_complete(uint8_t status, uint16_t len,
> >                                         const void *param, void *user_data)
> >  {
> > @@ -9854,8 +9864,10 @@ static void exp_debug_func(struct btd_adapter *adapter, uint8_t action)
> > 
> >         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> >                         adapter->dev_id, sizeof(cp), &cp,
> > -                       set_exp_debug_complete, adapter, NULL) > 0)
> > +                       set_exp_debug_complete, adapter, exp_complete) > 0) {
> > +               ++adapter->exp_pending;
> >                 return;
> > +       }
> > 
> >         btd_error(adapter->dev_id, "Failed to set exp debug");
> >  }
> > @@ -9904,8 +9916,11 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint8_t action)
> > 
> >         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> >                         adapter->dev_id, sizeof(cp), &cp,
> > -                       set_rpa_resolution_complete, adapter, NULL) > 0)
> > +                       set_rpa_resolution_complete, adapter,
> > +                       exp_complete) > 0) {
> > +               ++adapter->exp_pending;
> >                 return;
> > +       }
> > 
> >         btd_error(adapter->dev_id, "Failed to set RPA Resolution");
> >  }
> > @@ -9940,12 +9955,22 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
> > 
> >         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> >                         adapter->dev_id, sizeof(cp), &cp,
> > -                       codec_offload_complete, adapter, NULL) > 0)
> > +                       codec_offload_complete, adapter, exp_complete) > 0) {
> > +               ++adapter->exp_pending;
> >                 return;
> > +       }
> > 
> >         btd_error(adapter->dev_id, "Failed to set Codec Offload");
> >  }
> > 
> > +static void iso_socket_done(void *user_data)
> > +{
> > +       struct btd_adapter *adapter = user_data;
> > +
> > +       adapter->set_exp_iso_id = 0;
> > +       exp_complete(adapter);
> > +}
> > +
> >  static void iso_socket_complete(uint8_t status, uint16_t len,
> >                                 const void *param, void *user_data)
> >  {
> > @@ -9969,15 +9994,20 @@ static void iso_socket_complete(uint8_t status, uint16_t len,
> >  static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
> >  {
> >         struct mgmt_cp_set_exp_feature cp;
> > +       unsigned int id;
> > 
> >         memset(&cp, 0, sizeof(cp));
> >         memcpy(cp.uuid, iso_socket_uuid.val, 16);
> >         cp.action = action;
> > 
> > -       if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> > -                       MGMT_INDEX_NONE, sizeof(cp), &cp,
> > -                       iso_socket_complete, adapter, NULL) > 0)
> > +       id = mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
> > +                       sizeof(cp), &cp, iso_socket_complete, adapter,
> > +                       iso_socket_done);
> > +       if (id > 0) {
> > +               adapter->set_exp_iso_id = id;
> > +               ++adapter->exp_pending;
> >                 return;
> > +       }
> > 
> >         btd_error(adapter->dev_id, "Failed to set ISO Socket");
> >  }
> > @@ -10063,8 +10093,10 @@ static void read_exp_features(struct btd_adapter *adapter)
> >  {
> >         if (mgmt_send(adapter->mgmt, MGMT_OP_READ_EXP_FEATURES_INFO,
> >                         adapter->dev_id, 0, NULL, read_exp_features_complete,
> > -                       adapter, NULL) > 0)
> > +                       adapter, exp_complete) > 0) {
> > +               ++adapter->exp_pending;
> >                 return;
> > +       }
> > 
> >         btd_error(adapter->dev_id, "Failed to read exp features info");
> >  }
> > @@ -10389,6 +10421,36 @@ static void reset_adv_monitors(uint16_t index)
> >         error("Failed to reset Adv Monitors");
> >  }
> > 
> > +static void read_info(struct btd_adapter *adapter)
> > +{
> > +       DBG("sending read info command for index %u", adapter->dev_id);
> > +
> > +       if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, adapter->dev_id, 0, NULL,
> > +                                       read_info_complete, adapter, NULL) > 0)
> > +               return;
> > +
> > +       btd_error(adapter->dev_id,
> > +                       "Failed to read controller info for index %u",
> > +                       adapter->dev_id);
> > +
> > +       adapter_list = g_list_remove(adapter_list, adapter);
> > +
> > +       btd_adapter_unref(adapter);
> > +}
> > +
> > +static void exp_complete(void *user_data)
> > +{
> > +       struct btd_adapter *adapter = user_data;
> > +
> > +       adapter->exp_pending--;
> > +
> > +       DBG("index %u has %u pending MGMT EXP requests", adapter->dev_id,
> > +                                                       adapter->exp_pending);
> > +
> > +       if (!adapter->exp_pending)
> > +               read_info(adapter);
> > +}
> > +
> >  static void index_added(uint16_t index, uint16_t length, const void *param,
> >                                                         void *user_data)
> >  {
> > @@ -10435,18 +10497,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
> >          */
> >         adapter_list = g_list_append(adapter_list, adapter);
> > 
> > -       DBG("sending read info command for index %u", index);
> > -
> > -       if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, index, 0, NULL,
> > -                                       read_info_complete, adapter, NULL) > 0)
> > -               return;
> > -
> > -       btd_error(adapter->dev_id,
> > -                       "Failed to read controller info for index %u", index);
> > -
> > -       adapter_list = g_list_remove(adapter_list, adapter);
> > -
> > -       btd_adapter_unref(adapter);
> > +       if (!adapter->exp_pending)
> > +               read_info(adapter);
> >  }
> > 
> >  static void index_removed(uint16_t index, uint16_t length, const void *param,
> > --
> > 2.41.0
> > 
> 
> 

