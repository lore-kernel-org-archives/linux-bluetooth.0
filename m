Return-Path: <SRS0=BGse=6D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3791DC3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E43721D82
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587340181;
	bh=M3K0Z8H12CZbMmZt5UY5PKDgaFaeZCKSK9eagVbFAuE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=rE5Jif1HjTVT0hVbYG9aWgG1uSs4G4w+W/tuyTr5W10dZJDEs/IbO337qcv/a5uZl
	 cSl5WpYkylr2FEQNT8fw1/TFK40eTxm7RkbrczjdDquNouPEmkEI6PXoy9JuEMmGDu
	 mEfdeOT3PQTlvt+iJ/9/H7NLdhGlx30D2JlCYT7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDSXtk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Apr 2020 19:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgDSXtk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Apr 2020 19:49:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B44F212CC;
        Sun, 19 Apr 2020 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587340179;
        bh=M3K0Z8H12CZbMmZt5UY5PKDgaFaeZCKSK9eagVbFAuE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=WZDon6HiZNvrOY8tUuIqa4IqgWseK3audYu1B2Y6Sy1YEXJg3q0jH+juRWEwG1Rjp
         eRzg3tckBXYLDN0XCw11/DhP21CrgXyybpnVDp0ereKHgn2TGcC0vxXLA67nrEEWcP
         q5Cclp5eUXM7BpSxK7kJcHQXjju2m2MGEYWXZdw8=
Received: by pali.im (Postfix)
        id 32E1D1061; Mon, 20 Apr 2020 01:49:37 +0200 (CEST)
Date:   Mon, 20 Apr 2020 01:49:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     David Heidelberg <david@ixit.cz>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        luiz.dentz@gmail.com, pavel@ucw.cz
Subject: Bluetooth: Allow to use configure SCO socket codec parameters
Message-ID: <20200419234937.4zozkqgpt557m3o6@pali>
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219120940.1509224-1-david@ixit.cz>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I'm sending next attempt for userspace <--> kernel API for specifying
connection settings of SCO socket. I was thinking more about it and I
was able to remove some members from struct bt_voice_setup which are not
needed for Linux SCO sockets (e.g. specifying different routing then
over HCI).

Here is this API:

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fabee6db0abb..f1f482bdf526 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,6 +122,37 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+#define BT_VOICE_SETUP		14
+
+#define BT_VOICE_PKT_TYPE_CAP_SCO	BIT(0)
+#define BT_VOICE_PKT_TYPE_CAP_ESCO	BIT(1)
+struct bt_voice_pkt_type {
+	__u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
+	__u8 retrans_effort;
+	__u16 pkt_type;
+	__u16 max_latency;
+};
+struct bt_voice_setup {
+	__u32 tx_bandwidth;
+	__u32 rx_bandwidth;
+	__u16 tx_codec_frame_size;
+	__u16 rx_codec_frame_size;
+	__u8 tx_coding_format[5];
+	__u8 rx_coding_format[5];
+	__u8 input_coding_format[5];
+	__u8 output_coding_format[5];
+	__u16 input_coded_data_size;
+	__u16 output_coded_data_size;
+	__u8 input_pcm_data_format;
+	__u8 output_pcm_data_format;
+	__u8 input_pcm_msb_position;
+	__u8 output_pcm_msb_position;
+	__u32 input_bandwidth;
+	__u32 output_bandwidth;
+	__u32 pkt_types_count;
+	struct bt_voice_pkt_type pkt_types[];
+};
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)


Structure specify settings for exactly one codec.

Meaning of those members is same as for Enhanced Setup Synchronous
Connection HCI command.

Let me a bit explain it:

Members tx_bandwidth, rx_bandwidth, tx_codec_frame_size,
rx_codec_frame_size, tx_coding_format and rx_coding_format specify AIR
codec and all of them are needed to correctly describe codec used by
bluetooth adapter to transmit data over the air. All of these members
are also part of Enhanced Setup Synchronous Connection command and
application which want to use vendor codec needs to control of all them.

Members input_coding_format, output_coding_format,
input_coded_data_size, output_coded_data_size, input_bandwidth and
output_bandwidth describe LOCAL codec, format of audio data which is
passed by application to the bluetooth adapter. It does not have to be
same as AIR codec and in this case bluetooth adapter is doing HW
encoding/decoding.

When coding_format is PCM then additional parameters for PCM format
needs to be specified, more exactly they are in members:
input_pcm_data_format, output_pcm_data_format, input_pcm_msb_position
and output_pcm_msb_position.

For modern audio applications is is required to control all of these PCM
parameters as audio application does not have to reencode everything to
one format (e.g. 8Hz/s16le), but let bluetooth adapter to do reencoding
at HW level.

The last pkt_types[] array (with pkt_types_count items) defines what
type bluetooth packets and SCO/eSCO mode can be used with particular
codec.

So all members of that structure are needed for userspace audio
applications (e.g. pulseaudio) and without them it is not possible
implement custom vendor SCO codecs which are already used in bluetooth
headsets. Also without them it is not possible to use HW encoders in
bluetooth chip, e.g. mSBC and applications are forced to use in-software
encoding/decoding which may be slow or increase latency or power usage.

And here are some example how to use it:

SCO socket that would accept 16kHz PCM s16le data and bluetooth chip
would encode it to mSBC over the air.

  #define HCI_CODING_FORMAT_PCM 0x04
  #define HCI_CODING_FORMAT_MSBC 0x05
  #define HCI_PCM_DATA_FORMAT_2COMP 0x02
  static const struct bt_voice_setup voice_setup = {
    .tx_bandwidth = 8000,
    .rx_bandwidth = 8000,
    .tx_codec_frame_size = 60,
    .rx_codec_frame_size = 60,
    .tx_coding_format = { HCI_CODING_FORMAT_MSBC },
    .rx_coding_format = { HCI_CODING_FORMAT_MSBC },
    .input_coding_format = { HCI_CODING_FORMAT_PCM },
    .output_coding_format = { HCI_CODING_FORMAT_PCM },
    .input_coded_data_size = 16,
    .output_coded_data_size = 16,
    .input_pcm_data_format = HCI_PCM_DATA_FORMAT_2COMP,
    .output_pcm_data_format = HCI_PCM_DATA_FORMAT_2COMP,
    .input_pcm_msb_position = 0,
    .output_pcm_msb_position = 0,
    .input_bandwidth = 32000,
    .output_bandwidth = 32000,
    .pkt_types_count = 2,
    .pkt_types = {
      { BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d }, /* T2 */
      { BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, EDR_ESCO_MASK | ESCO_EV3,   0x0008 }, /* T1 */
    },
  };
  int fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
  bind(fd, ...);
  setsockopt(fd, SOL_BLUETOOTH, BT_VOICE_SETUP, &voice_setup, sizeof(voice_setup));
  connect(fd, ...);


SCO socket that would accept AuriStream codec from application and tell
bluetooth chip to pass-throu as is over the air:

  #define HCI_CODING_FORMAT_TRANSPARENT 0x03
  static const struct bt_voice_setup voice_setup = {
    .tx_bandwidth = 4000,
    .rx_bandwidth = 4000,
    .tx_codec_frame_size = 60,
    .rx_codec_frame_size = 60,
    .tx_coding_format = { HCI_CODING_FORMAT_TRANSPARENT },
    .rx_coding_format = { HCI_CODING_FORMAT_TRANSPARENT },
    .input_coding_format = { HCI_CODING_FORMAT_TRANSPARENT },
    .output_coding_format = { HCI_CODING_FORMAT_TRANSPARENT },
    .input_coded_data_size = 8,
    .output_coded_data_size = 8,
    .input_pcm_data_format = 0,
    .output_pcm_data_format = 0,
    .input_pcm_msb_position = 0,
    .output_pcm_msb_position = 0,
    .input_bandwidth = 4000,
    .output_bandwidth = 4000,
    .pkt_types_count = 1,
    .pkt_types = {
      { BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, 0x003F, 16 },
    },
  };
  int fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
  bind(fd, ...);
  setsockopt(fd, SOL_BLUETOOTH, BT_VOICE_SETUP, &voice_setup, sizeof(voice_setup));
  connect(fd, ...);


That API is designed for Enhanced Setup Synchronous Connection HCI
command, but can also be used by plain Setup Synchronous Connection HCI
command. Plain version has just reduced set of features and basically
instead of AIR codec members and LOCAL codec members use just one u16
member voice_setting, which is just subset of all those possible
Enhanced settings and can be generated from them. E.g. transparent
coding format is encoded in voice_setting as 0x0003, usage of CVSD HW
encoder from pcm_s16le_8kHz as 0x0060, but e.g. usage of mSBC HW encoder
is not possible to specify.

Please let me know what do you think about it. Thanks
