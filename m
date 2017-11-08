Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510140557.3313.7.camel@hadess.net>
Subject: Re: [PATCH 3/3] plugins/sixaxis: Provide DualShock 3 SDP record
 while adding new device
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Date: Wed, 08 Nov 2017 12:29:17 +0100
In-Reply-To: <20171107182356.15683-3-hadess@hadess.net>
References: <20171107182356.15683-1-hadess@hadess.net>
         <20171107182356.15683-3-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-11-07 at 19:23 +0100, Bastien Nocera wrote:
> From: Szymon Janc <szymon.janc@codecoup.pl>
> 
> This allows to skip SDP search for DualShock 3 devices. Since some
> DS3 clones were reported to not provide any SDP record this should
> allow to operate them.

As Szymon mentioned on IRC, this won't work as the SDP library will not
be accessible on an installed bluez (I only tested on an uninstalled
setup).

Furthermore, it's not valgrind clean[1].

The plan is to revive an old patch of mine which had the SDP record as
a binary blob, in the same format as bluez stores on disk. I just need
to figure out where it's disappeared.

[1]:
==9283== Invalid read of size 2
==9283==    at 0x4C365EF: memmove (vg_replace_strmem.c:1258)
==9283==    by 0x48165F: sdp_data_alloc_with_length (sdp.c:443)
==9283==    by 0x481E70: sdp_copy_seq (sdp.c:1552)
==9283==    by 0x481E70: sdp_data_value (sdp.c:1536)
==9283==    by 0x481E2A: sdp_copy_seq (sdp.c:1551)
==9283==    by 0x481E2A: sdp_data_value (sdp.c:1536)
==9283==    by 0x482EDA: sdp_copy_attrlist (sdp.c:1573)
==9283==    by 0x482EDA: sdp_list_foreach (sdp_lib.h:69)
==9283==    by 0x482EDA: sdp_copy_record (sdp.c:1591)
==9283==    by 0x475A1B: update_record (device.c:4356)
==9283==    by 0x475A1B: update_bredr_services (device.c:4444)
==9283==    by 0x4762AA: btd_device_set_record (device.c:6092)
==9283==    by 0x88019A1: agent_auth_cb (sixaxis.c:531)
==9283==    by 0x45A037: agent_auth_cb (adapter.c:6050)
==9283==    by 0x45877E: simple_agent_reply (agent.c:376)
==9283==    by 0x53AB601: ??? (in /usr/lib64/libdbus-1.so.3.19.2)
==9283==    by 0x53AEF7E: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.2)
==9283==    by 0x4862FF: message_dispatch (mainloop.c:72)
==9283==    by 0x50CB596: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x50CEBB6: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x50CEF5F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x50CF271: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x40BD98: main (main.c:770)
==9283==  Address 0x8dcdb04 is 148 bytes inside a block of size 149 alloc'd
==9283==    at 0x4C2FB6B: malloc (vg_replace_malloc.c:299)
==9283==    by 0x880B854: sdp_data_alloc_with_length (sdp.c:437)
==9283==    by 0x880BF8F: sdp_seq_alloc_with_length (sdp.c:526)
==9283==    by 0x880184B: get_sixaxis_sdp_record (sixaxis.c:211)
==9283==    by 0x880184B: agent_auth_cb (sixaxis.c:531)
==9283==    by 0x45A037: agent_auth_cb (adapter.c:6050)
==9283==    by 0x45877E: simple_agent_reply (agent.c:376)
==9283==    by 0x53AB601: ??? (in /usr/lib64/libdbus-1.so.3.19.2)
==9283==    by 0x53AEF7E: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.2)
==9283==    by 0x4862FF: message_dispatch (mainloop.c:72)
==9283==    by 0x50CB596: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x50CEBB6: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x50CEF5F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x50CF271: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.1)
==9283==    by 0x40BD98: main (main.c:770)

> ---
>  Makefile.plugins  |   1 +
>  plugins/sixaxis.c | 170
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 1f3b5b552..a1073d794 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -109,4 +109,5 @@ plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
>  plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
>  						-no-undefined
> @UDEV_LIBS@
>  plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
> @UDEV_CFLAGS@
> +plugins_sixaxis_la_LIBADD = lib/libbluetooth-internal.la
>  endif
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 9d0fdb5d3..3ce26793a 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -40,6 +40,8 @@
>  
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
> +#include "lib/sdp_lib.h"
> +#include "lib/sdp.h"
>  #include "lib/uuid.h"
>  
>  #include "src/adapter.h"
> @@ -85,6 +87,171 @@ static void auth_closure_destroy(struct
> authentication_closure *closure,
>  	g_free(closure);
>  }
>  
> +static sdp_record_t *get_sixaxis_sdp_record(void)
> +{
> +	sdp_record_t *record;
> +	uint16_t hid_release, hid_parser, version, timeout;
> +	uint8_t sdp_disable, battery, remote_wakeup, norm_connect,
> boot_device;
> +	uint8_t subclass, country, virtual_cable, reconnect;
> +	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> +	uuid_t root_uuid, hidkb_uuid, l2cap_uuid, hidp_uuid;
> +	sdp_profile_desc_t profile;
> +	sdp_list_t *aproto, *proto[3];
> +	sdp_data_t *psm, *lang_lst, *lang_lst2, *hid_spec_lst,
> *hid_spec_lst2;
> +	uint8_t dtd = SDP_UINT16;
> +	uint8_t dtd2 = SDP_UINT8;
> +	uint8_t dtd_data = SDP_TEXT_STR8;
> +	void *dtds[2];
> +	void *values[2];
> +	void *dtds2[2];
> +	void *values2[2];
> +	int leng[2];
> +	uint8_t hid_spec_type = 0x22;
> +	uint16_t hid_attr_lang[] = { 0x409, 0x100 };
> +	static const uint16_t ctrl = 0x11;
> +	static const uint16_t intr = 0x13;
> +	uint8_t hid_spec[] = {
> +		0x05, 0x01, 0x09, 0x04, 0xa1, 0x01, 0xa1, 0x02,
> 0x85, 0x01,
> +		0x75, 0x08, 0x95, 0x01, 0x15, 0x00, 0x26, 0xff,
> 0x00, 0x81,
> +		0x03, 0x75, 0x01, 0x95, 0x13, 0x15, 0x00, 0x25,
> 0x01, 0x35,
> +		0x00, 0x45, 0x01, 0x05, 0x09, 0x19, 0x01, 0x29,
> 0x13, 0x81,
> +		0x02, 0x75, 0x01, 0x95, 0x0d, 0x06, 0x00, 0xff,
> 0x81, 0x03,
> +		0x15, 0x00, 0x26, 0xff, 0x00, 0x05, 0x01, 0x09,
> 0x01, 0xa1,
> +		0x00, 0x75, 0x08, 0x95, 0x04, 0x35, 0x00, 0x46,
> 0xff, 0x00,
> +		0x09, 0x30, 0x09, 0x31, 0x09, 0x32, 0x09, 0x35,
> 0x81, 0x02,
> +		0xc0, 0x05, 0x01, 0x75, 0x08, 0x95, 0x27, 0x09,
> 0x01, 0x81,
> +		0x02, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0x91,
> 0x02, 0x75,
> +		0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0,
> 0xa1, 0x02,
> +		0x85, 0x02, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01,
> 0xb1, 0x02,
> +		0xc0, 0xa1, 0x02, 0x85, 0xee, 0x75, 0x08, 0x95,
> 0x30, 0x09,
> +		0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02, 0x85, 0xef,
> 0x75, 0x08,
> +		0x95, 0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xc0, 0x00
> +	};
> +
> +	record = sdp_record_alloc();
> +	if (!record)
> +		return NULL;
> +
> +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> +	root = sdp_list_append(0, &root_uuid);
> +	sdp_set_browse_groups(record, root);
> +
> +	sdp_add_lang_attr(record);
> +
> +	sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
> +	svclass_id = sdp_list_append(0, &hidkb_uuid);
> +	sdp_set_service_classes(record, svclass_id);
> +
> +	sdp_uuid16_create(&profile.uuid, HID_PROFILE_ID);
> +	profile.version = 0x0100;
> +	pfseq = sdp_list_append(0, &profile);
> +	sdp_set_profile_descs(record, pfseq);
> +
> +	/* protocols */
> +	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> +	proto[1] = sdp_list_append(0, &l2cap_uuid);
> +	psm = sdp_data_alloc(SDP_UINT16, &ctrl);
> +	proto[1] = sdp_list_append(proto[1], psm);
> +	apseq = sdp_list_append(0, proto[1]);
> +
> +	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
> +	proto[2] = sdp_list_append(0, &hidp_uuid);
> +	apseq = sdp_list_append(apseq, proto[2]);
> +
> +	aproto = sdp_list_append(0, apseq);
> +	sdp_set_access_protos(record, aproto);
> +
> +	/* additional protocols */
> +	proto[1] = sdp_list_append(0, &l2cap_uuid);
> +	psm = sdp_data_alloc(SDP_UINT16, &intr);
> +	proto[1] = sdp_list_append(proto[1], psm);
> +	apseq = sdp_list_append(0, proto[1]);
> +
> +	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
> +	proto[2] = sdp_list_append(0, &hidp_uuid);
> +	apseq = sdp_list_append(apseq, proto[2]);
> +
> +	aproto = sdp_list_append(0, apseq);
> +	sdp_set_add_access_protos(record, aproto);
> +
> +	sdp_set_info_attr(record, "Wireless Controller",
> +						"Sony Computer
> Entertainment",
> +						"Wireless
> Controller");
> +
> +	hid_release = 0x0100;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_DEVICE_RELEASE_NUMBER,
> SDP_UINT16,
> +								&hid
> _release);
> +
> +	hid_parser = 0x0100;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_PARSER_VERSION,
> SDP_UINT16,
> +								&hid
> _parser);
> +
> +	subclass = 0x00;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_DEVICE_SUBCLASS,
> SDP_UINT8,
> +								&sub
> class);
> +
> +	country = 0x21;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_COUNTRY_CODE,
> SDP_UINT8,
> +								&cou
> ntry);
> +
> +	virtual_cable = 0x01;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_VIRTUAL_CABLE,
> SDP_BOOL,
> +								&vir
> tual_cable);
> +
> +	reconnect = 0x01;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_RECONNECT_INITIATE,
> SDP_BOOL,
> +								&rec
> onnect);
> +
> +	dtds[0] = &dtd2;
> +	values[0] = &hid_spec_type;
> +	dtds[1] = &dtd_data;
> +	values[1] = hid_spec;
> +	leng[0] = 0;
> +	leng[1] = sizeof(hid_spec);
> +	hid_spec_lst = sdp_seq_alloc_with_length(dtds, values, leng,
> 2);
> +	hid_spec_lst2 = sdp_data_alloc(SDP_SEQ8, hid_spec_lst);
> +	sdp_attr_add(record, SDP_ATTR_HID_DESCRIPTOR_LIST,
> hid_spec_lst2);
> +
> +	dtds2[0] = &dtd;
> +	values2[0] = &hid_attr_lang[0];
> +	dtds2[1] = &dtd;
> +	values2[1] = &hid_attr_lang[1];
> +	lang_lst = sdp_seq_alloc(dtds2, values2,
> sizeof(hid_attr_lang) / 2);
> +	lang_lst2 = sdp_data_alloc(SDP_SEQ8, lang_lst);
> +	sdp_attr_add(record, SDP_ATTR_HID_LANG_ID_BASE_LIST,
> lang_lst2);
> +
> +	sdp_disable = 0x00;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_SDP_DISABLE, SDP_BOOL,
> +								&sdp
> _disable);
> +
> +	battery = 0x01;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_BATTERY_POWER,
> SDP_BOOL,
> +								&bat
> tery);
> +
> +	remote_wakeup = 0x01;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_REMOTE_WAKEUP,
> SDP_BOOL,
> +								&rem
> ote_wakeup);
> +
> +	version = 0x0100;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_PROFILE_VERSION,
> SDP_UINT16,
> +								&ver
> sion);
> +
> +	timeout = 0x3e80;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_SUPERVISION_TIMEOUT,
> SDP_UINT16,
> +								&tim
> eout);
> +
> +	norm_connect = 0x00;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_NORMALLY_CONNECTABLE,
> SDP_BOOL,
> +								&nor
> m_connect);
> +
> +	boot_device = 0x00;
> +	sdp_attr_add_new(record, SDP_ATTR_HID_BOOT_DEVICE, SDP_BOOL,
> +								&boo
> t_device);
> +
> +	return record;
> +}
> +
> +
>  static int sixaxis_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
>  {
>  	uint8_t buf[18];
> @@ -360,6 +527,9 @@ static void agent_auth_cb(DBusError *derr, void
> *user_data)
>  	btd_device_set_trusted(closure->device, true);
>  	btd_device_set_temporary(closure->device, false);
>  
> +	if (closure->type == CABLE_PAIRING_SIXAXIS)
> +		btd_device_set_record(closure->device, HID_UUID,
> get_sixaxis_sdp_record());
> +
>  	ba2str(&closure->bdaddr, device_addr);
>  	ba2str(&master_bdaddr, master_addr);
>  	ba2str(adapter_bdaddr, adapter_addr);
