Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A3C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHGUDO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjHGUDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 16:03:13 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AEB1
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 13:03:10 -0700 (PDT)
Received: from github.com (hubbernetes-node-5a3d514.ash1-iad.github.net [10.56.151.23])
        by smtp.github.com (Postfix) with ESMTPA id EA5A4101228
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1691438590;
        bh=b1mKEM3BRHjT0kcEpO2I25tjjNKZBb3Dkol2WO3fQM0=;
        h=Date:From:To:Subject:From;
        b=VjBB8GtA19K/TYmGWgqzPRIXn+C/zePVhTM6MReEsqWnusIagrJaLJY0xL1CD8U3a
         meZFkp/aJVDDzGhluzVrLpv2nxO52HIo1KYCsgm3yq86MPm5sqOiR5tm8xPCaT32Dt
         llsB0jopRUZTc9XQzquJdl9Xjd1qs1FlZ+wpdvFU=
Date:   Mon, 07 Aug 2023 13:03:09 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d8ca06-966502@github.com>
Subject: [bluez/bluez] 06ec4f: shared/vcp: Fix the crash observed with VOCS
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 06ec4f61000aad92df33ff7d95df0594136797b6
      https://github.com/bluez/bluez/commit/06ec4f61000aad92df33ff7d95df0=
594136797b6
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-07-25 (Tue, 25 Jul 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix the crash observed with VOCS

Root cause
- There are two types of database- Remote and Local (rdb and ldb).
- In client mode currently the code was written to access ldb.

Fix
- Correcting it, to access rdb has resolved the problem in VOCS.
- Same correction is done for VCS.

Reported-by: Pauli Virtanen <pav@iki.fi>


  Commit: 2a0e392b40fae902ebf4d789a0456df020bbcc16
      https://github.com/bluez/bluez/commit/2a0e392b40fae902ebf4d789a0456=
df020bbcc16
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-07-25 (Tue, 25 Jul 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix issues of audio location and descriptor

Issues
- Audio output descriptor & location read functions requires code
correction.
- During reading audio location descriptor value was checked
instead of the pointer. DBG statement wrongly accessed value
to print the log that caused the crash.

Fix
- Corrected audio output descriptor read variable
- Corrected the audio location debug printing function
- Allocated the memory as a char pointer to the audio descriptor variable=
.
- Corrected the audio descriptor pointer checking condition


  Commit: 4d714becb7df1fd928340ffc5b9a759f9a625c47
      https://github.com/bluez/bluez/commit/4d714becb7df1fd928340ffc5b9a7=
59f9a625c47
  Author: Nitin Jadhav <nitin.jadhav@nxp.com>
  Date:   2023-07-25 (Tue, 25 Jul 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Reserve one more handle in VCS for VOCS

Fix: As per specs, VOCS is a secondary service;
hence it should be included under a primary service VCS.
The current number of handles is increased to accommodate the
included service


  Commit: c7276fa7cf3399affeb5fc0abe32d8884017e76b
      https://github.com/bluez/bluez/commit/c7276fa7cf3399affeb5fc0abe32d=
8884017e76b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-26 (Wed, 26 Jul 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix memory leaks

This fixes the following memory leaks on exit:

g32 bytes in 1 blocks are definitely lost in loss record 170 of 800
g   at 0x484182F: malloc (vg_replace_malloc.c:431)
g   by 0x47C942: util_malloc (util.c:46)
g   by 0x47AD6A: queue_new (queue.c:47)
g   by 0x379CB6: bap_data_new (bap.c:1565)
g   by 0x379E24: bap_probe (bap.c:1757)
g   by 0x4048F3: service_probe (service.c:153)
g   by 0x4190D5: probe_service (device.c:4817)
g   by 0x41927D: dev_probe (device.c:4836)
g   by 0x403918: btd_profile_foreach (profile.c:740)
g   by 0x421861: device_probe_profiles (device.c:4896)
g   by 0x3E5023: probe_devices (adapter.c:4590)
g   by 0x498022F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.7600.4)=

g
g64 bytes in 2 blocks are definitely lost in loss record 556 of 800
g   at 0x484182F: malloc (vg_replace_malloc.c:431)
g   by 0x47C942: util_malloc (util.c:46)
g   by 0x47AD6A: queue_new (queue.c:47)
g   by 0x379CB6: bap_data_new (bap.c:1565)
g   by 0x37DEA7: bap_adapter_probe (bap.c:1843)
g   by 0x3CDB51: probe_profile (adapter.c:5066)
g   by 0x403918: btd_profile_foreach (profile.c:740)
g   by 0x3F557E: adapter_register (adapter.c:9288)
g   by 0x3F557E: read_info_complete (adapter.c:10186)
g   by 0x480D91: request_complete (mgmt.c:306)
g   by 0x484466: can_read_data (mgmt.c:394)
g   by 0x4ED93F: watch_callback (io-glib.c:157)
g   by 0x496348B: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0=
.7600.4)


  Commit: 16c1166d8737d445f84c3a99b447f4c50e8f6d8b
      https://github.com/bluez/bluez/commit/16c1166d8737d445f84c3a99b447f=
4c50e8f6d8b
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix generating IRK for adapter with privacy enabled

When root folder for adapter doesn't exist we will get this runtime error=
:
src/adapter.c:generate_and_write_irk() Unable set contents for
 /var/lib/bluetooth/00:00:00:00:00:00/identity:
 (Failed to create file =E2=80=9C/var/lib/bluetooth/00:00:00:00:00:00/ide=
ntity.EKQ581=E2=80=9D:
 No such file or directory)


  Commit: 828bc564e6e84fc0499f2e3a99438240e4ff6de7
      https://github.com/bluez/bluez/commit/828bc564e6e84fc0499f2e3a99438=
240e4ff6de7
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix peripheral adverts when Discoverable =3D false

There is a problem with this configuration: Type =3D peripheral,
Discoverable =3D false and Adapter is discoverable

In this state device will start advertise discoverable advertisements
even when user wanted non-discoverable advertisements.

This change will add empty Flags when "Discoverable" parameter is set.


  Commit: cda5549f247554b788dbf23b17c36bfa9ab629be
      https://github.com/bluez/bluez/commit/cda5549f247554b788dbf23b17c36=
bfa9ab629be
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M doc/gatt-api.txt
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: Add read-only handles to dbus

This can be usefull when mapping names for services and characteristics
to their handle numbers.


  Commit: ac04b56c41fea0f17f8862e1b8197514224b757a
      https://github.com/bluez/bluez/commit/ac04b56c41fea0f17f8862e1b8197=
514224b757a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Use gnuplot to plot graph of Latency-Packets

This make use of gnuplot when using -a/--analyze to plot a graph of
Latency-Packets:

  Found BR-ACL connection with handle 256
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Product=
s Inc)
        60 RX packets
        22548 TX packets
        22547 TX completed packets
        3 msec min latency
        73 msec max latency
        11 msec median latency
        6 octets TX min packet size
        850 octets TX max packet size
        847 octets TX median packet size

  10000 +-+--------------------------------------------------------------=
--+
         +|      ++                                                      =
  |
         +|      ||+                                       Packets +-----=
+ |
         +|      |||                                                     =
  |
   1000 +-|      |||++                                                   =
  |
         +|      |||||  +                                                =
  |
         +|      |||||++|                                                =
  |
         +|      ||||||||+++                                             =
  |
    100 +-|      |||||||||||  +                                          =
  |
         +|      |||||||||||+++  +                                       =
  |
         +|      ||||||||||||||  |                                       =
  |
         +| ++   ||||||||||||||++|+                                      =
  |
          | ||   |||||||||||||||||++                                     =
  |
     10 +-| ||   |||||||||||||||||||+                                    =
  |
         +| ||   ||||||||||||||||||||  +                                 =
  |
         +| || ++||||||||||||||||||||++|++++       +                     =
  |
          | || |||||||||||||||||||||||||||||       |                     =
  |
      1 +-| ||+||||||||||||||||||||||||||||| +  +  |                 +   =
  |
         ++--------------------------------------------------------------=
--+
          +       +       +       +        +       +       +       +     =
  +
          0       10      20      30       40      50      60      70    =
  80
                                    Latency (ms)


  Commit: 9a657dcec988ff84e7e08345ea6512538a1b3207
      https://github.com/bluez/bluez/commit/9a657dcec988ff84e7e08345ea651=
2538a1b3207
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/btmon.rst
    M monitor/main.c

  Log Message:
  -----------
  monitor: Update documentation

This updates the documentation to mention gnuplot usage.


  Commit: 5d090ddc6aa6288e66f5624ed3e2e301cb39a44c
      https://github.com/bluez/bluez/commit/5d090ddc6aa6288e66f5624ed3e2e=
301cb39a44c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/analyze.c
    M monitor/l2cap.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Consolidate code around latency calculation

This move latency calculations to a helper function called
packet_latency_add so it can get reused by the likes of l2cap.c and
analyze.c


  Commit: 77fb0ab5287c0cb2be2a3cfea00260eb0e649443
      https://github.com/bluez/bluez/commit/77fb0ab5287c0cb2be2a3cfea0026=
0eb0e649443
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix not dequeing TX packet properly

num_completed_packets_evt contain a count for how many packets have been
completed per handle.


  Commit: f150939419d3854205d760d994c5b4397e5b524f
      https://github.com/bluez/bluez/commit/f150939419d3854205d760d994c5b=
4397e5b524f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix not calculating latency for ISO/SCO packets

ISO/SCO packets latency was not being calculated because no connection
was assigned to them.


  Commit: b4cf0900d05c5fbd369f7f0c301c3917ca5b20a8
      https://github.com/bluez/bluez/commit/b4cf0900d05c5fbd369f7f0c301c3=
917ca5b20a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Fix not dequeing TX packet properly

num_completed_packets_evt contain a count for how many packets have been
completed per handle.


  Commit: dce3971d227de4fe7f4d2e4349d0153008782296
      https://github.com/bluez/bluez/commit/dce3971d227de4fe7f4d2e4349d01=
53008782296
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-28 (Fri, 28 Jul 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Fix not calculating latency for ISO/SCO packets

ISO/SCO packets latency was not being calculated because no connection wa=
s
being assigned to them.


  Commit: caf7db313e9dbb23365769c5384bd352f697f406
      https://github.com/bluez/bluez/commit/caf7db313e9dbb23365769c5384bd=
352f697f406
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Be able to use ConnectDevice for discovered devices

This can be useful when you want to specify trasport type for already
paired device (e.g. use LE transport for dual mode device).


  Commit: 255ef572ca76db8d7fa8450653dce99c170c406a
      https://github.com/bluez/bluez/commit/255ef572ca76db8d7fa8450653dce=
99c170c406a
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M doc/adapter-api.txt

  Log Message:
  -----------
  adapter: Update ConnectDevice documentation


  Commit: 446d8ada5790e5ca2cdc359eafa4bf7136b43ac5
      https://github.com/bluez/bluez/commit/446d8ada5790e5ca2cdc359eafa4b=
f7136b43ac5
  Author: Zijun Hu <quic_zijuhu@quicinc.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix integer configuration option parse failures

parse_config_int() has a obvious logical error, so causes many
parse failures of integer configuration options, fixed by this
change.


  Commit: 1dbd9ba1f19542ba6398aa662caaf5a5eaf659b2
      https://github.com/bluez/bluez/commit/1dbd9ba1f19542ba6398aa662caaf=
5a5eaf659b2
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M client/player.c
    M lib/uuid.h
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  Rename BAA_SERVICE to BCAA_SERVICE add BAA_SERVICE(0x1851)

Rename BAA_SERVICE to BCAA_SERVICE and added BAA_SERVICE(0x1851)
as UUID for the broadcast sink.


  Commit: 86a4015659e3ed25bcae01a0ca1c0ba5d655131f
      https://github.com/bluez/bluez/commit/86a4015659e3ed25bcae01a0ca1c0=
ba5d655131f
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix decoding Command Complete for Remove ISO Data path

Before

< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3
        Connection Handle: 96
        Data Path Direction: Output (Controller to Host) (0x01)
> HCI Event: Command Complete (0x0e) plen 6
      LE Remove Isochronous Data Path (0x08|0x006f) ncmd 1
        invalid packet size
        00 60 00

After patch

< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3
        Connection Handle: 96
        Data Path Direction: 0x01
          Input (Host to Controller)
> HCI Event: Command Complete (0x0e) plen 6
      LE Remove Isochronous Data Path (0x08|0x006f) ncmd 1
        Status: Success (0x00)
        Connection handle: 96


  Commit: 7c6e030ac976b3d746edce9a1e36d7dc9696edcb
      https://github.com/bluez/bluez/commit/7c6e030ac976b3d746edce9a1e36d=
7dc9696edcb
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Update le event mask with bits 20-23


  Commit: af3549724b0ab3103e8379e5a2e0e653f5f31a99
      https://github.com/bluez/bluez/commit/af3549724b0ab3103e8379e5a2e0e=
653f5f31a99
  Author: Szymon Czapracki <szymon.czapracki@codecoup.pl>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/bt.h
    M monitor/ll.c

  Log Message:
  -----------
  monitor/ll: Add support for connection parameter command.

LL_CONNECTION_PARAM_REQ (0x0f)
  Interval min: 7.50 msec (0x0006)
  Interval max: 7.50 msec (0x0006)
  Latency: 0 (0x0000)
  Timeout: 5000 msec (0x01f4)
  Preffered periodicity: 0.00 (0x00)
  Reference connection event count: 4 (0x04)
  Offset 0: 0.00 msec (0x00)
  Offset 1: 0.00 msec (0x00)
  Offset 2: 1.25 msec (0x01)
  Offset 3: 0.00 msec (0x00)
  Offset 4: 2.50 msec (0x02)
  Offset 5: 0.00 msec (0x00)

LL_CONNECTION_PARAM_RSP (0x10)
  Interval min: 7.50 msec (0x0006)
  Interval max: 7.50 msec (0x0006)
  Latency: 0 (0x0000)
  Timeout: 5000 msec (0x01f4)
  Preffered periodicity: 0.00 (0x00)
  Reference connection event count: 4 (0x04)
  Offset 0: 318.75 msec (0xff)
  Offset 1: 318.75 msec (0xff)
  Offset 2: 318.75 msec (0xff)
  Offset 3: 318.75 msec (0xff)
  Offset 4: 318.75 msec (0xff)
  Offset 5: 318.75 msec (0xff)


  Commit: 652e8b8dd309a5604fe7f565d9face088028432e
      https://github.com/bluez/bluez/commit/652e8b8dd309a5604fe7f565d9fac=
e088028432e
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support to decode le read ISO link quality

btmon: Add parsing LE Read ISO link quality

    > HCI Event: Command Complete (0x0e) plen 34
          LE Read ISO link quality (0x08|0x0075) ncmd 1
            Status: Success (0x00)
            Handle: 98
            TX unacked packets 0
            TX flushed packets 257602
            TX last subevent packets 0
            TX retrnansmitted packets 0
            TX crc error packets 2594
            RX unreceived packets 0
            Duplicated packets 0


  Commit: 8d60b555e8e18992348662a6d232cba9d19178aa
      https://github.com/bluez/bluez/commit/8d60b555e8e18992348662a6d232c=
ba9d19178aa
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add parsing Service Data of UUID 128

In the advertising report, instead of deciding EIR 0x21 into this:

	Unknown EIR field 0x21: 3a048f2ba97ea6ae1b49c619e973a4a701480d130d

We can do bit better

        Service Data UUID 128: Vendor specific
          Data: 01480d130d
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


  Commit: 8eb1dee87e019f29b6c8233dfe0f9aef8ee44461
      https://github.com/bluez/bluez/commit/8eb1dee87e019f29b6c8233dfe0f9=
aef8ee44461
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Fix not establishing a socket for each device

AcquireWrite and AcquireNotify shall establish a socket pair for each
device connected otherwise the application cannot distinct the
operations of each client.

Fixes: https://github.com/bluez/bluez/issues/460


  Commit: 604633556d7a93e9f16df965c979e7ed9ce0b14f
      https://github.com/bluez/bluez/commit/604633556d7a93e9f16df965c979e=
7ed9ce0b14f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add TX frame number and speed estimation

This adds the frame information while decoding:

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256 Address: XX:XX:XX:XX:XX:XX
        Count: 1
        #188: len 850 (755 Kb/s)
        Latency: 9 msec (3-21 msec ~6 msec)
        Channel: 68 [PSM 25 mode Basic (0x00)] {chan 4}
        Channel Latency: 9 msec (7-21 msec ~9 msec)

Or the speed estimation while analyzing:

  Found BR-ACL connection with handle 256
        Address: XX:XX:XX:XX:XX:XX
        60 RX packets
        22548 TX packets
        22547 TX completed packets
        3-73 msec (~11 msec) TX Latency
        6-850 octets (~847 octets) TX packet size
        ~568 Kb/s TX transfer speed


  Commit: 54740308b52e288d34b928ef61156a33e3371991
      https://github.com/bluez/bluez/commit/54740308b52e288d34b928ef61156=
a33e3371991
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Use conn_pkt_tx on acl_pkt

This makes use of conn_pkt_tx also on acl_pkt like other connections.


  Commit: 6bb476800fe8ada6589a1ff9154d3bf5e745c27f
      https://github.com/bluez/bluez/commit/6bb476800fe8ada6589a1ff9154d3=
bf5e745c27f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-07-31 (Mon, 31 Jul 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Print channel latency information with -a/--analyze

This prints channel latency information and use gnuplot when using
-a/--analyze to plot a graph of channels:

  Found TX L2CAP channel with CID 68
        PSM 25
        22490 packets
        7-50 msec (~11 msec) TX Latency
        850-850 octets TX packet size
        ~569 Kb/s TX transfer speed

  10000 +-+--------------------------------------------------------------=
--+
         +|     ++                                                       =
  |
         +|     || +                                       Packets +-----=
+ |
         +|   + || |                                                     =
  |
   1000 +-|   | || |+ ++                                                 =
  |
         +|   | || || ||   +                                             =
  |
         +|   | || || ||+ +|                                             =
  |
         +|   | || || ||| || ++ ++                                       =
  |
    100 +-|   | || || ||| || || ||   +                                   =
  |
         +|   | || || ||| || || || ++| +   +                             =
  |
         +|   | || || ||| || || || ||| |   |                             =
  |
         +|   | || || ||| || || || ||| |+ +| +                           =
  |
          |   | || || ||| || || || ||| || || |+ +                        =
  |
     10 +-|   | || || ||| || || || ||| || || || |+                       =
  |
         +|   | || || ||| || || || ||| || || || ||     +                 =
  |
         +|  +| || || ||| || || || ||| || || || ||+ ++ |+ ++ +           =
  |
          |  || || || ||| || || || ||| || || || ||| || || || |           =
  |
      1 +-|  || || || ||| || || || ||| || || || ||| || || || |   +     + =
  |
         ++--------------------------------------------------------------=
--+
          +      +      +       +      +      +      +       +      +    =
  +
          5      10     15      20     25     30     35      40     45   =
  50
                                    Latency (ms)


  Commit: 1f6e606c8504270da56a0888fa729866e82eebb8
      https://github.com/bluez/bluez/commit/1f6e606c8504270da56a0888fa729=
866e82eebb8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-01 (Tue, 01 Aug 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Add connection tracking for SCO/ISO with -a/--analyze

This adds proper connection tracking to SCO/ISO connection by handling
the events that establishes them.


  Commit: 80107630396d3d3a3984c599e0cb9b015be0499c
      https://github.com/bluez/bluez/commit/80107630396d3d3a3984c599e0cb9=
b015be0499c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-01 (Tue, 01 Aug 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Inline data to gnuplot

Instead of creating a separate file just to write the x:y axis inline
the data via gnuplot $data variable then use it to plot.


  Commit: 5815a92423c3d074e26974f4ca5de0cc4b596845
      https://github.com/bluez/bluez/commit/5815a92423c3d074e26974f4ca5de=
0cc4b596845
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-02 (Wed, 02 Aug 2023)

  Changed paths:
    M emulator/btdev.c
    M monitor/bt.h

  Log Message:
  -----------
  btdev: check error conditions for HCI_Create_Connection_Cancel

Create Connection Cancel shall return Command Complete with error status
when there is no Create Connection that can be canceled.  In these
cases, we should not send a (spurious) Connection Complete event.

Fix by keeping a list of pending Create Connection commands, and
returning command errors if there is none pending at the moment.


  Commit: 23a7d4003064761e225394a42253d51dd5e81093
      https://github.com/bluez/bluez/commit/23a7d4003064761e225394a42253d=
51dd5e81093
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-02 (Wed, 02 Aug 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: fix Command Status command opcodes for Setup Sync Conn

The command opcode should be the CMD, not EVT.


  Commit: 80c8266ae20ae6bf6d468d0b32d9ebffc1f4d400
      https://github.com/bluez/bluez/commit/80c8266ae20ae6bf6d468d0b32d9e=
bffc1f4d400
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-02 (Wed, 02 Aug 2023)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: test local and remote disconnecting simultaneously

Demonstrate a kernel race condition when remote side disconnects at the
same time as local side tries to cancel the connection. I.e.

	[controller] > HCI Synchronous Connect Complete
	[controller] > HCI Disconnection Complete (from remote)
	[user] shutdown(sco_socket)
	[kernel] hci_conn_abort(SCO handle)
	[kernel] > HCI Create Connection Cancel
	[kernel] < HCI Synchronous Connect Complete
	[kernel] < HCI Disconnect Complete
	[controller] < HCI Create Connection Cancel
	[controller] > HCI Command Status (Create Connection Cancel)
	[kernel] < HCI Command Status (Create Connection Cancel)

and then we get BUG: KASAN: slab-use-after-free in hci_conn_failed when
hci_conn_abort tries to delete the same connection a second time.

This type of crash is probably not limited to the sequence here, but for
this one it was possible to get the timing right in the emulator.

Add a test that hits this in the emulator environment (pretty narrow
window to hit on real hardware):

eSCO Simultaneous Disconnect - Failure


  Commit: 10d83e3423bb3cc59fc0b5cb680c466b8658edfa
      https://github.com/bluez/bluez/commit/10d83e3423bb3cc59fc0b5cb680c4=
66b8658edfa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-02 (Wed, 02 Aug 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID

Add test with a large CIS_ID and multiple CIS so it hits an error
condition in current kernels (which is why the AC configuration is
used).

Add tests for invalid configurations with bad or duplicate IDs, and for
trying to connect two CIS in same CIG without BT_DEFER_SETUP.

ISO QoS CIG 0xF0 - Invalid
ISO QoS CIS 0xF0 - Invalid
ISO Connect2 CIG 0x01 - Success/Invalid
ISO AC 6(ii) CIS 0xEF/auto - Success
ISO AC 6(ii) CIS 0xEF/0xEF - Invalid


  Commit: 033b68cbb1bf73b1bb9d26f5ffac35b6dc0afab8
      https://github.com/bluez/bluez/commit/033b68cbb1bf73b1bb9d26f5ffac3=
5b6dc0afab8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-02 (Wed, 02 Aug 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: add tests checking Remove CIG is emitted

Kernel should send LE Remove CIG after all CIS are shut down.  Add tests
checking this, closing either immediately or after waiting connection to
complete.

ISO Defer Close - Success
ISO Connect Close - Success
ISO Defer Wait Close - Success
ISO Connect Wait Close - Success


  Commit: 9665025cc042db2ba2d3b95ff8f0794c9826311d
      https://github.com/bluez/bluez/commit/9665025cc042db2ba2d3b95ff8f07=
94c9826311d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-04 (Fri, 04 Aug 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix test ISO Connect2 CIG 0x01 - Success/Invalid

This test shall succeed rather than fail as this appears to be a bug in
the kernel code preventing Set CIG Parameters to work properly when
there are concurrent tasks only one CIS is being programmed.


Compare: https://github.com/bluez/bluez/compare/d8ca06631b74...9665025cc0=
42
