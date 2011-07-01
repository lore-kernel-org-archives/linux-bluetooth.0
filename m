Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 1 Jul 2011 15:06:42 -0700
Message-ID: <BANLkTimAe6uRCdfM2_tNSf5j9mvnA_W4Qw@mail.gmail.com>
Subject: endless loop in client.c when read request is rejected
From: mike tsai <mikeyhtsai@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

 While running an IOP between blueZ and a LE device, I found that if
the LE device rejects the read_char_req with error_response
(insufficient Encryption), the following code will make the read_req
an endless loop,

	if (status == 0)
		characteristic_set_value(chr, pdu + 1, len - 1);
	else if (status == ATT_ECODE_INSUFF_ENC) {
		GIOChannel *io = g_attrib_get_channel(gatt->attrib);

		if (bt_io_set(io, BT_IO_L2CAP, NULL,
				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
				BT_IO_OPT_INVALID)) {

                        //End Less loop here
			gatt_read_char(gatt->attrib, chr->handle, 0,
					update_char_value, current);
			return;
		}
	}

   I am not sure what effect bt_io_set should have to improve the
security (bonding?), but the code simply has no effect in my
environment (with 2.6.39.1 kernel and latest bluez), therefore the
read_req, error_response will continue until link is disconnected.

Regards,

Mike
