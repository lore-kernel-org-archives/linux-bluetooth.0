Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 8 May 2009 14:27:37 +0530
Message-ID: <c2a31c480905080157i3a5f15ffh767d03f951d01dc2@mail.gmail.com>
Subject: SCO Disconnect ,Connect
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 i have the following query.
a) (headset.c) headset_unlock
->headset_set_state(...HEADSET_CONNECTED),which in turn calls the
close_sco.
close_sco calls g_io_channel_shutdown().
I want to know whether g_io_channel_shutdown() triggers the sending of
HCI_Disconnect_Req(to remove SCO) to the LMP .
b) Also wanted to know,will the user mode BlueZ get an indication ,(if
so through which function),when the LMP sends a Disconnect Complete
Event to the Host.


I am asking the above as i see in the HCI dump, Disconnect &
Disconnect Complete messages, the issue i am facing is user mode BlueZ
calls close_sco & then calls headset_request_stream which again asks
for sco_connect(). Before the Disconnect Complete Evt is posted by
LMP. LMP reports Synchrnous Connection LImit to Device Exceeded(0X0A)
for the Synchrounous Setup Complete .

Snippet of hcidump is given below:
2009-05-08 13:43:47.540906 < HCI Command: Setup Synchronous Connection
(0x01|0x0028) plen 17
    handle 42 voice setting 0x0060
2009-05-08 13:43:47.545632 > SCO data: handle 50 flags 0x00 dlen 48
    0000: c1 fe ed fc f7 fb 4d fa  ed f8 28 f9 cf fa d1 fd  ......M...(.....
    0020: 05 03 71 00 c4 fd fe fc  77 fe 54 00 ef 01 8d 03  ..q.....w.T.....
2009-05-08 13:43:47.554646 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2009-05-08 13:43:47.554705 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 50 reason 0x13
    Reason: Remote User Terminated Connection
2009-05-08 13:43:47.565632 > SCO data: handle 50 flags 0x00 dlen 48
    0000: 3a 06 4b 07 a3 05 bc 01  e7 fe 48 ff 5f ff e7 fc  :.K.......H._...
    0020: 2b 00 aa 04 0e 09 b6 08  ce 03 92 fb 53 f5 fb f6  +...........S...
2009-05-08 13:43:47.566646 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 0
    0020: 62 fd e0 ff d3 00 e1 00  f3 01 eb 05 46 0a 42 0c  b...........F.B.
2009-05-08 13:43:47.597617 > HCI Event: Synchronous Connect Complete
(0x2c) plen 17
    status 0x0a handle 42 bdaddr 00:13:17:71:FD:88 type SCO
    Error: Synchronous Connection to a Device Exceeded
2009-05-08 13:43:47.605629 > SCO data: handle 50 flags 0x00 dlen 48
    0000: a7 0b 36 09 f4 05 0e 04  89 04 4e 04 ec 03 52 03  ..6.......N...R.
    0010: d6 00 85 fe 01 fd 08 fc  ad fb 6d fa 21 f8 3f f5  ..........m.!.?.
2009-05-08 13:43:47.607631 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2009-05-08 13:43:47.615616 > SCO data: handle 50 flags 0x00 dlen 48
    0000: 1f f7 44 f9 32 fb ed fc  bd fd d2 fe 32 01 19 04  ..D.2.......2...
    0020: 20 07 19 04 4b 02 bf 01  d7 00 d8 fd 77 fa 2a f9   ...K.......w.*.
2009-05-08 13:43:47.635626 > SCO data: handle 50 flags 0x00 dlen 48
    0000: e5 f8 e5 f8 e5 f8 e5 f8  e5 f8 e5 f8 e5 f8 e5 f8  ................
    0020: e5 f8 e5 f8 e5 f8 e5 f8  e5 f8 e5 f8 e5 f8 e5 f8  ................
2009-05-08 13:43:47.638651 > HCI Event: Disconn Complete (0x05) plen 4




Regards,
Sreevani M
