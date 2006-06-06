Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
Date: Tue, 6 Jun 2006 07:25:17 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] bug in sdp_gen_pd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

In sdp_gen_pd when handling SDP_TEXT_STR{8,16,32}, data_size is assumed to be
"d->unitSize - sizeof(uint8_t)". This is false.

In sdp_data_alloc_with_length, d->unitSize is defined to be
sizeof(unit8_t) + length + sizeof(uint8_t) if length <= UCHAR_MAX
or
sizeof(unit8_t) + length + sizeof(uint16_t) if length > UCHAR_MAX

The attached patch fixes sdp_gen_pdu to correctly compute data_size.

Another strange thing in sdp_data_alloc_with_length: after adjusting
unitSize, the dtd variable is changed from SDP_*_STR8 to SDP_*_STR16
or the other way around. But this code is dead, since the dtd variable
is no longer used in this function.

Best Regards,
Rafael


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
