Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640FAC4743C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 18:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5039E611CE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 18:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFUSXr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhFUSX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 14:23:29 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A815C061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 11:13:12 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j62so32772342qke.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8L7mFs2/NnGY631bncVN88Qp5a8SeQTE4f6jHimXOXA=;
        b=Ltp807Ur05BJLE9xhm5d9omXApy75/oyvKGSptnjwyLWCCoh2H4pZjSp2x6sqoVMYG
         hesJ/1bFMvTBxSb8Z3b+3stAZhTvTRWl6usg8j1IQHLa9GgKTnyB79w8+6s9qsK+GEkp
         2ukhbx9r1Ae9s26fTAuZdB0zQ7EwuP04mP3/QSbZ+Po+DHqCgDDFEo8dcxps1MP69gDw
         zL7/W3nUPkt0/CuxwJis/HJantbtadBy6LQEQ2weYsfEF3QDiASRI4C0KBVCPuM/+UUj
         IpxQR6CDyz6ahRF0P4vy8S5mSv0Na3LVnQjZYhooIfSwnS5yx4SrzB378k1vy6P7rUz7
         KVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8L7mFs2/NnGY631bncVN88Qp5a8SeQTE4f6jHimXOXA=;
        b=Tp7C3BY/tmutqIWDz6lXg3+NZeJW3+xfqIgCb47keOpHhPA2OhcSUeJiPR/MAOj1MY
         uY/RHzw6gZm93sIA78g9QEyySxXmJyF2M4wefDmwW0Km7YLQ3s1yXJ5Xd1Qqp5UEKc+A
         +9kFVbToOSBdrCO/a8YnYYD/JqciCmey7SwR6EQz9QHt6BJS5eZrGDKIZMU3xlv+B2q/
         jJB8Dc+4Dg4d4wbBwCzXLQhihDBPvmT6z6qMVFhrTEIevullUCKwfwFN1Nxzo7pdl8XZ
         mrb6CQYC3pxpiSBt0g1L7fTqwBlW9X/3hB6xvsl4mucH1je99y73HvmdYIJDcyPupYsC
         7Z2A==
X-Gm-Message-State: AOAM5315LbBDdw0O/vAucFe/qrlBp0LV7/yJh1TVeysXpT6gmCXBsqkb
        RkM+fET+eCwtuR0oYJLmkPDVGvDz31pZubJ3zxQ=
X-Google-Smtp-Source: ABdhPJylRDCf1g7kKWdc9ZOZTxu9vIFOnnGu7QEGe1UWPzkWjGEe5jLFkhq21SInGpVndKs+JUWcm1T3QHaVy+88VOU=
X-Received: by 2002:a5b:b44:: with SMTP id b4mr11497193ybr.440.1624299191106;
 Mon, 21 Jun 2021 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
In-Reply-To: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Jun 2021 11:13:00 -0700
Message-ID: <CABBYNZL2gr2nQkZMM9-nU0AW+2z53xHbZFDJDXfMv+8tiOkT1A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/3] monitor: add new Intel extended telemetry events
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Mon, Jun 21, 2021 at 3:23 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> This patch adds new Intel extended telemetry events for both ACL and
> SCO/eSCO audio link quality reports.
>
> For SCO/eSCO audio link quality report, it shows something like
> > HCI Event: Vendor (0xff) plen 190  #120 [hci0] 2021-05-31 20:27:50.257
>       Intel Extended Telemetry (0x87)
>         Extended Telemetry (0x80): SubOpcode (0x03)
>         Extended event type (0x01): Audio Link Quality Report Type(0x05)
>         SCO/eSCO connection handle (0x6a): 0x0101
>         Packets from host (0x6b): 399
>         Tx packets (0x6c): 403
>         Rx payload lost (0x6d): 3
>         Tx payload lost (0x6e): 0
>         Rx No SYNC errors (0x6f): 3 2 3 3 0
>         Rx HEC errors (0x70): 0 0 0 0 0
>         Rx CRC errors (0x71): 2 0 0 0 0
>         Rx NAK errors (0x72): 6 0 0 0 0
>         Failed Tx due to Wifi coex (0x73): 6 0 0 0 0
>         Failed Rx due to Wifi coex (0x74): 0 0 0 0 0
>         Late samples inserted based on CDC (0x75): 0
>         Samples dropped (0x76): 0
>         Mute samples sent at initial connection (0x77): 0
>         PLC injection data (0x78): 0
>
> For ACL audio link quality report, it shows something like
> > HCI Event: Vendor (0xff) plen 142  #120 [hci0] 2021-05-31 20:27:50.261
>       Intel Extended Telemetry (0x87)
>         Extended Telemetry (0x80): SubOpcode (0x03)
>         Extended event type (0x01): Audio Link Quality Report Type(0x05)
>         ACL connection handle (0x4a): 0x0100
>         Rx HEC errors (0x4b): 0
>         Rx CRC errors (0x4c): 0
>         Packets from host (0x4d): 100
>         Tx packets (0x4e): 101
>         Tx packets 0 retries (0x4f): 89
>         Tx packets 1 retries (0x50): 11
>         Tx packets 2 retries (0x51): 1
>         Tx packets 3 retries (0x52): 0
>         Tx packets 4 retries and more (0x53): 0
>         Tx DH1 packets (0x54): 0
>         Tx DH3 packets (0x55): 0
>         Tx DH5 packets (0x56): 0
>         Tx 2DH1 packets (0x57): 0
>         Tx 2DH3 packets (0x58): 0
>         Tx 2DH5 packets (0x59): 0
>         Tx 3DH1 packets (0x5a): 6
>         Tx 3DH3 packets (0x5b): 0
>         Tx 3DH5 packets (0x5c): 94
>         Rx packets (0x5d): 272
>         ACL link throughput (KBps) (0x5e): 343815
>         ACL max packet latency (ms) (0x5f): 20625
>         ACL avg packet latency (ms) (0x60): 12
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> Changes in v2:
> - Perform size checks for tlv subevents.
> - Fix the Make errors about qualifiers.
>
>  monitor/intel.c  | 472 +++++++++++++++++++++++++++++++++++++++++++++++
>  monitor/vendor.h |   6 +
>  2 files changed, 478 insertions(+)
>
> diff --git a/monitor/intel.c b/monitor/intel.c
> index d2aefa6a8..af7402db4 100644
> --- a/monitor/intel.c
> +++ b/monitor/intel.c
> @@ -30,6 +30,7 @@
>
>  #define COLOR_UNKNOWN_EVENT_MASK       COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_SCAN_STATUS      COLOR_WHITE_BG
> +#define COLOR_UNKNOWN_EXT_EVENT                COLOR_WHITE_BG
>
>  static void print_status(uint8_t status)
>  {
> @@ -958,6 +959,8 @@ static void system_exception_evt(const void *data, uint8_t size)
>         packet_hexdump(data + 1, size - 1);
>  }
>
> +static void intel_vendor_ext_evt(const void *data, uint8_t size);
> +
>  static const struct vendor_evt vendor_evt_table[] = {
>         { 0x00, "Startup",
>                         startup_evt, 0, true },
> @@ -989,6 +992,7 @@ static const struct vendor_evt vendor_evt_table[] = {
>                         system_exception_evt, 133, true },
>         { 0x2c, "FW Trace String" },
>         { 0x2e, "FW Trace Binary" },
> +       { 0x87, "Extended Telemetry", intel_vendor_ext_evt },
>         { }
>  };
>
> @@ -1003,3 +1007,471 @@ const struct vendor_evt *intel_vendor_evt(uint8_t evt)
>
>         return NULL;
>  }
> +
> +static void ext_evt_type(uint8_t subevent_id, const void *data, uint8_t size)
> +{
> +       uint8_t evt_type = get_u8(data);
> +       const char *str;
> +
> +       switch (evt_type) {
> +       case 0x00:
> +               str = "System Exception";
> +               break;
> +       case 0x01:
> +               str = "Fatal Exception";
> +               break;
> +       case 0x02:
> +               str = "Debug Exception";
> +               break;
> +       case 0x03:
> +               str = "Connection Event for BR/EDR Link Type";
> +               break;
> +       case 0x04:
> +               str = "Disconnection Event";
> +               break;
> +       case 0x05:
> +               str = "Audio Link Quality Report Type";
> +               break;
> +       case 0x06:
> +               str = "Stats for BR/EDR Link Type";
> +               break;
> +       default:
> +               print_text(COLOR_UNKNOWN_EXT_EVENT,
> +                       "Unknown extended telemetry event type (0x%2.2x)",
> +                       evt_type);
> +               packet_hexdump(data, size);
> +               return;
> +       }
> +
> +       print_field("Extended event type (0x%2.2x): %s (0x%2.2x)",
> +                       subevent_id, str, evt_type);
> +}
> +
> +static void ext_acl_evt_conn_handle(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint16_t conn_handle = get_le16(data);
> +
> +       print_field("ACL connection handle (0x%2.2x): 0x%4.4x",
> +                       subevent_id, conn_handle);
> +}
> +
> +static void ext_acl_evt_hec_errors(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Rx HEC errors (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_acl_evt_crc_errors(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Rx CRC errors (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_acl_evt_num_pkt_from_host(uint8_t subevent_id, const void *data,
> +                                               uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Packets from host (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_acl_evt_num_tx_pkt_to_air(uint8_t subevent_id, const void *data,
> +                                               uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Tx packets (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_acl_evt_num_tx_pkt_retry(uint8_t subevent_id, const void *data,
> +                                               uint8_t size)
> +{
> +       char *subevent_str;
> +       uint32_t num = get_le32(data);
> +
> +       switch (subevent_id) {
> +       case 0x4f:
> +               subevent_str = "Tx packets 0 retries";
> +               break;
> +       case 0x50:
> +               subevent_str = "Tx packets 1 retries";
> +               break;
> +       case 0x51:
> +               subevent_str = "Tx packets 2 retries";
> +               break;
> +       case 0x52:
> +               subevent_str = "Tx packets 3 retries";
> +               break;
> +       case 0x53:
> +               subevent_str = "Tx packets 4 retries and more";
> +               break;
> +       default:
> +               subevent_str = "Unknown";
> +               break;
> +       }
> +
> +       print_field("%s (0x%2.2x): %d", subevent_str, subevent_id, num);
> +}
> +
> +static void ext_acl_evt_num_tx_pkt_type(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       char *packet_type_str;
> +       uint32_t num = get_le32(data);
> +
> +       switch (subevent_id) {
> +       case 0x54:
> +               packet_type_str = "DH1";
> +               break;
> +       case 0x55:
> +               packet_type_str = "DH3";
> +               break;
> +       case 0x56:
> +               packet_type_str = "DH5";
> +               break;
> +       case 0x57:
> +               packet_type_str = "2DH1";
> +               break;
> +       case 0x58:
> +               packet_type_str = "2DH3";
> +               break;
> +       case 0x59:
> +               packet_type_str = "2DH5";
> +               break;
> +       case 0x5a:
> +               packet_type_str = "3DH1";
> +               break;
> +       case 0x5b:
> +               packet_type_str = "3DH3";
> +               break;
> +       case 0x5c:
> +               packet_type_str = "3DH5";
> +               break;
> +       default:
> +               packet_type_str = "Unknown";
> +               break;
> +       }
> +
> +       print_field("Tx %s packets (0x%2.2x): %d",
> +                       packet_type_str, subevent_id, num);
> +}
> +
> +static void ext_acl_evt_num_rx_pkt_from_air(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Rx packets (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_acl_evt_link_throughput(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("ACL link throughput (KBps) (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_acl_evt_max_packet_latency(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("ACL max packet latency (ms) (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_acl_evt_avg_packet_latency(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("ACL avg packet latency (ms) (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_sco_evt_conn_handle(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint16_t conn_handle = get_le16(data);
> +
> +       print_field("SCO/eSCO connection handle (0x%2.2x): 0x%4.4x",
> +                       subevent_id, conn_handle);
> +}
> +
> +static void ext_sco_evt_num_rx_pkt_from_air(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Packets from host (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_sco_evt_num_tx_pkt_to_air(uint8_t subevent_id, const void *data,
> +                                               uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Tx packets (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_sco_evt_num_rx_payloads_lost(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Rx payload lost (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_sco_evt_num_tx_payloads_lost(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Tx payload lost (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void slots_errors(const char *type_str, uint8_t subevent_id,
> +                               const void *data, uint8_t size)
> +{
> +       /* The subevent has 5 slots where each slot is of the uint32_t type. */
> +       uint32_t num[5];
> +       int i;
> +
> +       if (size != 5 * sizeof(uint32_t)) {
> +               print_text(COLOR_UNKNOWN_EXT_EVENT,
> +                               "  Invalid subevent length (%d)", size);
> +               return;
> +       }
> +
> +       for (i = 0; i < 5; i++) {
> +               num[i] = get_le32(data);
> +               data = (const void *)((const uint8_t *) data +
> +                                               sizeof(uint32_t));
> +       }
> +
> +       print_field("%s (0x%2.2x): %d %d %d %d %d", type_str, subevent_id,
> +                       num[0], num[1], num[2], num[3], num[4]);
> +}
> +
> +static void ext_sco_evt_num_no_sync_errors(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       slots_errors("Rx No SYNC errors", subevent_id, data, size);
> +}
> +
> +static void ext_sco_evt_num_hec_errors(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       slots_errors("Rx HEC errors", subevent_id, data, size);
> +}
> +
> +static void ext_sco_evt_num_crc_errors(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       slots_errors("Rx CRC errors", subevent_id, data, size);
> +}
> +
> +static void ext_sco_evt_num_naks(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       slots_errors("Rx NAK errors", subevent_id, data, size);
> +}
> +
> +static void ext_sco_evt_num_failed_tx_by_wifi(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       slots_errors("Failed Tx due to Wifi coex", subevent_id, data, size);
> +}
> +
> +static void ext_sco_evt_num_failed_rx_by_wifi(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       slots_errors("Failed Rx due to Wifi coex", subevent_id, data, size);
> +}
> +
> +static void ext_sco_evt_samples_inserted(uint8_t subevent_id, const void *data,
> +                                               uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Late samples inserted based on CDC (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_sco_evt_samples_dropped(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Samples dropped (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +static void ext_sco_evt_mute_samples(uint8_t subevent_id, const void *data,
> +                                       uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("Mute samples sent at initial connection (0x%2.2x): %d",
> +                       subevent_id, num);
> +}
> +
> +static void ext_sco_evt_plc_injection_data(uint8_t subevent_id,
> +                                               const void *data, uint8_t size)
> +{
> +       uint32_t num = get_le32(data);
> +
> +       print_field("PLC injection data (0x%2.2x): %d", subevent_id, num);
> +}
> +
> +
> +static const struct vendor_ext_subevent vendor_ext_subevent_table[] = {
> +       { 0x01, 1, ext_evt_type },
> +
> +       /* ACL audio link quality subevents */
> +       { 0x4a, 2, ext_acl_evt_conn_handle },
> +       { 0x4b, 4, ext_acl_evt_hec_errors },
> +       { 0x4c, 4, ext_acl_evt_crc_errors },
> +       { 0x4d, 4, ext_acl_evt_num_pkt_from_host },
> +       { 0x4e, 4, ext_acl_evt_num_tx_pkt_to_air },
> +       { 0x4f, 4, ext_acl_evt_num_tx_pkt_retry },
> +       { 0x50, 4, ext_acl_evt_num_tx_pkt_retry },
> +       { 0x51, 4, ext_acl_evt_num_tx_pkt_retry },
> +       { 0x52, 4, ext_acl_evt_num_tx_pkt_retry },
> +       { 0x53, 4, ext_acl_evt_num_tx_pkt_retry },
> +       { 0x54, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x55, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x56, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x57, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x58, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x59, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x5a, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x5b, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x5c, 4, ext_acl_evt_num_tx_pkt_type },
> +       { 0x5d, 4, ext_acl_evt_num_rx_pkt_from_air },
> +       { 0x5e, 4, ext_acl_evt_link_throughput },
> +       { 0x5f, 4, ext_acl_evt_max_packet_latency },
> +       { 0x60, 4, ext_acl_evt_avg_packet_latency },
> +
> +       /* SCO/eSCO audio link quality subevents */
> +       { 0x6a, 2, ext_sco_evt_conn_handle },
> +       { 0x6b, 4, ext_sco_evt_num_rx_pkt_from_air },
> +       { 0x6c, 4, ext_sco_evt_num_tx_pkt_to_air },
> +       { 0x6d, 4, ext_sco_evt_num_rx_payloads_lost },
> +       { 0x6e, 4, ext_sco_evt_num_tx_payloads_lost },
> +       { 0x6f, 20, ext_sco_evt_num_no_sync_errors },
> +       { 0x70, 20, ext_sco_evt_num_hec_errors },
> +       { 0x71, 20, ext_sco_evt_num_crc_errors },
> +       { 0x72, 20, ext_sco_evt_num_naks },
> +       { 0x73, 20, ext_sco_evt_num_failed_tx_by_wifi },
> +       { 0x74, 20, ext_sco_evt_num_failed_rx_by_wifi },
> +       { 0x75, 4, ext_sco_evt_samples_inserted },
> +       { 0x76, 4, ext_sco_evt_samples_dropped },
> +       { 0x77, 4, ext_sco_evt_mute_samples },
> +       { 0x78, 4, ext_sco_evt_plc_injection_data },
> +
> +       /* end */
> +       { 0x0, 0}
> +};
> +
> +static const uint8_t *process_ext_subevent(const uint8_t *data,
> +                                       const uint8_t *event_end)
> +{
> +       /*
> +        * A subevent is of the TLV format.
> +        * - Type: takes 1 byte. This is the subevent_id.
> +        * - Length: takes 1 byte.
> +        * - Value: takes |Length| bytes.
> +        */
> +       uint8_t subevent_id = *data;
> +       uint8_t length = *(data + sizeof(uint8_t));
> +       const uint8_t *next_tlv = (const uint8_t *) data + 2 * sizeof(uint8_t) +
> +                                       length;

It might be a good idea to have a packed struct that has these fields
instead of doing this pointer arithmetic manually.

> +       const struct vendor_ext_subevent *subevent = NULL;
> +       int i;
> +
> +       if (next_tlv > event_end) {
> +               print_text(COLOR_ERROR, "Subevent exceeds the buffer size.");
> +               return NULL;
> +       }

It might be better to move this check after processing the current tlv
entry, so in case there is an error while processing we know exactly
at which point it failed.

> +       for (i = 0; vendor_ext_subevent_table[i].length > 0; i++) {
> +               if (vendor_ext_subevent_table[i].subevent_id == subevent_id) {
> +                       subevent = &vendor_ext_subevent_table[i];
> +                       break;
> +               }
> +       }
> +
> +       if (!subevent) {
> +               print_text(COLOR_UNKNOWN_EXT_EVENT,
> +                               "Unknown extended event type id (0x%2.2x)",
> +                               subevent_id);
> +               return NULL;
> +       }
> +
> +       if (length != subevent->length) {
> +               print_text(COLOR_ERROR, "Invalid subevent length");
> +               return NULL;
> +       }
> +
> +       subevent->func(subevent_id, data + 2 * sizeof(uint8_t), length);
> +
> +       return next_tlv;
> +}
> +
> +static void intel_vendor_ext_evt(const void *data, uint8_t size)
> +{
> +       const uint8_t *tlv = (const uint8_t *) data;
> +       uint8_t ext_telemetry_type = *tlv;
> +       uint8_t sub_opcode = *(tlv + sizeof(uint8_t));
> +       const uint8_t *event_end = (const uint8_t *) data + size;

Same thing as above, use a packed struct to represent the tlv entries.

> +
> +       /*
> +        * Intel extended telemetry event is of the format:
> +        *   Event Code: 0xff
> +        *   Length:     0xnn
> +        *   Event Type: 0x8780
> +        *   SubOpcode:  0x03
> +        *   A number of TLV data
> +        *
> +        *   Each TLV Data, i.e., a subevent, consists of
> +        *     Subevent Id
> +        *     Length
> +        *     Value
> +        *
> +        * Arrives here through the telemetry event (0x87) in vendor_evt_table.
> +        * It is required to further check the extended telemetry type (0x80)
> +        * and sub-opcode (0x03) in the tlv data.
> +        */
> +       if (ext_telemetry_type == 0x80 && sub_opcode == 0x03) {
> +               /* Consumed two octets, i.e., 0x80 and 0x03. */

I'd probably add a table for these as well, so in the future if we
need to add handling of other subevents we just add another opcode and
callback to handle it.

> +               print_field("Extended Telemetry (0x%2.2x): SubOpcode (0x%2.2x)",
> +                               ext_telemetry_type, sub_opcode);
> +               tlv += 2 * sizeof(uint8_t);
> +       } else {
> +               print_text(COLOR_UNKNOWN_EXT_EVENT,
> +                       "  Unknown extended telemetry event (0x%2.2x 0x%2.2x)",
> +                       ext_telemetry_type, sub_opcode);
> +               packet_hexdump(data, size);
> +               return;
> +       }
> +
> +       /* Process every TLV subevent data.
> +        * The decoding process normally terminates when tlv == event_end.
> +        */
> +       while (tlv && tlv < event_end)
> +               tlv = process_ext_subevent(tlv, event_end);
> +
> +       /* If an error occrus in decoding the subevents, hexdump the packet. */

There is a typo above, it shall be: occurs.

> +       if (!tlv)
> +               packet_hexdump(data, size);
> +}
> diff --git a/monitor/vendor.h b/monitor/vendor.h
> index c70552b66..347b4bfe9 100644
> --- a/monitor/vendor.h
> +++ b/monitor/vendor.h
> @@ -30,4 +30,10 @@ struct vendor_evt {
>         bool evt_fixed;
>  };
>
> +struct vendor_ext_subevent {
> +       uint8_t subevent_id;
> +       uint8_t length;
> +       void (*func)(uint8_t subevent_id, const void *data, uint8_t size);
> +};
> +
>  void vendor_event(uint16_t manufacturer, const void *data, uint8_t size);
> --
> 2.32.0.288.g62a8d224e6-goog
>


-- 
Luiz Augusto von Dentz
