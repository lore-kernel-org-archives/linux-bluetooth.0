Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF62C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157F420705
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBkdXDVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAHUAx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:00:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38722 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgAHUAx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 15:00:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id d7so4815370otf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j75jmslP7Xpvprm9OAAUF1tRpehhrDIQzer7JzTjzWo=;
        b=ZBkdXDVynwyLYF9dB20F7HOQ5ypkJnffhkuYyyqnZbogQfR0irUlp0fwPppBmaQ1l9
         d6syB6ZQ/I3w25SRtFiqlib7JgxbrDPz4izwStbJIRfCVrj14B7sHpAH8n/ZmkZ8jg+r
         WQICZIrQcVCIboT8DnQqkk9XW0DBextDAKdvPlGDS/DGP0RfP9BY8Bph+BH4p7/O4bGa
         sSTPDXCOnfjgMR5gHVYyOBlNkejbd8gTlC0qNqyp4IuzCoICWS8GZPlib4vDREgLtEfo
         M/7p35aOuNmK7ovp+Y4sn9zlCC6qwaRPJMD1twWWlQdZLZNFSaIK2w30nWjqBke13S3I
         H7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j75jmslP7Xpvprm9OAAUF1tRpehhrDIQzer7JzTjzWo=;
        b=kjeqx9KLiCY9KX7zH63d6xeBAbiiPGS21E9YbpWh/tp4K6Cr2GPP81XLH8+YMulNRk
         t1u65/It2rCytpPB4o6YgkCzDXN1d4EVNEbhc0hwvRziR69ffKBvi3oSEZ7Y8MNnuIS+
         pAcGQUwfjvDOrVasVcEThovW1zqd5Jq6eJhvC/jn7HHOP7Llv0Cpvdb4DB0F16NazeV5
         mAkCIjWOMYfcXWHsEDFlLFhpoWHtI9LHtL8lrDDNqq3qSWZ2pUNxUQYvm59fTWRvgCQl
         VI76I6Z1V5D+ieB6hauFUG6NGLrPhU/Ezsk8zTRlB1uM37r5vbhcOS79VgvQ4MaazkfM
         NRUw==
X-Gm-Message-State: APjAAAVt1gQHJKtifzDJcW42w1LumQYwvmAIRkXUusPaaXgtlpkAmtxo
        Rpg/lvpDQq1BKq39kCS+vzyFWJEgW54Cxttdxro=
X-Google-Smtp-Source: APXvYqzFRCxOVleCjdsZIwfaKfW/mEpfYaImp5xr3ODX7ExOaikfAj/WqkYQL375J/1bhqFNyh9WQNjvUMV48XtcIYs=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr5618844otf.11.1578513651997;
 Wed, 08 Jan 2020 12:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20200107012820.158721-1-alainm@chromium.org> <20200107012820.158721-3-alainm@chromium.org>
 <CABBYNZK8SaQsX70w2FFd12=XRmV09Lk+KqvU+ryc-STfyOzhLg@mail.gmail.com> <CALWDO_UQJcnA0h_Na6AidW9JvWEMWZppZap2-8BO3QrEB1pPmQ@mail.gmail.com>
In-Reply-To: <CALWDO_UQJcnA0h_Na6AidW9JvWEMWZppZap2-8BO3QrEB1pPmQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 12:00:38 -0800
Message-ID: <CABBYNZKrJ5=pLmvdhOH33BxtXc3=om+vdWOVtz44eZ2AR7sHoQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Loading keys that should be blocked by the kernel.
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Wed, Jan 8, 2020 at 7:04 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
>
> On Tue, Jan 7, 2020 at 6:22 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On Mon, Jan 6, 2020 at 5:31 PM Alain Michaud <alainm@chromium.org> wrote:
> > >
> > > This change accomplishes 2 things:
> > >  1. Drop device security data from previously paired devices
> > >  using blocked keys.
> > >  2. Send the list of known bad keys that should be blocked to the kernel
> > >  if supported.
> > >
> > > In particular keys from the Google Titan Security key are being
> > > blocked.
> > >
> > > For additional background information, please see
> > > https://security.googleblog.com/2019/05/titan-keys-update.html
> > > ---
> > >
> > >  src/adapter.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 134 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index cef25616f..9c41ebe86 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -99,10 +99,27 @@
> > >  #define DISTANCE_VAL_INVALID   0x7FFF
> > >  #define PATHLOSS_MAX           137
> > >
> > > +/*
> > > + * These are known security keys that have been compromised.
> > > + * If this grows or there are needs to be platform specific, it is
> > > + * conceivable that these could be read from a config file.
> > > + */
> > > +static const struct mgmt_blocked_key_info blocked_keys[] = {
> > > +       /* Google Titan Security Keys */
> > > +       { HCI_BLOCKED_KEY_TYPE_LTK,
> > > +               {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
> > > +                0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
> > > +       { HCI_BLOCKED_KEY_TYPE_IRK,
> > > +               {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
> > > +                0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
> > > +};
> > > +
> > >  static DBusConnection *dbus_conn = NULL;
> > >
> > >  static bool kernel_conn_control = false;
> > >
> > > +static bool kernel_blocked_keys_supported = false;
> > > +
> > >  static GList *adapter_list = NULL;
> > >  static unsigned int adapter_remaining = 0;
> > >  static bool powering_down = false;
> > > @@ -124,6 +141,7 @@ struct link_key_info {
> > >         unsigned char key[16];
> > >         uint8_t type;
> > >         uint8_t pin_len;
> > > +       bool is_blocked;
> > >  };
> > >
> > >  struct smp_ltk_info {
> > > @@ -135,12 +153,14 @@ struct smp_ltk_info {
> > >         uint16_t ediv;
> > >         uint64_t rand;
> > >         uint8_t val[16];
> > > +       bool is_blocked;
> > >  };
> > >
> > >  struct irk_info {
> > >         bdaddr_t bdaddr;
> > >         uint8_t bdaddr_type;
> > >         uint8_t val[16];
> > > +       bool is_blocked;
> > >  };
> > >
> > >  struct conn_param {
> > > @@ -3439,6 +3459,20 @@ static int str2buf(const char *str, uint8_t *buf, size_t blen)
> > >         return 0;
> > >  }
> > >
> > > +static bool is_blocked_key(uint8_t key_type, uint8_t *key_value)
> > > +{
> > > +       uint32_t i = 0;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(blocked_keys); ++i) {
> > > +               if (key_type == blocked_keys[i].type &&
> > > +                               !memcmp(blocked_keys[i].val, key_value,
> > > +                                               sizeof(blocked_keys[i].val)))
> > > +                       return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > >  static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
> > >  {
> > >         struct link_key_info *info = NULL;
> > > @@ -3461,6 +3495,9 @@ static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
> > >         info->pin_len = g_key_file_get_integer(key_file, "LinkKey", "PINLength",
> > >                                                 NULL);
> > >
> > > +       info->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LINKKEY,
> > > +                                                               info->key);
> > > +
> > >  failed:
> > >         g_free(str);
> > >
> > > @@ -3534,6 +3571,9 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
> > >         else
> > >                 ltk->master = master;
> > >
> > > +       ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
> > > +                                                               ltk->val);
> > > +
> > >  failed:
> > >         g_free(key);
> > >         g_free(rand);
> > > @@ -3584,6 +3624,9 @@ static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
> > >         else
> > >                 str2buf(&str[0], irk->val, sizeof(irk->val));
> > >
> > > +       irk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LINKKEY,
> > > +                                                               irk->val);
> > > +
> > >  failed:
> > >         g_free(str);
> > >
> > > @@ -4142,21 +4185,55 @@ static void load_devices(struct btd_adapter *adapter)
> > >                 g_key_file_load_from_file(key_file, filename, 0, NULL);
> > >
> > >                 key_info = get_key_info(key_file, entry->d_name);
> > > -               if (key_info)
> > > -                       keys = g_slist_append(keys, key_info);
> > >
> > >                 bdaddr_type = get_le_addr_type(key_file);
> > >
> > >                 ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
> > > -               if (ltk_info)
> > > -                       ltks = g_slist_append(ltks, ltk_info);
> > >
> > >                 slave_ltk_info = get_slave_ltk_info(key_file, entry->d_name,
> > >                                                                 bdaddr_type);
> > > +
> > > +               irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
> > > +
> > > +               // If any key for the device is blocked, we discard all.
> > > +               if ((key_info && key_info->is_blocked) ||
> > > +                               (ltk_info && ltk_info->is_blocked) ||
> > > +                               (slave_ltk_info &&
> > > +                                       slave_ltk_info->is_blocked) ||
> > > +                               (irk_info && irk_info->is_blocked)) {
> >
> > Perhaps it would be more efficient if we don't add is_blocked as a
> > member of these keys and instead pass bool variable to get_*_info
> > which just set it in case the key is blocked, that way if is_blocked
> > is set for get_key_info you don't have to free anything. Also it might
> > be a good idea to move the handling of loading the keys to another
> > function i.e. load_keys to make it simpler to bail out, etc. Have you
> > though about the possibility of just using a the device block API when
> > you detect it is using compromised keys? That way the application can
> > detect the device is in fact blocked and can either remove the device,
> > which would clean up the storage as well (see my comments bellow), or
> > unblock it in order to continue using the device.
>
> My thoughts was to keep the contract simple.  if the return is not
> null then a key exists, it can be blocked or not blocked.  It feels a
> bit weird to have a contract return null but a parameter tells you
> that it's been blocked.  The extra allocation/free doesn't seem like a
> lot of overhead for what is expected to be a rare case (blocked keys).

Fair enough, I suggested that because the is_block logic seems to
apply to all of the keys not just the key that was compromised, anyway
Im probably getting a little too paranoid regarding overhead but I
don't think we had loose anything by avoiding the extra
allocation/free

> >
> > > +                       if (key_info) {
> > > +                               g_free(key_info);
> > > +                               key_info = NULL;
> > > +                       }
> > > +
> > > +                       if (ltk_info) {
> > > +                               g_free(ltk_info);
> > > +                               ltk_info = NULL;
> > > +                       }
> > > +
> > > +                       if (slave_ltk_info) {
> > > +                               g_free(slave_ltk_info);
> > > +                               slave_ltk_info = NULL;
> > > +                       }
> > > +
> > > +                       if (irk_info) {
> > > +                               g_free(irk_info);
> > > +                               irk_info = NULL;
> > > +                       }
> > > +
> > > +                       goto free;
> > > +               }
> > > +
> > > +               if (key_info)
> > > +                       keys = g_slist_append(keys, key_info);
> > > +
> > > +               if (ltk_info)
> > > +                       ltks = g_slist_append(ltks, ltk_info);
> > > +
> >
> > Perhaps I missing something but don't we need to clear these keys form
> > the storage once we figure they are blocked or there is any reason to
> > leave them in there so we can unblock?
> Since these are expected to be rare cases, I didn't go through the
> extent to clear them from storage.  Having them in storage also can
> help with diagnosability.

That is an interesting point, but we don't allow new pairing with
compromised keys with these changes or do we? If we want to allow
diagnosing in all cases we could actually store the blocked flag into
the storage so something like a diagnostic tool can fetch the
information directly.

> >
> > >                 if (slave_ltk_info)
> > >                         ltks = g_slist_append(ltks, slave_ltk_info);
> > >
> > > -               irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
> > >                 if (irk_info)
> > >                         irks = g_slist_append(irks, irk_info);
> > >
> > > @@ -8568,6 +8645,42 @@ static bool set_static_addr(struct btd_adapter *adapter)
> > >         return false;
> > >  }
> > >
> > > +static void set_blocked_keys_complete(uint8_t status, uint16_t length,
> > > +                                       const void *param, void *user_data)
> > > +{
> > > +       struct btd_adapter *adapter = user_data;
> > > +
> > > +       if (status != MGMT_STATUS_SUCCESS) {
> > > +               btd_error(adapter->dev_id,
> > > +                               "Failed to set blocked keys: %s (0x%02x)",
> > > +                               mgmt_errstr(status), status);
> > > +               return;
> > > +       }
> > > +
> > > +       DBG("Successfully set blocked keys for index %u", adapter->dev_id);
> > > +}
> > > +
> > > +static bool set_blocked_keys(struct btd_adapter *adapter)
> > > +{
> > > +       uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
> > > +                                       sizeof(blocked_keys)] = { 0 };
> > > +       struct mgmt_cp_set_blocked_keys *cp =
> > > +                               (struct mgmt_cp_set_blocked_keys *)buffer;
> > > +       int i;
> > > +
> > > +       cp->key_count = ARRAY_SIZE(blocked_keys);
> > > +       for (i = 0; i < cp->key_count; ++i) {
> > > +               cp->keys[i].type = blocked_keys[i].type;
> > > +               memcpy(cp->keys[i].val, blocked_keys[i].val,
> > > +                                               sizeof(cp->keys[i].val));
> > > +       }
> > > +
> > > +       return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, adapter->dev_id,
> > > +                                               sizeof(buffer), buffer,
> > > +                                               set_blocked_keys_complete,
> > > +                                               adapter, NULL);
> > > +}
> > > +
> > >  static void read_info_complete(uint8_t status, uint16_t length,
> > >                                         const void *param, void *user_data)
> > >  {
> > > @@ -8795,6 +8908,13 @@ static void read_info_complete(uint8_t status, uint16_t length,
> > >
> > >         set_name(adapter, btd_adapter_get_name(adapter));
> > >
> > > +       if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
> > > +               btd_error(adapter->dev_id,
> > > +                               "Failed to set blocked keys for index %u",
> > > +                               adapter->dev_id);
> > > +               goto failed;
> > > +       }
> > > +
> > >         if (main_opts.pairable &&
> > >                         !(adapter->current_settings & MGMT_SETTING_BONDABLE))
> > >                 set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
> > > @@ -8972,9 +9092,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
> > >         for (i = 0; i < num_commands; i++) {
> > >                 uint16_t op = get_le16(rp->opcodes + i);
> > >
> > > -               if (op == MGMT_OP_ADD_DEVICE) {
> > > +               switch (op) {
> > > +               case MGMT_OP_ADD_DEVICE:
> > >                         DBG("enabling kernel-side connection control");
> > >                         kernel_conn_control = true;
> > > +                       break;
> > > +               case MGMT_OP_SET_BLOCKED_KEYS:
> > > +                       DBG("kernel supports the set_blocked_keys op");
> > > +                       kernel_blocked_keys_supported = true;
> > > +                       break;
> > > +               default:
> > > +                       break;
> > >                 }
> > >         }
> > >  }
> > > --
> > > 2.24.1.735.g03f4e72817-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
