Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Subject: Some thoughts about Enhanced Setup Synchronous Connection
Message-Id: <F55AC761-6CE8-4E32-8686-010441177D91@holtmann.org>
Date: Sat, 24 Jan 2015 13:59:47 -0800
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

there are few Bluetooth controllers that implement HCI support for Enhanced Setup Synchronous Connection and provide mSBC wideband speech encoding/decoding in the controller. It might make sense to start looking into adding support for this now.

A good first step might be to start using the new HCI commands, but keep all new values to default mapping so that nothing changes for the remote devices, but internally we have the capabilities to utilize this new controller feature.

The existing Setup Synchronous Connection command uses the following fields:

	struct bt_hci_cmd_setup_sync_conn {
		uint16_t handle;
		uint32_t tx_bandwidth;
		uint32_t rx_bandwidth;
		uint16_t max_latency;
		uint16_t voice_setting;
		uint8_t  retrans_effort;
		uint16_t pkt_type;
	} __attribute__ ((packed));

We are hardcoding the tx_bandwidth and rx_bandwidth to 0x00001f40, but I do not remember where that value came from actually.

For the voice_setting, we allow either BT_VOICE_TRANSPARENT (0x0003) or BT_VOICE_CVSD_16BT (0x0060) setting and depending on which is selected, the other values are chosen. They are based on settings from the HFP specification.

With BT_VOICE_CVSD_16BIT this decodes the following way:

        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD

And the BT_VOICE_TRANSPARENT decodes as this:

        Setting: 0x0003
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: Transparent Data

With the assumption that all other bits are ignored when Transparent Data is selected.

For the new Enhanced Setup Synchronous Connection command we have many extra fields:

	struct bt_hci_cmd_enhanced_setup_sync_conn {
		uint16_t handle;
		uint32_t tx_bandwidth;
		uint32_t rx_bandwidth;
		uint8_t  tx_coding_format[5];
		uint8_t  rx_coding_format[5];
		uint16_t tx_codec_frame_size;
		uint16_t rx_codec_frame_size;
		uint32_t input_bandwidth;
		uint32_t output_bandwidth;
		uint8_t  input_coding_format[5];
		uint8_t  output_coding_format[5];
		uint16_t input_coded_data_size;
		uint16_t output_coded_data_size;
		uint8_t  input_pcm_data_format;
		uint8_t  output_pcm_data_format;
		uint8_t  input_pcm_msb_position;
		uint8_t  output_pcm_msb_position;
		uint8_t  input_data_path;
		uint8_t  output_data_path;
		uint8_t  input_unit_size;
		uint8_t  output_unit_size;
		uint16_t max_latency;
		uint16_t pkt_type;
		uint8_t  retrans_effort;
	} __attribute__ ((packed));

To achieve proper compatibility with the existing command, the tx_bandwidth and rx_bandwidth will also both set to 0x00001f40.

The tx_coding_format and rx_coding_format should be either set to CVSD (0x02) or Transparent (0x03) since at the moment the mSBC encoding/decoding is done in the host.

For the tx_codec_frame_size and rx_codec_frame_size I have currently no idea what values are expected here for CVSD and which are expected from Transparent that carries mSBC payload.

The input_bandwidth and output_bandwidth are values we most likely have to pick. No idea which ones are useful at the moment.

For the input_coding_format and output_coding_format, I assume we have Linear PCM (0x04) when using CVSD and Transparent (0x03) when using Transparent for the air codec. In theory this could be both times PCM once we start selecting mSBC as air codec and the let the controller do the encoding/decoding. However the specifications mandates that for Transparent the tx_coding_format/rx_coding_format + input_coding_format/output_coding_format are the same.

The input_coded_data_size and output_coded_data_size is unclear as well. I assume that should be 16-bits to match this up with what previously was used from the voice_setting. At least when using CVSD as air codec and Linear PCM as input/output. It is a bit unclear to what to set this to for Transparent input/output. Currently I would assume that it is suppose to be 8-bits then or maybe the controller expects it to be set to 0x00.

For the input_pcm_data_format and output_pcm_data_format, the previous voice_setting uses 2's complement and with that that should be 0x02 then. It is only used when Linear PCM is selected and so for Transparent this would be set to 0x00.

The input_pcm_msb_position and output_pcm_msb_position should map to the MSB padding and with that should be set to 0x00 for Linear PCM input/output selection. For Transparent this should be ignored and also set to 0x00.

For input_data_path and output_data_path that would be set to HCI (0x00) and with that the input_unit_size and output_unit_size would also be set to 0x00.

And then max_latency, pkt_type and retrains_effort are the same as with the previous command.

In conclusion from what I can tell, only codec frame sizes and data sizes is something we should be filling in correctly. Otherwise we could start using the new commands. And the advantage would be that the host is now in control of selecting HCI as data path.

Regards

Marcel

