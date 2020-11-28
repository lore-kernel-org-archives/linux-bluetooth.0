Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC452C8301D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Nov 2020 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835B122256
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Nov 2020 22:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbgK1Vtw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:52 -0500
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.118]:33356 "EHLO
        atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732581AbgK1RyQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Nov 2020 12:54:16 -0500
Received: from jax4mhob04.registeresite.com (jax4mhob04.myregisteredsite.com [64.69.218.84])
        by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0ASH5Mfh001701
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2020 12:05:22 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.94])
        by jax4mhob04.registeresite.com (8.14.4/8.14.4) with ESMTP id 0ASH5Kqa001541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2020 12:05:20 -0500
Received: (qmail 110135 invoked by uid 0); 28 Nov 2020 17:05:20 -0000
X-TCPREMOTEIP: 65.41.18.216
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@65.41.18.216)
  by 0 with ESMTPA; 28 Nov 2020 17:05:19 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 0D48015404E6;
        Sat, 28 Nov 2020 12:05:19 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9vblFsxfABLd; Sat, 28 Nov 2020 12:05:12 -0500 (EST)
Received: from z230.lan (z230.lan [192.168.1.3])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 55C8F1540499;
        Sat, 28 Nov 2020 12:05:12 -0500 (EST)
Message-ID: <64b4d0e7e44b9726b8664e16461905cf8b90f20d.camel@ewol.com>
Subject: Re: [PATCH BlueZ] mesh: Fix errors found by static analysis
From:   Steve Brown <sbrown@ewol.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Date:   Sat, 28 Nov 2020 12:05:12 -0500
In-Reply-To: <f836d2e0148e2b156bd5837f651e6d43808541a9.camel@intel.com>
References: <20201106071053.122820-1-inga.stotland@intel.com>
         <f836d2e0148e2b156bd5837f651e6d43808541a9.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

The changes to mesh/keyring.c break create network for me.

I think the mkdir tests should be 
if (!!mkdir(key_file, 0755))
not 
if (!mkdir(key_file, 0755))

With that change, I can create networks again.

Steve


On Tue, 2020-11-10 at 18:27 +0000, Gix, Brian wrote:
> Applied
> 
> On Thu, 2020-11-05 at 23:10 -0800, Inga Stotland wrote:
> > This fixes a NULL pointer dereference error (cfgmod-server.c)
> > and miscellaneous issues related to unchecked return status.
> > ---
> >  mesh/agent.c         | 43 ++++++++++++++++++++++++++++------------
> > ---
> >  mesh/appkey.c        |  6 +++---
> >  mesh/cfgmod-server.c | 12 +++---------
> >  mesh/keyring.c       | 38 ++++++++++++++++++++++++--------------
> >  4 files changed, 58 insertions(+), 41 deletions(-)
> > 
> > diff --git a/mesh/agent.c b/mesh/agent.c
> > index b0d523d16..5058d0d8d 100644
> > --- a/mesh/agent.c
> > +++ b/mesh/agent.c
> > @@ -95,7 +95,7 @@ static bool simple_match(const void *a, const
> > void *b)
> >         return a == b;
> >  }
> >  
> > -static void parse_prov_caps(struct mesh_agent_prov_caps *caps,
> > +static bool parse_prov_caps(struct mesh_agent_prov_caps *caps,
> >                                 struct l_dbus_message_iter
> > *property)
> >  {
> >         struct l_dbus_message_iter iter_caps;
> > @@ -103,7 +103,7 @@ static void parse_prov_caps(struct
> > mesh_agent_prov_caps *caps,
> >         uint32_t i;
> >  
> >         if (!l_dbus_message_iter_get_variant(property, "as",
> > &iter_caps))
> > -               return;
> > +               return false;
> >  
> >         while (l_dbus_message_iter_next_entry(&iter_caps, &str)) {
> >                 for (i = 0; i < L_ARRAY_SIZE(cap_table); i++) {
> > @@ -129,9 +129,10 @@ static void parse_prov_caps(struct
> > mesh_agent_prov_caps *caps,
> >                         caps->static_type = 1;
> >         }
> >  
> > +       return true;
> >  }
> >  
> > -static void parse_oob_info(struct mesh_agent_prov_caps *caps,
> > +static bool parse_oob_info(struct mesh_agent_prov_caps *caps,
> >                                 struct l_dbus_message_iter
> > *property)
> >  {
> >         struct l_dbus_message_iter iter_oob;
> > @@ -139,7 +140,7 @@ static void parse_oob_info(struct
> > mesh_agent_prov_caps *caps,
> >         const char *str;
> >  
> >         if (!l_dbus_message_iter_get_variant(property, "as",
> > &iter_oob))
> > -               return;
> > +               return false;
> >  
> >         while (l_dbus_message_iter_next_entry(&iter_oob, &str)) {
> >                 for (i = 0; i < L_ARRAY_SIZE(oob_table); i++) {
> > @@ -148,9 +149,11 @@ static void parse_oob_info(struct
> > mesh_agent_prov_caps *caps,
> >                         caps->oob_info |= oob_table[i].mask;
> >                 }
> >         }
> > +
> > +       return true;
> >  }
> >  
> > -static void parse_properties(struct mesh_agent *agent,
> > +static bool parse_properties(struct mesh_agent *agent,
> >                                         struct l_dbus_message_iter
> > *properties)
> >  {
> >         const char *key, *uri_string;
> > @@ -160,15 +163,20 @@ static void parse_properties(struct
> > mesh_agent *agent,
> >  
> >         while (l_dbus_message_iter_next_entry(properties, &key,
> > &variant)) {
> >                 if (!strcmp(key, "Capabilities")) {
> > -                       parse_prov_caps(&agent->caps, &variant);
> > +                       if (!parse_prov_caps(&agent->caps,
> > &variant))
> > +                               return false;
> >                 } else if (!strcmp(key, "URI")) {
> > -                       l_dbus_message_iter_get_variant(&variant,
> > "s",
> > -
> >                                                                &uri_
> > string);
> > +                       if
> > (!l_dbus_message_iter_get_variant(&variant, "s",
> > +                                                               &ur
> > i_string))
> > +                               return false;
> >                         /* TODO: compute hash */
> >                 } else if (!strcmp(key, "OutOfBandInfo")) {
> > -                       parse_oob_info(&agent->caps, &variant);
> > +                       if (!parse_oob_info(&agent->caps,
> > &variant))
> > +                               return false;
> >                 }
> >         }
> > +
> > +       return true;
> >  }
> >  
> >  static void agent_free(void *agent_data)
> > @@ -253,7 +261,10 @@ struct mesh_agent *mesh_agent_create(const
> > char *path, const char *owner,
> >         agent->owner = l_strdup(owner);
> >         agent->path = l_strdup(path);
> >  
> > -       parse_properties(agent, properties);
> > +       if (!parse_properties(agent, properties)) {
> > +               l_free(agent);
> > +               return NULL;
> > +       }
> >  
> >         l_queue_push_tail(agents, agent);
> >  
> > @@ -312,15 +323,17 @@ static void properties_reply(struct
> > l_dbus_message *reply, void *user_data)
> >         err = get_reply_error(reply);
> >  
> >         if (err != MESH_ERROR_NONE)
> > -               goto fail;
> > +               goto done;
> >  
> >         if (!l_dbus_message_get_arguments(reply, "a{sv}",
> > &properties)) {
> >                 err = MESH_ERROR_FAILED;
> > -               goto fail;
> > +               goto done;
> >         }
> >  
> > -       parse_properties(agent, &properties);
> > -fail:
> > +       if (!parse_properties(agent, &properties))
> > +               err = MESH_ERROR_FAILED;
> > +
> > +done:
> >         if (req->cb) {
> >                 cb = req->cb;
> >                 cb(req->user_data, err);
> > @@ -425,7 +438,7 @@ static void key_reply(struct l_dbus_message
> > *reply, void *user_data)
> >         mesh_agent_key_cb_t cb;
> >         struct l_dbus_message_iter iter_array;
> >         uint32_t n = 0, expected_len = 0;
> > -       uint8_t *buf;
> > +       uint8_t *buf = NULL;
> >         int err;
> >  
> >         if (!l_queue_find(agents, simple_match, agent) || !agent-
> > >req)
> > diff --git a/mesh/appkey.c b/mesh/appkey.c
> > index 7efb8f5c4..549f5a80d 100644
> > --- a/mesh/appkey.c
> > +++ b/mesh/appkey.c
> > @@ -100,11 +100,11 @@ bool appkey_key_init(struct mesh_net *net,
> > uint16_t net_idx, uint16_t app_idx,
> >         if (!app_keys)
> >                 return NULL;
> >  
> > -       key = app_key_new();
> > -       if (!key)
> > +       if (!mesh_net_have_key(net, net_idx))
> >                 return false;
> >  
> > -       if (!mesh_net_have_key(net, net_idx))
> > +       key = app_key_new();
> > +       if (!key)
> >                 return false;
> >  
> >         key->net_idx = net_idx;
> > diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
> > index 0009a1bee..5eefedc4d 100644
> > --- a/mesh/cfgmod-server.c
> > +++ b/mesh/cfgmod-server.c
> > @@ -80,13 +80,12 @@ static uint16_t config_pub_get(struct mesh_node
> > *node, const uint8_t *pkt,
> >  
> >         pub = mesh_model_pub_get(node, ele_addr, id, &status);
> >  
> > -       rtx = pub->rtx.cnt + (((pub->rtx.interval / 50) - 1) << 3);
> > -
> > -       if (pub && status == MESH_STATUS_SUCCESS)
> > +       if (pub && status == MESH_STATUS_SUCCESS) {
> > +               rtx = pub->rtx.cnt + (((pub->rtx.interval / 50) -
> > 1) << 3);
> >                 return set_pub_status(status, ele_addr, id, pub-
> > >addr, pub->idx,
> >                                         pub->credential, pub->ttl,
> > pub->period,
> >                                         rtx);
> > -       else
> > +       } else
> >                 return set_pub_status(status, ele_addr, id, 0, 0,
> > 0, 0, 0, 0);
> >  }
> >  
> > @@ -592,12 +591,7 @@ static uint16_t cfg_appkey_msg(struct
> > mesh_node *node, const uint8_t *pkt,
> >         struct mesh_net *net = node_get_net(node);
> >  
> >         n_idx = l_get_le16(pkt) & 0xfff;
> > -       if (n_idx > NET_IDX_MAX)
> > -               return 0;
> > -
> >         a_idx = l_get_le16(pkt + 1) >> 4;
> > -       if (a_idx > APP_IDX_MAX)
> > -               return 0;
> >  
> >         n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
> >  
> > diff --git a/mesh/keyring.c b/mesh/keyring.c
> > index bbe501063..1ef4fc3ef 100644
> > --- a/mesh/keyring.c
> > +++ b/mesh/keyring.c
> > @@ -50,18 +50,22 @@ bool keyring_put_net_key(struct mesh_node
> > *node, uint16_t net_idx,
> >                 return false;
> >  
> >         snprintf(key_file, PATH_MAX, "%s%s", node_path,
> > net_key_dir);
> > -       mkdir(key_file, 0755);
> > +
> > +       if (!mkdir(key_file, 0755))
> > +               return false;
> > +
> >         snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path,
> > net_key_dir,
> >                                                                 net
> > _idx);
> >         l_debug("Put Net Key %s", key_file);
> >  
> >         fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR |
> > S_IWUSR);
> > -       if (fd >= 0) {
> > -               if (write(fd, key, sizeof(*key)) == sizeof(*key))
> > -                       result = true;
> > +       if (fd < 0)
> > +               return false;
> >  
> > -               close(fd);
> > -       }
> > +       if (write(fd, key, sizeof(*key)) == sizeof(*key))
> > +               result = true;
> > +
> > +       close(fd);
> >  
> >         return result;
> >  }
> > @@ -83,7 +87,10 @@ bool keyring_put_app_key(struct mesh_node *node,
> > uint16_t app_idx,
> >                 return false;
> >  
> >         snprintf(key_file, PATH_MAX, "%s%s", node_path,
> > app_key_dir);
> > -       mkdir(key_file, 0755);
> > +
> > +       if (!mkdir(key_file, 0755))
> > +               return false;
> > +
> >         snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path,
> > app_key_dir,
> >                                                                 app
> > _idx);
> >         l_debug("Put App Key %s", key_file);
> > @@ -100,16 +107,17 @@ bool keyring_put_app_key(struct mesh_node
> > *node, uint16_t app_idx,
> >                 }
> >  
> >                 lseek(fd, 0, SEEK_SET);
> > -       } else
> > +       } else {
> >                 fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC,
> >                                                         S_IRUSR |
> > S_IWUSR);
> > +               if (fd < 0)
> > +                       return false;
> > +       }
> >  
> > -       if (fd >= 0) {
> > -               if (write(fd, key, sizeof(*key)) == sizeof(*key))
> > -                       result = true;
> > +       if (write(fd, key, sizeof(*key)) == sizeof(*key))
> > +               result = true;
> >  
> > -               close(fd);
> > -       }
> > +       close(fd);
> >  
> >         return result;
> >  }
> > @@ -198,7 +206,9 @@ bool keyring_put_remote_dev_key(struct
> > mesh_node *node, uint16_t unicast,
> >                 return false;
> >  
> >         snprintf(key_file, PATH_MAX, "%s%s", node_path,
> > dev_key_dir);
> > -       mkdir(key_file, 0755);
> > +
> > +       if (!mkdir(key_file, 0755))
> > +               return false;
> >  
> >         for (i = 0; i < count; i++) {
> >                 snprintf(key_file, PATH_MAX, "%s%s/%4.4x",
> > node_path,


