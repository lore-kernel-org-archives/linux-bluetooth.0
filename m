Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E29C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 15:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD22146E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 15:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fx1LLkwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCEPJX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:09:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42183 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCEPJX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 10:09:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id t21so4909479lfe.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 07:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1k3JTp8kGJG1lEuyYJUl46TpZTkWI6MP+zzJ7NWNzcc=;
        b=fx1LLkwMFQTx61qrO+ygDx9B6ozpHYLzicvccrrkRcLOYSp5tV7tTpgz+USesxAua9
         8kGJKQCH7irw7mz21l1huBu9wzVPBY9GzQlS6BZRqnV/0FKfV87YNTkwgtM5awqGdFN1
         A+/vZAHttrnToxYd8UMDAHhDjpKB+3RWnAjW/h5WUVrvS6T/bHDinUb+vSES2WznhIP1
         Kt0KAR9JeSdXPWgpUcAJx9J/wGEueCsq4bBOrmml8mgtRMYdYO8ycFBS1aWGPliqleaG
         +6vMCANjrtoazqfgFYXQnf5GFavUl65gl9zNwI+XHm1TOx85AZxzot4mOfStibB3PJv3
         gg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1k3JTp8kGJG1lEuyYJUl46TpZTkWI6MP+zzJ7NWNzcc=;
        b=Sh9ToKIK0BdS5/fSWqCcN1rk8dk7pTbhDPDaop9CHt5bZFlsU+eQQTc8uAfTn2m8kk
         rwbzNJaDBAK3ofitXrMjKBlYsf8raN8ZiayFx3CkYpDP1V/+DQF6zi9RJ8yjYb/uJl9u
         J4Bv0Z9UJopN7Bkl+1hRoymYMGoFhZP38/Qnlbh7Ov56DBeJe5EW9rfSJ/9WAGh52KEG
         YvyFKhYfZStxcfR3/IgH/Bj/uDa4Q9FULhHN/W7OS2X6fR/HMKbOioiirAqH5oimutu9
         /tb8PZcu4JnCGrmAEAMvRGzzueWmvSI0dCbLdXnZxv9y6FeDEwjOApOF0FFD/zeNRRiy
         2d8w==
X-Gm-Message-State: ANhLgQ3f7vWDSWLAz0mAoZhU9LzqyJwqLztf2C9BLw9GeuLoUaptt6/2
        9bo0+36vlBDASlbeHWX7TPipOuSHRGza3B4E8hP8pw==
X-Google-Smtp-Source: ADFU+vuDKknA3BktDoO1Lo1omG8Ka5w09MHOHWyKFT3x+SjgxBETk2XujduwJjQUcMCJ2jTBlVGL65G8RxAGjdnEcO0=
X-Received: by 2002:a19:5e5b:: with SMTP id z27mr5863141lfi.129.1583420958594;
 Thu, 05 Mar 2020 07:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20200304172207.58963-1-alainm@chromium.org> <952F72CF-2414-4940-B5CE-D33981E56B90@holtmann.org>
In-Reply-To: <952F72CF-2414-4940-B5CE-D33981E56B90@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 5 Mar 2020 10:09:06 -0500
Message-ID: <CALWDO_Wp2CGYzqSwi9B8ZTPus_a5s7c0eF-DY6z=uyQJWsqfdQ@mail.gmail.com>
Subject: Re: [PATCH v3] bluetooth: Enable erroneous data reporting if wbs is supported
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI Marcel,

On Thu, Mar 5, 2020 at 6:04 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change intruduces a wide band speech setting which allows higher
> > level clients to query the local controller support for wide band speec=
h
> > as well as set the setting state when the radio is powered off.
> > Internally, this setting controls if erroneous data reporting is enable=
d
> > on the controller.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > include/net/bluetooth/hci.h      | 14 ++++++++
> > include/net/bluetooth/hci_core.h |  1 +
> > include/net/bluetooth/mgmt.h     |  2 ++
> > net/bluetooth/hci_core.c         | 21 +++++++++++
> > net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++
> > net/bluetooth/mgmt.c             | 62 ++++++++++++++++++++++++++++++++
> > 6 files changed, 139 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 0b3ebd35681d..d66648e9ff13 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -286,6 +286,7 @@ enum {
> >       HCI_FAST_CONNECTABLE,
> >       HCI_BREDR_ENABLED,
> >       HCI_LE_SCAN_INTERRUPTED,
> > +     HCI_WIDE_BAND_SPEECH_ENABLED,
>
> lets use HCI_WIDEBAND_SPEECH_ENABLED. It might be just me, but when I loo=
k at WIDE_BAND compared to WIDEBAND, I prefer the latter.
Ack.
>
> >
> >       HCI_DUT_MODE,
> >       HCI_VENDOR_DIAG,
> > @@ -1095,6 +1096,19 @@ struct hci_rp_read_inq_rsp_tx_power {
> >       __s8     tx_power;
> > } __packed;
> >
> > +#define HCI_OP_READ_DEF_ERR_DATA_REPORTING   0x0c5a
> > +     #define ERR_DATA_REPORTING_DISABLED     0x00
> > +     #define ERR_DATA_REPORTING_ENABLED      0x01
> > +struct hci_rp_read_def_err_data_reporting {
> > +     __u8     status;
> > +     __u8     err_data_reporting;
> > +} __packed;
> > +
> > +#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING  0x0c5b
> > +struct hci_cp_write_def_err_data_reporting {
> > +     __u8     err_data_reporting;
> > +} __packed;
> > +
> > #define HCI_OP_SET_EVENT_MASK_PAGE_2  0x0c63
> >
> > #define HCI_OP_READ_LOCATION_DATA     0x0c64
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index dcc0dc6e2624..c498ac113930 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -260,6 +260,7 @@ struct hci_dev {
> >       __u8            stored_num_keys;
> >       __u8            io_capability;
> >       __s8            inq_tx_power;
> > +     __u8            err_data_reporting;
> >       __u16           page_scan_interval;
> >       __u16           page_scan_window;
> >       __u8            page_scan_type;
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.=
h
> > index f69f88e8e109..b203df07e7fc 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
> > } __packed;
> > #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
> >
> > +#define MGMT_OP_SET_WIDE_BAND_SPEECH 0x0047
> > +
> > #define MGMT_EV_CMD_COMPLETE          0x0001
> > struct mgmt_ev_cmd_complete {
> >       __le16  opcode;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 4e6d61a95b20..d526d7568396 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, u=
nsigned long opt)
> >       if (hdev->commands[8] & 0x01)
> >               hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL)=
;
> >
> > +     if (hdev->commands[18] & 0x02)
> > +             hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, N=
ULL);
> > +
> >       /* Some older Broadcom based Bluetooth 1.2 controllers do not
> >        * support the Read Page Scan Type command. Check support for
> >        * this command in the bit mask of supported commands.
> > @@ -838,6 +841,24 @@ static int hci_init4_req(struct hci_request *req, =
unsigned long opt)
> >                           sizeof(support), &support);
> >       }
> >
> > +     /* Set erroneous data reporting if supported to the wideband spee=
ch
> > +      * setting value
> > +      */
> > +     if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks)=
 &&
> > +         (hdev->commands[18] & 0x04) &&
> > +         hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED) !=3D
> > +          (hdev->err_data_reporting !=3D ERR_DATA_REPORTING_ENABLED)) =
{
>
> So this statement is creating a knot in my brain ;)
>
>
>         if (hdev->commands[18] & 0x04) {
>                 bool enabled =3D hci_dev_test_flag(hdev, HCI_WIDEBAND_SPE=
ECH_ENABLED);
>
>                 ..
>
>                 cp.err_data_reporting =3D enabled ? ERR_DATA_REPORTING_EN=
ABLED :
>                                                   ERR_DATA_REPORTING_DISA=
BLED;
>
>                 ..
>         }
>
> I would not bother checking the quirk here. I would just configure that s=
etting based on the HCI_WIDEBAND_SPEECH_ENABLED flag. Unless we have contro=
llers that report this command and don=E2=80=99t allow setting the value, t=
hen we have to deal with it, but right now I assume that they get the basic=
s of HCI right.
>
> Btw. I am debating a coding style here.
>
>                 cp.err_data_reporting =3D enabled ? ERR_DATA_REPORTING_EN=
ABLED
>                                                 : ERR_DATA_REPORTING_DISA=
BLED;
>
> But I am not even sure that is clearer or cleaner.

I agree the QUIRK check could be avoided, but I'd argue the following
condition is still required to avoid sending a command that otherwise
is not necessary to the controller:
hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED) !=3D
(hdev->err_data_reporting !=3D ERR_DATA_REPORTING_ENABLED).  I can
however simplify it by using a bool enabled flag as you suggested.

>
> > +             struct hci_cp_write_def_err_data_reporting cp =3D {};
> > +
> > +             cp.err_data_reporting =3D
> > +                     hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENAB=
LED) ?
> > +                     ERR_DATA_REPORTING_ENABLED :
> > +                     ERR_DATA_REPORTING_DISABLED;
> > +
> > +             hci_req_add(req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
> > +                         sizeof(cp), &cp);
> > +     }
> > +
> >       /* Set Suggested Default Data Length to maximum if supported */
> >       if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
> >               struct hci_cp_le_write_def_data_len cp;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 591e7477e925..3772acddda93 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -901,6 +901,37 @@ static void hci_cc_read_inq_rsp_tx_power(struct hc=
i_dev *hdev,
> >       hdev->inq_tx_power =3D rp->tx_power;
> > }
> >
> > +static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
> > +                                            struct sk_buff *skb)
> > +{
> > +     struct hci_rp_read_def_err_data_reporting *rp =3D (void *)skb->da=
ta;
> > +
> > +     BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> > +
> > +     if (rp->status)
> > +             return;
> > +
> > +     hdev->err_data_reporting =3D rp->err_data_reporting;
> > +}
> > +
> > +static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
> > +                                             struct sk_buff *skb)
> > +{
> > +     __u8 status =3D *((__u8 *)skb->data);
> > +     struct hci_cp_write_def_err_data_reporting *cp;
> > +
> > +     BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > +
> > +     if (status)
> > +             return;
> > +
> > +     cp =3D hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTIN=
G);
> > +     if (!cp)
> > +             return;
> > +
> > +     hdev->err_data_reporting =3D cp->err_data_reporting;
> > +}
> > +
> > static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff =
*skb)
> > {
> >       struct hci_rp_pin_code_reply *rp =3D (void *) skb->data;
> > @@ -3302,6 +3333,14 @@ static void hci_cmd_complete_evt(struct hci_dev =
*hdev, struct sk_buff *skb,
> >               hci_cc_read_inq_rsp_tx_power(hdev, skb);
> >               break;
> >
> > +     case HCI_OP_READ_DEF_ERR_DATA_REPORTING:
> > +             hci_cc_read_def_err_data_reporting(hdev, skb);
> > +             break;
> > +
> > +     case HCI_OP_WRITE_DEF_ERR_DATA_REPORTING:
> > +             hci_cc_write_def_err_data_reporting(hdev, skb);
> > +             break;
> > +
> >       case HCI_OP_PIN_CODE_REPLY:
> >               hci_cc_pin_code_reply(hdev, skb);
> >               break;
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 1002c657768a..a648241c8973 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -107,6 +107,7 @@ static const u16 mgmt_commands[] =3D {
> >       MGMT_OP_READ_EXT_INFO,
> >       MGMT_OP_SET_APPEARANCE,
> >       MGMT_OP_SET_BLOCKED_KEYS,
> > +     MGMT_OP_SET_WIDE_BAND_SPEECH,
>
> Lets use MGMT_OP_SET_WIDEBAND_SPEECH like we have in the documentation.
Ack.
>
> > };
> >
> > static const u16 mgmt_events[] =3D {
> > @@ -850,6 +851,9 @@ static u32 get_current_settings(struct hci_dev *hde=
v)
> >                       settings |=3D MGMT_SETTING_STATIC_ADDRESS;
> >       }
> >
> > +     if (hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED))
> > +             settings |=3D MGMT_SETTING_WIDE_BAND_SPEECH;
> > +
> >       return settings;
> > }
> >
> > @@ -3593,6 +3597,63 @@ static int set_blocked_keys(struct sock *sk, str=
uct hci_dev *hdev, void *data,
> >                               err, NULL, 0);
> > }
> >
> > +static int set_wide_band_speech(struct sock *sk, struct hci_dev *hdev,
> > +                              void *data, u16 len)
> > +{
> > +     struct mgmt_mode *cp =3D data;
> > +     int err;
> > +     bool changed =3D false;
> > +
> > +     BT_DBG("request for %s", hdev->name);
> > +
> > +     if (!test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks=
))
> > +             return mgmt_cmd_status(sk, hdev->id,
> > +                                    MGMT_OP_SET_WIDE_BAND_SPEECH,
> > +                                    MGMT_STATUS_NOT_SUPPORTED);
> > +
> > +     if (cp->val !=3D 0x00 && cp->val !=3D 0x01)
> > +             return mgmt_cmd_status(sk, hdev->id,
> > +                                    MGMT_OP_SET_WIDE_BAND_SPEECH,
> > +                                    MGMT_STATUS_INVALID_PARAMS);
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     if (pending_find(MGMT_OP_SET_WIDE_BAND_SPEECH, hdev)) {
> > +             err =3D mgmt_cmd_status(sk, hdev->id,
> > +                                   MGMT_OP_SET_WIDE_BAND_SPEECH,
> > +                                   MGMT_STATUS_BUSY);
> > +             goto unlock;
> > +     }
> > +
> > +     if (hdev_is_powered(hdev) &&
> > +         !!cp->val !=3D hci_dev_test_flag(hdev,
> > +                                        HCI_WIDE_BAND_SPEECH_ENABLED))=
 {
> > +             err =3D mgmt_cmd_status(sk, hdev->id,
> > +                                   MGMT_OP_SET_WIDE_BAND_SPEECH,
> > +                                   MGMT_STATUS_REJECTED);
> > +             goto unlock;
> > +     }
> > +
> > +     if (cp->val)
> > +             changed =3D !hci_dev_test_and_set_flag(hdev,
> > +                                               HCI_WIDE_BAND_SPEECH_EN=
ABLED);
> > +     else
> > +             changed =3D hci_dev_test_and_clear_flag(hdev,
> > +                                               HCI_WIDE_BAND_SPEECH_EN=
ABLED);
> > +
> > +     err =3D send_settings_rsp(sk, MGMT_OP_SET_WIDE_BAND_SPEECH, hdev)=
;
> > +     if (err < 0)
> > +             goto unlock;
> > +
> > +     if (changed)
> > +             err =3D new_settings(hdev, sk);
> > +
> > +unlock:
> > +
> > +     hci_dev_unlock(hdev);
> > +     return err;
> > +}
> > +
> > static void read_local_oob_data_complete(struct hci_dev *hdev, u8 statu=
s,
> >                                        u16 opcode, struct sk_buff *skb)
> > {
> > @@ -6994,6 +7055,7 @@ static const struct hci_mgmt_handler mgmt_handler=
s[] =3D {
> >       { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> >       { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE,
> >                                               HCI_MGMT_VAR_LEN },
> > +     { set_wide_band_speech,    MGMT_SETTING_SIZE },
> > };
> >
> > void mgmt_index_added(struct hci_dev *hdev)
>
> Rest looks good. Thanks.
>
> Regards
>
> Marcel
>
