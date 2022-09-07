Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E877C38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 19:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIGTfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGTfh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 15:35:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CE28C468
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 12:35:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq23so24033147lfb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CZ6TGZBxj4Do8BtyIfMXR47W1gj5/Dprx97IA0x9XDw=;
        b=VjprBWJDFpJUX6dxksgA0bC705kmRtFFA6bXnoNw+fgoBZT7phTKb0Z2pxNC0hu2sO
         kHahdKB8UZnmRdwsX2OZTQfk0fltrkVBKK3VT7ZBwn7wIppGvemfdsV/77EvFSN/UEFo
         GvtZRCpxoXzP2Hfr5at2gJUKL+juWOqUKDfxqOgxkmkZ4gQMBptwXnToSKevDBr/ImUe
         C+IYYoWmN0QcBN1AYNR54hXajnY/UyZoRkY+weZeX9q0zPI3HDZCkC2m4jSTkvhbf4l+
         fgm5B9RO1fWFGjJuusBtZmuSuALqelfv52g/UpXQNNTqgGqww9Dz2r2qqu+2gP5A60hw
         iYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CZ6TGZBxj4Do8BtyIfMXR47W1gj5/Dprx97IA0x9XDw=;
        b=6Y3CNkpLnfRxk3cazIuvoDdOD/tUNlbYExC++ap4m2pO440QfS8Szy7MKzINaEZjbp
         oI2JMZcjqxTnSfHzBSrC12QjYIYX7M2NkD76tSvAmHtItwMvbVErobaIeDqjWG79ZiHg
         MxagqARITiRq50iDUSWPBcY0S6TNZpLP84Tjh5seMs32tNPkRsbdS9XZUaZnlZctg0uW
         3SwwMSgnFZ0ig3iPGMHFqA9D8/o1kzxFntXTPkNJVaAeTq93AeBPgomKisSxFmfQ6zDx
         DZk5QwBSSio1dOY/7OcxNL4Rqsj6v2d8LG0Fe8KgyDzWrMZFhFewls5wpg3KIzM1ku+m
         Yybw==
X-Gm-Message-State: ACgBeo2LOBQSii979GODksnsoJJkLGjniWCu3n/QCqbx3gR8WxBNPmlK
        rVWX8tt28GQwrI+6h1zFADkpE8kkSS/YrzjchBbAflAhi5A=
X-Google-Smtp-Source: AA6agR5imH1aL2+CsHSUDuFho6A4UyhqcVsZqatgkqyUKLAG2NqT7nU/PdLH8GOofAWRPZwZaxBhabhJqtHUcJrfsNs=
X-Received: by 2002:a05:6512:33c9:b0:494:79c1:8ea1 with SMTP id
 d9-20020a05651233c900b0049479c18ea1mr1514753lfg.26.1662579334452; Wed, 07 Sep
 2022 12:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220907191450.38262-1-brian.gix@intel.com> <20220907191450.38262-2-brian.gix@intel.com>
In-Reply-To: <20220907191450.38262-2-brian.gix@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Sep 2022 12:35:23 -0700
Message-ID: <CABBYNZ+jiXJL2mkaRAnnPTcO6zTP2ZatUEOiVxEk4si=D57abg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] Bluetooth: Add mesh MGMT cmds/events to btmon parser
To:     Brian Gix <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Wed, Sep 7, 2022 at 12:15 PM Brian Gix <brian.gix@intel.com> wrote:
>
> Signed-off-by: Brian Gix <brian.gix@intel.com>

Ditto, as mentioned on previous patch please add a sample output to
the patch description.

> ---
>  monitor/packet.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 7447e1565..9d4a5e50d 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -14191,6 +14191,74 @@ static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
>         print_field("Handle: %d", handle);
>  }
>
> +static void mgmt_set_mesh_receiver_cmd(const void *data, uint16_t size)
> +{
> +       uint8_t enable = get_u8(data);
> +       uint16_t window = get_le16(data + 1);
> +       uint16_t period = get_le16(data + 3);
> +       uint8_t num_ad_types = get_u8(data + 5);
> +       const uint8_t *ad_types = data + 6;
> +
> +       print_field("Enable: %d", enable);
> +       print_field("Window: %d", window);
> +       print_field("Period: %d", period);
> +       print_field("Num AD Types: %d", num_ad_types);
> +       size -= 6;
> +
> +       while (size--)
> +               print_field("  AD Type: %d", *ad_types++);
> +}
> +
> +static void mgmt_read_mesh_features_rsp(const void *data, uint16_t size)
> +{
> +       uint16_t index = get_le16(data);
> +       uint8_t max_handles = get_u8(data + 2);
> +       uint8_t used_handles = get_u8(data + 3);
> +       const uint8_t *handles = data + 4;
> +
> +       print_field("Index: %d", index);
> +       print_field("Max Handles: %d", max_handles);
> +       print_field("Used Handles: %d", used_handles);
> +       size -= 4;
> +
> +       while (size--)
> +               print_field("  Used Handle: %d", *handles++);
> +}
> +
> +static void mgmt_mesh_send_cmd(const void *data, uint16_t size)
> +{
> +       const uint8_t *addr = data;
> +       uint8_t addr_type = get_u8(data + 6);
> +       uint64_t instant = get_le64(data + 7);
> +       uint16_t delay = get_le16(data + 15);
> +       uint8_t cnt = get_u8(data + 17);
> +       uint8_t adv_data_len = get_u8(data + 18);
> +
> +       data += 19;
> +       size -= 19;
> +       print_bdaddr(addr);
> +       print_field("Addr Type: %d", addr_type);
> +       print_field("Instant: 0x%16.16" PRIx64, instant);
> +       print_field("Delay: %d", delay);
> +       print_field("Count: %d", cnt);
> +       print_field("Data Length: %d", adv_data_len);
> +       print_hex_field("Data: ", data, size);
> +}
> +
> +static void mgmt_mesh_send_rsp(const void *data, uint16_t size)
> +{
> +       uint8_t handle = get_u8(data);
> +
> +       print_field("Handle: %d", handle);
> +}
> +
> +static void mgmt_mesh_send_cancel_cmd(const void *data, uint16_t size)
> +{
> +       uint8_t handle = get_u8(data);
> +
> +       print_field("Handle: %d", handle);
> +}
> +
>  struct mgmt_data {
>         uint16_t opcode;
>         const char *str;
> @@ -14448,6 +14516,18 @@ static const struct mgmt_data mgmt_command_table[] = {
>                                 mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
>                                                                         false,
>                                 mgmt_add_adv_monitor_patterns_rsp, 2, true},
> +       { 0x0057, "Set Mesh Receiver",
> +                               mgmt_set_mesh_receiver_cmd, 6, false,
> +                               mgmt_null_rsp, 0, true},
> +       { 0x0058, "Read Mesh Features",
> +                               mgmt_null_cmd, 0, true,
> +                               mgmt_read_mesh_features_rsp, 4, false},
> +       { 0x0059, "Mesh Send",
> +                               mgmt_mesh_send_cmd, 19, false,
> +                               mgmt_mesh_send_rsp, 1, true},
> +       { 0x0056, "Mesh Send Cancel",
> +                               mgmt_mesh_send_cancel_cmd, 1, true,
> +                               mgmt_null_rsp, 0, true},
>         { }
>  };
>
> @@ -14945,6 +15025,33 @@ static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
>         print_field("Addr Type: %d", addr_type);
>  }
>
> +static void mgmt_mesh_device_found_evt(const void *data, uint16_t size)
> +{
> +       const uint8_t *addr = data;
> +       uint8_t addr_type = get_u8(data + 6);
> +       int8_t rssi = get_s8(data + 7);
> +       uint64_t instant = get_le64(data + 8);
> +       uint32_t flags = get_le32(data + 16);
> +       uint16_t eir_len = get_le16(data + 20);
> +       const uint8_t *eir_data = data + 22;
> +
> +       print_bdaddr(addr);
> +       print_field("Addr Type: %d", addr_type);
> +       print_field("RSSI: %d", rssi);
> +       print_field("Instant: 0x%16.16" PRIx64, instant);
> +       mgmt_print_device_flags(flags);
> +       print_field("EIR Length: %d", eir_len);
> +       size -= 22;
> +       print_hex_field("EIR Data: ", eir_data, size);
> +}
> +
> +static void mgmt_mesh_packet_cmplt_evt(const void *data, uint16_t size)
> +{
> +       uint8_t handle = get_u8(data);
> +
> +       print_field("Handle: %d", handle);
> +}
> +
>  static const struct mgmt_data mgmt_event_table[] = {
>         { 0x0001, "Command Complete",
>                         mgmt_command_complete_evt, 3, false },
> @@ -15038,6 +15145,10 @@ static const struct mgmt_data mgmt_event_table[] = {
>                         mgmt_adv_monitor_device_found_evt, 16, false },
>         { 0x0030, "Controller Resumed",
>                         mgmt_adv_monitor_device_lost_evt, 9, true },
> +       { 0x0031, "Mesh Device Found",
> +                       mgmt_mesh_device_found_evt, 22, false },
> +       { 0x0032, "Mesh Packet Complete",
> +                       mgmt_mesh_packet_cmplt_evt, 1, true },
>         { }
>  };
>
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
