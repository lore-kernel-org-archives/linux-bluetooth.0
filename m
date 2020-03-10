Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66FCC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DC222525
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 23:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdLYM/lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCJXKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:10:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40582 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJXKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 19:10:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id y71so10372246oia.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+RGR+9DDwgarcByz8bVdSiGzSXurJPu70Rbss3JPVk=;
        b=TdLYM/lkYjdT4zmBX83qPTtB+9bTnn0Bl6ldLerr2/jE/HN1VbTLfPr3bVmluKHZzn
         ACF77hBZh7YDJjPCGjMSQTEH4G6t2sQ5FI9g0qRMHrSSqHbdFY4XMhVbA2SjfgMFGRDz
         gV2sYVHo9pT6cN3vfYOsueKRbywnKqw6UApkkA4wJRSB7+GnwSsT2CKvbdhahXnyL7iq
         w8zNtThO0miupkmGUjE8xCcpPPyY2SP2/q4X05rVlCipGSPZc/NQ5l2srXER9RRgukWX
         lc90aCvhBpepuNWNYBggwAA1XUOJAyinXYGV+zeid7Qm8SMqoBnFVGFTf6WrY6cLWc2y
         mTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+RGR+9DDwgarcByz8bVdSiGzSXurJPu70Rbss3JPVk=;
        b=fBgW8cRla4M+CSLAJ91R4KroVae2JuSo9tlUzkwpNiJsUCJGq1sMfikSMzuwCAbscE
         3o7YjA7UrwaiK2eUV3y++Ta8+9IEvEea5ngG/I1FigxC87RdSQ9NPlT7Ia2j8C7Konh7
         VGFXSCWdxcY3DECkjUZIDT8n9E5xc42texL1xsQF5hPsVm0gOoUmr8NO7lfDsjuE5VY1
         Z9XK3tdMyg1NwnkKKtIPgnxDd/8So9OdKDCpvaVQ3szYabbbbkZpT5VAIJJrz70oC5H6
         if1b1x+cM4G1sH8KHuuKAbjdhFgkR7w9QLB20S9phHPX+5T1kB7FE+dI12UEBsUy7I0Q
         9bNw==
X-Gm-Message-State: ANhLgQ20KtnLerNkjEkorEvXUiazF6mY/Ab3IXgCgOtZoEVOU2U4nJuU
        fNkZpYxkgW/u3ZpURV6KDZ28q8SBBsaYCEOl4mA=
X-Google-Smtp-Source: ADFU+vv7mWBB+xoiJeclBm6jb7CoHNRUd52zdp44nX8Ur3KHQzGgEI/RQEM3u5RKTgIxJ3Rpi2uE6AW2Nbftrm1VZEM=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr45376oif.82.1583881817728;
 Tue, 10 Mar 2020 16:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200305161459.153606-1-alainm@chromium.org>
In-Reply-To: <20200305161459.153606-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Mar 2020 16:10:06 -0700
Message-ID: <CABBYNZLJYUG75cX3X-JKe+MMb33ub1oy6MQnygpEfDm65+Bvsg@mail.gmail.com>
Subject: Re: [PATCH v4] bluetooth: Enable erroneous data reporting if wbs is supported
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, Mar 5, 2020 at 8:16 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change introduces a wide band speech setting which allows higher
> level clients to query the local controller support for wide band speech
> as well as set the setting state when the radio is powered off.
> Internally, this setting controls if erroneous data reporting is enabled
> on the controller.
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
>
>  drivers/bluetooth/btusb.c        |  2 +-
>  include/net/bluetooth/hci.h      | 16 +++++++-
>  include/net/bluetooth/hci_core.h |  1 +
>  include/net/bluetooth/mgmt.h     |  4 +-
>  net/bluetooth/hci_core.c         | 24 ++++++++++++
>  net/bluetooth/hci_event.c        | 39 +++++++++++++++++++
>  net/bluetooth/mgmt.c             | 66 +++++++++++++++++++++++++++++++-
>  7 files changed, 147 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 48e78fdc8e83..4b12c34f0b22 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3868,7 +3868,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 data->isoc = NULL;
>
>         if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
> -               set_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks);
> +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>
>         if (id->driver_info & BTUSB_DIGIANSWER) {
>                 data->cmdreq_type = USB_TYPE_VENDOR;
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0b3ebd35681d..4e86f1bb7a87 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -213,7 +213,7 @@ enum {
>          *
>          * This quirk must be set before hci_register_dev is called.
>          */
> -       HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
> +       HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>  };
>
>  /* HCI device flags */
> @@ -286,6 +286,7 @@ enum {
>         HCI_FAST_CONNECTABLE,
>         HCI_BREDR_ENABLED,
>         HCI_LE_SCAN_INTERRUPTED,
> +       HCI_WIDEBAND_SPEECH_ENABLED,
>
>         HCI_DUT_MODE,
>         HCI_VENDOR_DIAG,
> @@ -1095,6 +1096,19 @@ struct hci_rp_read_inq_rsp_tx_power {
>         __s8     tx_power;
>  } __packed;
>
> +#define HCI_OP_READ_DEF_ERR_DATA_REPORTING     0x0c5a
> +       #define ERR_DATA_REPORTING_DISABLED     0x00
> +       #define ERR_DATA_REPORTING_ENABLED      0x01
> +struct hci_rp_read_def_err_data_reporting {
> +       __u8     status;
> +       __u8     err_data_reporting;
> +} __packed;
> +
> +#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING    0x0c5b
> +struct hci_cp_write_def_err_data_reporting {
> +       __u8     err_data_reporting;
> +} __packed;
> +
>  #define HCI_OP_SET_EVENT_MASK_PAGE_2   0x0c63
>
>  #define HCI_OP_READ_LOCATION_DATA      0x0c64
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index dcc0dc6e2624..c498ac113930 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -260,6 +260,7 @@ struct hci_dev {
>         __u8            stored_num_keys;
>         __u8            io_capability;
>         __s8            inq_tx_power;
> +       __u8            err_data_reporting;
>         __u16           page_scan_interval;
>         __u16           page_scan_window;
>         __u8            page_scan_type;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index f69f88e8e109..f41cd87550dc 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -102,7 +102,7 @@ struct mgmt_rp_read_index_list {
>  #define MGMT_SETTING_CONFIGURATION     0x00004000
>  #define MGMT_SETTING_STATIC_ADDRESS    0x00008000
>  #define MGMT_SETTING_PHY_CONFIGURATION 0x00010000
> -#define MGMT_SETTING_WIDE_BAND_SPEECH  0x00020000
> +#define MGMT_SETTING_WIDEBAND_SPEECH   0x00020000
>
>  #define MGMT_OP_READ_INFO              0x0004
>  #define MGMT_READ_INFO_SIZE            0
> @@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
>  } __packed;
>  #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
>
> +#define MGMT_OP_SET_WIDEBAND_SPEECH    0x0047
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         __le16  opcode;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4e6d61a95b20..ef1160c1f9d0 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>         if (hdev->commands[8] & 0x01)
>                 hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
>
> +       if (hdev->commands[18] & 0x02)
> +               hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);

Is bit above correct? It looks like this is causing a problem on the emulator:

Basic L2CAP Socket - Success - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
Unsupported command 0x0c5a

On the emulator we have:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/btdev.c#n409

btdev->commands[18] |= 0x02; /* Write Inquiry Response TX Power */

I assume the above is correct, I guess it would be the bit at 0x04 like bellow.

> +
>         /* Some older Broadcom based Bluetooth 1.2 controllers do not
>          * support the Read Page Scan Type command. Check support for
>          * this command in the bit mask of supported commands.
> @@ -838,6 +841,27 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
>                             sizeof(support), &support);
>         }
>
> +       /* Set erroneous data reporting if supported to the wideband speech
> +        * setting value
> +        */
> +       if (hdev->commands[18] & 0x04) {
> +               bool enabled = hci_dev_test_flag(hdev,
> +                                                HCI_WIDEBAND_SPEECH_ENABLED);
> +
> +               if (enabled !=
> +                   (hdev->err_data_reporting == ERR_DATA_REPORTING_ENABLED)) {
> +                       struct hci_cp_write_def_err_data_reporting cp = {};
> +
> +                       cp.err_data_reporting =
> +                               enabled ?
> +                               ERR_DATA_REPORTING_ENABLED :
> +                               ERR_DATA_REPORTING_DISABLED;
> +
> +                       hci_req_add(req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
> +                                   sizeof(cp), &cp);

This would be adding it again? Or the first instance was not suppose
to be there?

> +               }
> +       }
> +
>         /* Set Suggested Default Data Length to maximum if supported */
>         if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
>                 struct hci_cp_le_write_def_data_len cp;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 591e7477e925..3772acddda93 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -901,6 +901,37 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
>         hdev->inq_tx_power = rp->tx_power;
>  }
>
> +static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
> +                                              struct sk_buff *skb)
> +{
> +       struct hci_rp_read_def_err_data_reporting *rp = (void *)skb->data;
> +
> +       BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +       if (rp->status)
> +               return;
> +
> +       hdev->err_data_reporting = rp->err_data_reporting;
> +}
> +
> +static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
> +                                               struct sk_buff *skb)
> +{
> +       __u8 status = *((__u8 *)skb->data);
> +       struct hci_cp_write_def_err_data_reporting *cp;
> +
> +       BT_DBG("%s status 0x%2.2x", hdev->name, status);
> +
> +       if (status)
> +               return;
> +
> +       cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING);
> +       if (!cp)
> +               return;
> +
> +       hdev->err_data_reporting = cp->err_data_reporting;
> +}
> +
>  static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_rp_pin_code_reply *rp = (void *) skb->data;
> @@ -3302,6 +3333,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>                 hci_cc_read_inq_rsp_tx_power(hdev, skb);
>                 break;
>
> +       case HCI_OP_READ_DEF_ERR_DATA_REPORTING:
> +               hci_cc_read_def_err_data_reporting(hdev, skb);
> +               break;
> +
> +       case HCI_OP_WRITE_DEF_ERR_DATA_REPORTING:
> +               hci_cc_write_def_err_data_reporting(hdev, skb);
> +               break;
> +
>         case HCI_OP_PIN_CODE_REPLY:
>                 hci_cc_pin_code_reply(hdev, skb);
>                 break;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1002c657768a..8fbbb225caf8 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
>         MGMT_OP_READ_EXT_INFO,
>         MGMT_OP_SET_APPEARANCE,
>         MGMT_OP_SET_BLOCKED_KEYS,
> +       MGMT_OP_SET_WIDEBAND_SPEECH,
>  };
>
>  static const u16 mgmt_events[] = {
> @@ -763,9 +764,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>                 if (lmp_sc_capable(hdev))
>                         settings |= MGMT_SETTING_SECURE_CONN;
>
> -               if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
> +               if (test_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>                              &hdev->quirks))
> -                       settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
> +                       settings |= MGMT_SETTING_WIDEBAND_SPEECH;
>         }
>
>         if (lmp_le_capable(hdev)) {
> @@ -850,6 +851,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
>                         settings |= MGMT_SETTING_STATIC_ADDRESS;
>         }
>
> +       if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
> +               settings |= MGMT_SETTING_WIDEBAND_SPEECH;
> +
>         return settings;
>  }
>
> @@ -3593,6 +3597,63 @@ static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
>                                 err, NULL, 0);
>  }
>
> +static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
> +                              void *data, u16 len)
> +{
> +       struct mgmt_mode *cp = data;
> +       int err;
> +       bool changed = false;
> +
> +       BT_DBG("request for %s", hdev->name);
> +
> +       if (!test_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks))
> +               return mgmt_cmd_status(sk, hdev->id,
> +                                      MGMT_OP_SET_WIDEBAND_SPEECH,
> +                                      MGMT_STATUS_NOT_SUPPORTED);
> +
> +       if (cp->val != 0x00 && cp->val != 0x01)
> +               return mgmt_cmd_status(sk, hdev->id,
> +                                      MGMT_OP_SET_WIDEBAND_SPEECH,
> +                                      MGMT_STATUS_INVALID_PARAMS);
> +
> +       hci_dev_lock(hdev);
> +
> +       if (pending_find(MGMT_OP_SET_WIDEBAND_SPEECH, hdev)) {
> +               err = mgmt_cmd_status(sk, hdev->id,
> +                                     MGMT_OP_SET_WIDEBAND_SPEECH,
> +                                     MGMT_STATUS_BUSY);
> +               goto unlock;
> +       }
> +
> +       if (hdev_is_powered(hdev) &&
> +           !!cp->val != hci_dev_test_flag(hdev,
> +                                          HCI_WIDEBAND_SPEECH_ENABLED)) {
> +               err = mgmt_cmd_status(sk, hdev->id,
> +                                     MGMT_OP_SET_WIDEBAND_SPEECH,
> +                                     MGMT_STATUS_REJECTED);
> +               goto unlock;
> +       }
> +
> +       if (cp->val)
> +               changed = !hci_dev_test_and_set_flag(hdev,
> +                                                  HCI_WIDEBAND_SPEECH_ENABLED);
> +       else
> +               changed = hci_dev_test_and_clear_flag(hdev,
> +                                                  HCI_WIDEBAND_SPEECH_ENABLED);
> +
> +       err = send_settings_rsp(sk, MGMT_OP_SET_WIDEBAND_SPEECH, hdev);
> +       if (err < 0)
> +               goto unlock;
> +
> +       if (changed)
> +               err = new_settings(hdev, sk);
> +
> +unlock:
> +
> +       hci_dev_unlock(hdev);
> +       return err;
> +}
> +
>  static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
>                                          u16 opcode, struct sk_buff *skb)
>  {
> @@ -6994,6 +7055,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
>         { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
>         { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE,
>                                                 HCI_MGMT_VAR_LEN },
> +       { set_wideband_speech,     MGMT_SETTING_SIZE },
>  };
>
>  void mgmt_index_added(struct hci_dev *hdev)
> --
> 2.25.1.481.gfbce0eb801-goog
>


-- 
Luiz Augusto von Dentz
