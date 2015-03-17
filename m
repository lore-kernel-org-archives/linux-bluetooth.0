Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5506E715.3000709@ubnt.com>
References: <54F752D8.1000605@ubnt.com>
	<CAHrH25RVKCL9RQCeFBJAsUsNV1umOR92VWV1JQgkwy-RNh-GAg@mail.gmail.com>
	<CAN_7+Yagp-R+H+nhCtmdqWyAJm4jO_VsB5c343A=39zurwqpPw@mail.gmail.com>
	<007858C7-D538-407D-8212-D3B0CB880165@ubnt.com>
	<CABBYNZLKfh7xPufAMfjG6P--Q-NkOVq4oYUdXEpqc5WsvQpu2g@mail.gmail.com>
	<CABBYNZLHtCJCoUp_4miapZJOReh=FP4_sJVFkyh5uE+NHV2x=A@mail.gmail.com>
	<5506D8AB.1040903@ubnt.com>
	<5506E0A6.1080709@ubnt.com>
	<CABBYNZKg1gMsoZyD4mHiZDiGkvFuzAcTPGauFTaLRr0V7ntkbg@mail.gmail.com>
	<5506E715.3000709@ubnt.com>
Date: Tue, 17 Mar 2015 15:07:28 +0200
Message-ID: <CABBYNZJK7SVUbThK_wfVFa2NvxK5NiFJ4HRA-FK3Pmo9+peYZw@mail.gmail.com>
Subject: Re: Non-consecutive handle values in GATT
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,


>>>> ACL data: handle 64 flags 0x02 dlen 20
>>>     ATT: Read By Type resp (0x09)
>>>       length: 7
>>>         handle 0x0110, value 0x02 0x11 0x01 0x00 0x2a
>>>         handle 0x0120, value 0x02 0x21 0x01 0x01 0x2a
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0121, end 0x0121
>>>       type-uuid 0x2803      <--- as without patch, this seems to be suspicious. Single att read request with wrong UUID.
>>
>> Maybe this is off by 1 error except if start 0x0100, end 0x0121 range
>> actually exclude the last, but it would be still wrong the start
>> 0x0121, end 0x0121, anyway this seems to be some other problem.

Actually this is fine, we are discovering the characteristics since
they may not fit in a single frame we just continue from where we stop
at 0x0121 until the end of the service range with just happen to be
0x0121.

>>
>>>
>>>
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 2
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Type req (0x08) on handle 0x0121
>>> < ACL data: handle 64 flags 0x00 dlen 9
>>>     ATT: Find Information req (0x04)
>>>       start 0x0112, end 0x011f
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Find Information req (0x04) on handle 0x0112
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0300, end 0x0320
>>>       type-uuid 0x2803
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 1
>>>> ACL data: handle 64 flags 0x02 dlen 27
>>>     ATT: Read By Type resp (0x09)
>>>       length: 21
>>>         handle 0x0310, value 0x3e 0x11 0x03 0x34 0x5b 0xe2 0x12 0x5e 0xb1 0x45 0x03 0xb6 0x29 0x24 0x55 0x8a 0x11 0x1e 0x36
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0311, end 0x0320
>>>       type-uuid 0x2803
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 2
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Type req (0x08) on handle 0x0311
>>
>> Can you collect the trace in binary format, e.g. btmon -w <file>, I
>> can perhaps try to create the very same database for unit tests, also
>> it would be good to have bluetoothd traces.
> Traces attached.

Can you please enable bt_gatt_client debug with the following patch:

diff --git a/src/device.c b/src/device.c
index aaa9f43..6a23adc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3989,6 +3989,11 @@ static void
gatt_client_service_changed(uint16_t start_handle,
        DBG("start 0x%04x, end: 0x%04x", start_handle, end_handle);
 }

+static void gatt_debug(const char *str, void *user_data)
+{
+       DBG("%s", str);
+}
+
 static void gatt_client_init(struct btd_device *device)
 {
        gatt_client_cleanup(device);
@@ -4000,6 +4005,8 @@ static void gatt_client_init(struct btd_device *device)
                return;
        }

+       bt_gatt_client_set_debug(device->client, gatt_debug, NULL, NULL);
+
        /* Notify attio so it can react to notifications */
        g_slist_foreach(device->attios, attio_connected, device->attrib);


-- 
Luiz Augusto von Dentz
