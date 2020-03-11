Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A2C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643320726
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHhnhu2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgCKOK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:10:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33114 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgCKOK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 10:10:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so2514452ljp.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMEngeuMMzG0CKxpd3JUNvoSwoNM1YdCRwhFn8WCZhM=;
        b=aHhnhu2Sdh2akInp4Rqvf508IY0xhn6C3JP6bvbv3hQLzyhxnfZVa8YN4ngQJ1kEYk
         tvrV/SSKIYOEGe93JmxL1RNp1VZ0qzuVnKg0GsGsToyjuZUZSwMnHb0/MkpiC3rZmp7h
         ivq+tJfUCFbTekFtw5H3OnDgLrB9vTEhDlwG/zO9M6J7tbnMiObHME6x90SKMdo5zVXr
         4ei4zjihUIWqKh+KHhJauXZUZP2H3lyd6XsmB0morJgKSZj5Erbk8KY67g9uJC+BQoZB
         tlqG6Dxv9ezJrkyB/CDPyJwOp6Zzsym06Hj+q1fHORtTfJ5/zo7canQRsOfdIxNdujqJ
         3XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMEngeuMMzG0CKxpd3JUNvoSwoNM1YdCRwhFn8WCZhM=;
        b=EMDzQlOWM5sXCPW3n+ZDjsTymix52YmhKDB+B2tUeNp3CQpABGOV8BAyKcsowatu4P
         MNtwmm9+rKX2PH5i4mbleR49JJSaAYOOjtZqVKbHRMgavHOfDJTw9mr3tYxtyMvxu4zL
         x67avDPacbrBsX/OmhacYGqm82dnDI4cqHrMDoq6ssm9Ze8QbGT77mP74IHU8PbWJdTg
         H9LtF/2tH9SAG41EDPrEtqTYJgxRlyuSibRnPTX0fJs7cnF519fYj1WoNtoSqOiTbfGg
         Xjrbf8yGOV8l0zDZxxmfxGayr4qiPGKgI+dNu3u7jbo2G27iYNBNhi0KzO2D9RUN8Eqe
         wPcw==
X-Gm-Message-State: ANhLgQ03MVR1oYpn27zwDp24YFKI+YIDMH3e7kXS2vdEu40U7eiWKRjl
        v43N25FyqTBfB4w2J+DXxaZ+XuloSPtDhuOaVyf2tA==
X-Google-Smtp-Source: ADFU+vu8nMGfVpQR8NP8G8NoLAc5aY6cv0qCd14Zqec40P+9tlXpKwzcg3b9g3ktsaiae0eeR9G1mHXOmYh02Krvzps=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr2369221ljh.44.1583935826562;
 Wed, 11 Mar 2020 07:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200305161459.153606-1-alainm@chromium.org> <CABBYNZLJYUG75cX3X-JKe+MMb33ub1oy6MQnygpEfDm65+Bvsg@mail.gmail.com>
In-Reply-To: <CABBYNZLJYUG75cX3X-JKe+MMb33ub1oy6MQnygpEfDm65+Bvsg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 11 Mar 2020 10:10:14 -0400
Message-ID: <CALWDO_UQfVUw=sxiisWTotC9f_TZigEb7LzQj2rrV+GzaQSOhg@mail.gmail.com>
Subject: Re: [PATCH v4] bluetooth: Enable erroneous data reporting if wbs is supported
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Mar 10, 2020 at 7:10 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Thu, Mar 5, 2020 at 8:16 AM Alain Michaud <alainm@chromium.org> wrote:
> >
> > This change introduces a wide band speech setting which allows higher
> > level clients to query the local controller support for wide band speech
> > as well as set the setting state when the radio is powered off.
> > Internally, this setting controls if erroneous data reporting is enabled
> > on the controller.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> >  drivers/bluetooth/btusb.c        |  2 +-
> >  include/net/bluetooth/hci.h      | 16 +++++++-
> >  include/net/bluetooth/hci_core.h |  1 +
> >  include/net/bluetooth/mgmt.h     |  4 +-
> >  net/bluetooth/hci_core.c         | 24 ++++++++++++
> >  net/bluetooth/hci_event.c        | 39 +++++++++++++++++++
> >  net/bluetooth/mgmt.c             | 66 +++++++++++++++++++++++++++++++-
> >  7 files changed, 147 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 48e78fdc8e83..4b12c34f0b22 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3868,7 +3868,7 @@ static int btusb_probe(struct usb_interface *intf,
> >                 data->isoc = NULL;
> >
> >         if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
> > -               set_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks);
> > +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> >
> >         if (id->driver_info & BTUSB_DIGIANSWER) {
> >                 data->cmdreq_type = USB_TYPE_VENDOR;
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 0b3ebd35681d..4e86f1bb7a87 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -213,7 +213,7 @@ enum {
> >          *
> >          * This quirk must be set before hci_register_dev is called.
> >          */
> > -       HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
> > +       HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> >  };
> >
> >  /* HCI device flags */
> > @@ -286,6 +286,7 @@ enum {
> >         HCI_FAST_CONNECTABLE,
> >         HCI_BREDR_ENABLED,
> >         HCI_LE_SCAN_INTERRUPTED,
> > +       HCI_WIDEBAND_SPEECH_ENABLED,
> >
> >         HCI_DUT_MODE,
> >         HCI_VENDOR_DIAG,
> > @@ -1095,6 +1096,19 @@ struct hci_rp_read_inq_rsp_tx_power {
> >         __s8     tx_power;
> >  } __packed;
> >
> > +#define HCI_OP_READ_DEF_ERR_DATA_REPORTING     0x0c5a
> > +       #define ERR_DATA_REPORTING_DISABLED     0x00
> > +       #define ERR_DATA_REPORTING_ENABLED      0x01
> > +struct hci_rp_read_def_err_data_reporting {
> > +       __u8     status;
> > +       __u8     err_data_reporting;
> > +} __packed;
> > +
> > +#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING    0x0c5b
> > +struct hci_cp_write_def_err_data_reporting {
> > +       __u8     err_data_reporting;
> > +} __packed;
> > +
> >  #define HCI_OP_SET_EVENT_MASK_PAGE_2   0x0c63
> >
> >  #define HCI_OP_READ_LOCATION_DATA      0x0c64
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index dcc0dc6e2624..c498ac113930 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -260,6 +260,7 @@ struct hci_dev {
> >         __u8            stored_num_keys;
> >         __u8            io_capability;
> >         __s8            inq_tx_power;
> > +       __u8            err_data_reporting;
> >         __u16           page_scan_interval;
> >         __u16           page_scan_window;
> >         __u8            page_scan_type;
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> > index f69f88e8e109..f41cd87550dc 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -102,7 +102,7 @@ struct mgmt_rp_read_index_list {
> >  #define MGMT_SETTING_CONFIGURATION     0x00004000
> >  #define MGMT_SETTING_STATIC_ADDRESS    0x00008000
> >  #define MGMT_SETTING_PHY_CONFIGURATION 0x00010000
> > -#define MGMT_SETTING_WIDE_BAND_SPEECH  0x00020000
> > +#define MGMT_SETTING_WIDEBAND_SPEECH   0x00020000
> >
> >  #define MGMT_OP_READ_INFO              0x0004
> >  #define MGMT_READ_INFO_SIZE            0
> > @@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
> >  } __packed;
> >  #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
> >
> > +#define MGMT_OP_SET_WIDEBAND_SPEECH    0x0047
> > +
> >  #define MGMT_EV_CMD_COMPLETE           0x0001
> >  struct mgmt_ev_cmd_complete {
> >         __le16  opcode;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 4e6d61a95b20..ef1160c1f9d0 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> >         if (hdev->commands[8] & 0x01)
> >                 hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
> >
> > +       if (hdev->commands[18] & 0x02)
> > +               hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
>
> Is bit above correct? It looks like this is causing a problem on the emulator:
>
> Basic L2CAP Socket - Success - init
>   Read Index List callback
>     Status: 0x00
>   New hciemu instance created
> Unsupported command 0x0c5a
>
> On the emulator we have:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/btdev.c#n409
>
> btdev->commands[18] |= 0x02; /* Write Inquiry Response TX Power */
>
> I assume the above is correct, I guess it would be the bit at 0x04 like bellow.
>
> > +
> >         /* Some older Broadcom based Bluetooth 1.2 controllers do not
> >          * support the Read Page Scan Type command. Check support for
> >          * this command in the bit mask of supported commands.
> > @@ -838,6 +841,27 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
> >                             sizeof(support), &support);
> >         }
> >
> > +       /* Set erroneous data reporting if supported to the wideband speech
> > +        * setting value
> > +        */
> > +       if (hdev->commands[18] & 0x04) {
> > +               bool enabled = hci_dev_test_flag(hdev,
> > +                                                HCI_WIDEBAND_SPEECH_ENABLED);
> > +
> > +               if (enabled !=
> > +                   (hdev->err_data_reporting == ERR_DATA_REPORTING_ENABLED)) {
> > +                       struct hci_cp_write_def_err_data_reporting cp = {};
> > +
> > +                       cp.err_data_reporting =
> > +                               enabled ?
> > +                               ERR_DATA_REPORTING_ENABLED :
> > +                               ERR_DATA_REPORTING_DISABLED;
> > +
> > +                       hci_req_add(req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
> > +                                   sizeof(cp), &cp);
>
> This would be adding it again? Or the first instance was not suppose
> to be there?
Indeed, I was off by one for the read/write commands, should have been
0x04 and 0x08. on a device that really don't support these commands
(like the emulator?) that could indeed be problematic.  I'll send a
patch to fix these.
>
> > +               }
> > +       }
> > +
> >         /* Set Suggested Default Data Length to maximum if supported */
> >         if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
> >                 struct hci_cp_le_write_def_data_len cp;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 591e7477e925..3772acddda93 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -901,6 +901,37 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
> >         hdev->inq_tx_power = rp->tx_power;
> >  }
> >
> > +static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
> > +                                              struct sk_buff *skb)
> > +{
> > +       struct hci_rp_read_def_err_data_reporting *rp = (void *)skb->data;
> > +
> > +       BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> > +
> > +       if (rp->status)
> > +               return;
> > +
> > +       hdev->err_data_reporting = rp->err_data_reporting;
> > +}
> > +
> > +static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
> > +                                               struct sk_buff *skb)
> > +{
> > +       __u8 status = *((__u8 *)skb->data);
> > +       struct hci_cp_write_def_err_data_reporting *cp;
> > +
> > +       BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > +
> > +       if (status)
> > +               return;
> > +
> > +       cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING);
> > +       if (!cp)
> > +               return;
> > +
> > +       hdev->err_data_reporting = cp->err_data_reporting;
> > +}
> > +
> >  static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> >         struct hci_rp_pin_code_reply *rp = (void *) skb->data;
> > @@ -3302,6 +3333,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> >                 hci_cc_read_inq_rsp_tx_power(hdev, skb);
> >                 break;
> >
> > +       case HCI_OP_READ_DEF_ERR_DATA_REPORTING:
> > +               hci_cc_read_def_err_data_reporting(hdev, skb);
> > +               break;
> > +
> > +       case HCI_OP_WRITE_DEF_ERR_DATA_REPORTING:
> > +               hci_cc_write_def_err_data_reporting(hdev, skb);
> > +               break;
> > +
> >         case HCI_OP_PIN_CODE_REPLY:
> >                 hci_cc_pin_code_reply(hdev, skb);
> >                 break;
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 1002c657768a..8fbbb225caf8 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
> >         MGMT_OP_READ_EXT_INFO,
> >         MGMT_OP_SET_APPEARANCE,
> >         MGMT_OP_SET_BLOCKED_KEYS,
> > +       MGMT_OP_SET_WIDEBAND_SPEECH,
> >  };
> >
> >  static const u16 mgmt_events[] = {
> > @@ -763,9 +764,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
> >                 if (lmp_sc_capable(hdev))
> >                         settings |= MGMT_SETTING_SECURE_CONN;
> >
> > -               if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
> > +               if (test_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> >                              &hdev->quirks))
> > -                       settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
> > +                       settings |= MGMT_SETTING_WIDEBAND_SPEECH;
> >         }
> >
> >         if (lmp_le_capable(hdev)) {
> > @@ -850,6 +851,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
> >                         settings |= MGMT_SETTING_STATIC_ADDRESS;
> >         }
> >
> > +       if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
> > +               settings |= MGMT_SETTING_WIDEBAND_SPEECH;
> > +
> >         return settings;
> >  }
> >
> > @@ -3593,6 +3597,63 @@ static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
> >                                 err, NULL, 0);
> >  }
> >
> > +static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
> > +                              void *data, u16 len)
> > +{
> > +       struct mgmt_mode *cp = data;
> > +       int err;
> > +       bool changed = false;
> > +
> > +       BT_DBG("request for %s", hdev->name);
> > +
> > +       if (!test_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks))
> > +               return mgmt_cmd_status(sk, hdev->id,
> > +                                      MGMT_OP_SET_WIDEBAND_SPEECH,
> > +                                      MGMT_STATUS_NOT_SUPPORTED);
> > +
> > +       if (cp->val != 0x00 && cp->val != 0x01)
> > +               return mgmt_cmd_status(sk, hdev->id,
> > +                                      MGMT_OP_SET_WIDEBAND_SPEECH,
> > +                                      MGMT_STATUS_INVALID_PARAMS);
> > +
> > +       hci_dev_lock(hdev);
> > +
> > +       if (pending_find(MGMT_OP_SET_WIDEBAND_SPEECH, hdev)) {
> > +               err = mgmt_cmd_status(sk, hdev->id,
> > +                                     MGMT_OP_SET_WIDEBAND_SPEECH,
> > +                                     MGMT_STATUS_BUSY);
> > +               goto unlock;
> > +       }
> > +
> > +       if (hdev_is_powered(hdev) &&
> > +           !!cp->val != hci_dev_test_flag(hdev,
> > +                                          HCI_WIDEBAND_SPEECH_ENABLED)) {
> > +               err = mgmt_cmd_status(sk, hdev->id,
> > +                                     MGMT_OP_SET_WIDEBAND_SPEECH,
> > +                                     MGMT_STATUS_REJECTED);
> > +               goto unlock;
> > +       }
> > +
> > +       if (cp->val)
> > +               changed = !hci_dev_test_and_set_flag(hdev,
> > +                                                  HCI_WIDEBAND_SPEECH_ENABLED);
> > +       else
> > +               changed = hci_dev_test_and_clear_flag(hdev,
> > +                                                  HCI_WIDEBAND_SPEECH_ENABLED);
> > +
> > +       err = send_settings_rsp(sk, MGMT_OP_SET_WIDEBAND_SPEECH, hdev);
> > +       if (err < 0)
> > +               goto unlock;
> > +
> > +       if (changed)
> > +               err = new_settings(hdev, sk);
> > +
> > +unlock:
> > +
> > +       hci_dev_unlock(hdev);
> > +       return err;
> > +}
> > +
> >  static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
> >                                          u16 opcode, struct sk_buff *skb)
> >  {
> > @@ -6994,6 +7055,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> >         { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> >         { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE,
> >                                                 HCI_MGMT_VAR_LEN },
> > +       { set_wideband_speech,     MGMT_SETTING_SIZE },
> >  };
> >
> >  void mgmt_index_added(struct hci_dev *hdev)
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >
>
>
> --
> Luiz Augusto von Dentz
