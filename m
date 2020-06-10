Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61345C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1825A2063A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4BTpDfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFJQGe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFJQGd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 12:06:33 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80968C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 09:06:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r2so2819054ioo.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X62lz21/xnfdDYL0pZzPmolpEn8gxgPFH7i8xZbDCsQ=;
        b=E4BTpDfKUp4SF/iARjKDVN+XHacwR6lFN5KXKkXEFWuohQ0+sTXwPdHnw3PJbpNP8s
         GBBW/t3XP3OTOdoX/fVDgbJzYRRs6xmYvRqNM4TqZUVHvjU1aGCtbDkbDdGDXaucJMN9
         x8/6TguvAqp1os8YzYzKBSPAtCM2OxBp/l1+ophblpF5hArwF3IAIThQ7UnYpb/iD7TE
         sHIf/XfDIHSPTSqVuwbIYQZaj+c6KswtzgtYG+3lh69J/xJ1t+9FSj+FWSokU2SdfE95
         sEezB/ZQMIUcPZs7cE9KsT1PHmw9w2ltQgNyJK1hiiJM6HbZVdXNMIRizzjkvL78dhoV
         UPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X62lz21/xnfdDYL0pZzPmolpEn8gxgPFH7i8xZbDCsQ=;
        b=krtAtgj/UjYidLp1y2eLBpHRizMe4oJfOAL4h/1AvC7Ntdue18pue8MPNDrmiQuNqC
         JgOEhBJyq1KpTlMiRACxTiqX0EJlmeg3JFbERWZPk9IutMRUb+EzdzZGO0xJSJJRtntP
         eFMx+iLj5tjMIEnI2/eiSZeV21Z4Exv6W+SUQ/TQcfHxxH25Uo9RMD93gAa4ugl1GvaS
         w1X+QgLWIfiaqNswxDVoTrZggRqI7J0jJeEi0rGCf36ObDg47o473DuhYLFUC/FQBFhU
         SnRAxutab1Pdecn+3i2tiQpRIA5vJq5INRBNxyXAPoDlye0HDBuOMxrZyQux2S9FDmEi
         jY2w==
X-Gm-Message-State: AOAM533UuJ+BnAznjeRufHRKovgqcAQshdOI+Q4/mqaHhzxPCUVhQKIH
        2n4wjxhCnI8JkbI2a1oNxYuh6pO+YjsgFeXjk1rEUw==
X-Google-Smtp-Source: ABdhPJz0dRZbRFWgjXh5VqcZmzhTF0652gzjKZj4juZgkw31pZxNqF/YbKVqexnuQeBHVpPRIO6Xnymkkd/rfWew2OA=
X-Received: by 2002:a02:a78e:: with SMTP id e14mr3861049jaj.9.1591805191928;
 Wed, 10 Jun 2020 09:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200609140351.153833-1-alainm@chromium.org> <20200609140351.153833-4-alainm@chromium.org>
 <4CD6CBD8-0EC4-47F1-8B05-5AC8BB78B97A@holtmann.org>
In-Reply-To: <4CD6CBD8-0EC4-47F1-8B05-5AC8BB78B97A@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 10 Jun 2020 12:06:20 -0400
Message-ID: <CALWDO_UynvNvTwh6mfsEFR+vEiLC3zCMbRdEpB+Hm9C+5RTGDA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] bluetooth: implement read/set default system
 parameters mgmt
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jun 10, 2020 at 10:36 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> > This patch implements the read default system parameters and the set
> > default system parameters mgmt commands.
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > net/bluetooth/mgmt.c | 429 +++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 429 insertions(+)
>
> I have the feeling that we want to create a net/bluetooth/mgmt_config.c t=
o move all the configuration parameters parsing and handling into a separat=
e. I have the feeling that otherwise mgmt.c will grow quickly.
ok, I'll send out a v2 that split it out in mgmt_config.c/h

>
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 9e8a3cccc6ca..98a4193c8e66 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -111,6 +111,8 @@ static const u16 mgmt_commands[] =3D {
> >       MGMT_OP_READ_SECURITY_INFO,
> >       MGMT_OP_READ_EXP_FEATURES_INFO,
> >       MGMT_OP_SET_EXP_FEATURE,
> > +     MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS,
> > +     MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
> > };
>
> Please also add the OP_READ_ command to mgmt_untrusted_commands array.
ACK.
>
> > static const u16 mgmt_events[] =3D {
> > @@ -3849,6 +3851,431 @@ static int set_exp_feature(struct sock *sk, str=
uct hci_dev *hdev,
> >                              MGMT_STATUS_NOT_SUPPORTED);
> > }
> >
> > +static int read_default_system_parameters(struct sock *sk, struct hci_=
dev *hdev,
> > +                                       void *data, u16 data_len)
> > +{
> > +     struct {
> > +             struct mgmt_system_parameter_tlv entry;
> > +             union {
> > +                     /* This is a simplification for now since all val=
ues
> > +                      * are 16 bits.  In the future, this code may nee=
d
> > +                      * refactoring to account for variable length val=
ues
> > +                      * and properly calculate the required buffer siz=
e.
> > +                      */
> > +                     u16 value;
> > +             };
> > +     } __packed params[] =3D {
> > +             /* Please see mgmt-api.txt for documentation of these val=
ues */
> > +             {
> > +                     { 0x0000, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_page_scan_type) }
> > +             },
> > +             {
> > +                     { 0x0001, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_page_scan_int) }
> > +             },
> > +             {
> > +                     { 0x0002, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_page_scan_window) }
> > +             },
> > +             {
> > +                     { 0x0003, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_inq_scan_type) }
> > +             },
> > +             {
> > +                     { 0x0004, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_inq_scan_int) }
> > +             },
> > +             {
> > +                     { 0x0005, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_inq_scan_window) }
> > +             },
> > +             {
> > +                     { 0x0006, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_br_lsto) }
> > +             },
> > +             {
> > +                     { 0x0007, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_page_timeout) }
> > +             },
> > +             {
> > +                     { 0x0008, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->sniff_min_interval) }
> > +             },
> > +             {
> > +                     { 0x0009, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->sniff_max_interval) }
> > +             },
> > +             {
> > +                     { 0x000a, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_adv_min_interval) }
> > +             },
> > +             {
> > +                     { 0x000b, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_adv_max_interval) }
> > +             },
> > +             {
> > +                     { 0x000c, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->def_multi_adv_rotation_durati=
on) }
> > +             },
> > +             {
> > +                     { 0x000d, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_interval) }
> > +             },
> > +             {
> > +                     { 0x000e, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_window) }
> > +             },
> > +             {
> > +                     { 0x000f, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_int_suspend) }
> > +             },
> > +             {
> > +                     { 0x0010, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_window_suspend) }
> > +             },
> > +             {
> > +                     { 0x0011, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_int_discovery) }
> > +             },
> > +             {
> > +                     { 0x0012, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_window_discovery) }
> > +             },
> > +             {
> > +                     { 0x0013, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_int_adv_monitor) }
> > +             },
> > +             {
> > +                     { 0x0014, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_window_adv_monitor) }
> > +             },
> > +             {
> > +                     { 0x0015, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_int_connect) }
> > +             },
> > +             {
> > +                     { 0x0016, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_scan_window_connect) }
> > +             },
> > +             {
> > +                     { 0x0017, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_conn_min_interval) }
> > +             },
> > +             {
> > +                     { 0x0018, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_conn_max_interval) }
> > +             },
> > +             {
> > +                     { 0x0019, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_conn_latency) }
> > +             },
> > +             {
> > +                     { 0x001a, sizeof(__u16) },
> > +                     { cpu_to_le16(hdev->le_supv_timeout) }
> > +             },
>
> This is creative and I like it. However I would take it one step further.=
 Define a macro similar USB_DEVICE etc. so you get a simpler table.
>
>         { HDEV_PARAM(0x0018, le_conn_max_interval) },
>         { HDEV_PARAM(0x0019, le_conn_latency) },
>         { }
>
>
Ok, that makes sense, I'll think of something for v2.

> > +     };
> > +     struct mgmt_rp_read_default_system_parameters *rp =3D (void *)par=
ams;
> > +
> > +     bt_dev_dbg(hdev, "sock %p", sk);
> > +
> > +     return mgmt_cmd_complete(sk, hdev->id,
> > +                              MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS,
> > +                              0, rp, sizeof(params));
>
> Please introduce HCI_MGMT_SYSTEM_CONFIG_EVENTS and send them out as descr=
ibed in mgmt-api.txt
Looks like you added this after my original proposal to mgmt-api.txt.
I'd like to propose this is also implemented in a separate patch.

>
> > +}
> > +
> > +#define TO_TLV(x) ((struct mgmt_system_parameter_tlv *)(x))
> > +#define TLV_VALUE_CAST(tlv, type) (*((type *)(TO_TLV(tlv)->value)))
> > +
> > +static int set_default_system_parameters(struct sock *sk, struct hci_d=
ev *hdev,
> > +                                      void *data, u16 data_len)
> > +{
> > +     u16 buffer_left =3D data_len;
> > +     u8 *buffer =3D data;
> > +
> > +     if (buffer_left < sizeof(struct mgmt_system_parameter_tlv)) {
> > +             return mgmt_cmd_status(sk, hdev->id,
> > +                                    MGMT_OP_SET_DEFAULT_SYSTEM_PARAMET=
ERS,
> > +                                    MGMT_STATUS_INVALID_PARAMS);
> > +     }
> > +
> > +     /* First pass to validate the tlv */
> > +     while (buffer_left >=3D sizeof(struct mgmt_system_parameter_tlv))=
 {
> > +             const u8 len =3D TO_TLV(buffer)->length;
> > +             const u16 exp_len =3D sizeof(struct mgmt_system_parameter=
_tlv) +
> > +                                 len;
> > +             const u16 type =3D le16_to_cpu(TO_TLV(buffer)->type);
> > +
> > +             if (buffer_left < exp_len) {
> > +                     bt_dev_warn(hdev, "invalid len left %d, exp >=3D =
%d",
> > +                                 buffer_left, exp_len);
> > +
> > +                     return mgmt_cmd_status(sk, hdev->id,
> > +                                     MGMT_OP_SET_DEFAULT_SYSTEM_PARAME=
TERS,
> > +                                     MGMT_STATUS_INVALID_PARAMS);
> > +             }
> > +
> > +             /* Please see mgmt-api.txt for documentation of these val=
ues */
> > +             switch (type) {
> > +             case 0x0000:
> > +             case 0x0001:
> > +             case 0x0002:
> > +             case 0x0003:
> > +             case 0x0004:
> > +             case 0x0005:
> > +             case 0x0006:
> > +             case 0x0007:
> > +             case 0x0008:
> > +             case 0x0009:
> > +             case 0x000a:
> > +             case 0x000b:
> > +             case 0x000c:
> > +             case 0x000d:
> > +             case 0x000e:
> > +             case 0x000f:
> > +             case 0x0010:
> > +             case 0x0011:
> > +             case 0x0012:
> > +             case 0x0013:
> > +             case 0x0014:
> > +             case 0x0015:
> > +             case 0x0016:
> > +             case 0x0017:
> > +             case 0x0018:
> > +             case 0x0019:
> > +             case 0x001a:
> > +                     if (len !=3D sizeof(u16)) {
> > +                             bt_dev_warn(hdev, "invalid length %d, exp=
 %zu for type %d",
> > +                                         len, sizeof(u16), type);
> > +
> > +                             return mgmt_cmd_status(sk, hdev->id,
> > +                                     MGMT_OP_SET_DEFAULT_SYSTEM_PARAME=
TERS,
> > +                                     MGMT_STATUS_INVALID_PARAMS);
> > +                     }
> > +                     break;
> > +             default:
> > +                     bt_dev_warn(hdev, "unsupported parameter %u", typ=
e);
> > +                     break;
> > +             }
> > +
> > +             buffer_left -=3D exp_len;
> > +             buffer +=3D exp_len;
> > +     }
> > +
> > +     buffer_left =3D data_len;
> > +     buffer =3D data;
> > +     while (buffer_left >=3D sizeof(struct mgmt_system_parameter_tlv))=
 {
> > +             const u8 len =3D TO_TLV(buffer)->length;
> > +             const u16 exp_len =3D sizeof(struct mgmt_system_parameter=
_tlv) +
> > +                                 len;
> > +             const u16 type =3D le16_to_cpu(TO_TLV(buffer)->type);
> > +
> > +             switch (type) {
> > +             case 0x0000:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_page_scan_type =3D le16_to_cpu(val);
>
> I would really turn this into a single macro that also does the byte_swap=
ping and more importantly also the unaligned access. Mainly because I highl=
y doubt the TLV_VALUE_CAST will actually work on ARM platforms. So I am thi=
nking something along the lines of this:
>
>                 hdev->def_page_scan_type =3D TLV_GET_LE16(buffer);
>
ok.


> > +                     break;
> > +             }
> > +             case 0x0001:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_page_scan_int =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0002:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_page_scan_window =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0003:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_inq_scan_type =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0004:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_inq_scan_int =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0005:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_inq_scan_window =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0006:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_br_lsto =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0007:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_page_timeout =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0008:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->sniff_min_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0009:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->sniff_max_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x000a:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_adv_min_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x000b:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_adv_max_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x000c:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->def_multi_adv_rotation_duration =3D
> > +                                                            le16_to_cp=
u(val);
> > +                     break;
> > +             }
> > +             case 0x000d:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x000e:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_window =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x000f:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_int_suspend =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0010:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_window_suspend =3D le16_to_cpu(val)=
;
> > +                     break;
> > +             }
> > +             case 0x0011:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_int_discovery =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x00012:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_window_discovery =3D le16_to_cpu(va=
l);
> > +                     break;
> > +             }
> > +             case 0x00013:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_int_adv_monitor =3D le16_to_cpu(val=
);
> > +                     break;
> > +             }
> > +             case 0x00014:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_window_adv_monitor =3D le16_to_cpu(=
val);
> > +                     break;
> > +             }
> > +             case 0x00015:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_int_connect =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x00016:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_scan_window_connect =3D le16_to_cpu(val)=
;
> > +                     break;
> > +             }
> > +             case 0x00017:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_conn_min_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x00018:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_conn_max_interval =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x00019:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_conn_latency =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             case 0x0001a:
> > +             {
> > +                     const u16 val =3D TLV_VALUE_CAST(buffer, u16);
> > +
> > +                     hdev->le_supv_timeout =3D le16_to_cpu(val);
> > +                     break;
> > +             }
> > +             default:
> > +                     bt_dev_warn(hdev, "unsupported parameter %u",
> > +                                 buffer[0]);
> > +                     break;
> > +             }
> > +
> > +             buffer_left -=3D exp_len;
> > +             buffer +=3D exp_len;
> > +     }
> > +
> > +     return mgmt_cmd_status(sk, hdev->id,
> > +                            MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
> > +                            MGMT_STATUS_SUCCESS);
> > +}
> > +
> > static void read_local_oob_data_complete(struct hci_dev *hdev, u8 statu=
s,
> >                                        u16 opcode, struct sk_buff *skb)
> > {
> > @@ -7297,6 +7724,8 @@ static const struct hci_mgmt_handler mgmt_handler=
s[] =3D {
> >       { set_exp_feature,         MGMT_SET_EXP_FEATURE_SIZE,
> >                                               HCI_MGMT_VAR_LEN |
> >                                               HCI_MGMT_HDEV_OPTIONAL },
> > +     { read_default_system_parameters, 0, HCI_MGMT_UNTRUSTED },
> > +     { set_default_system_parameters, 0, HCI_MGMT_VAR_LEN },
> > };
> >
> > void mgmt_index_added(struct hci_dev *hdev)
>
> Regards
>
> Marcel
>
