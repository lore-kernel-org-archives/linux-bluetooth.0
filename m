Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
 <1417423638-29222-8-git-send-email-luiz.dentz@gmail.com>
 <003a01d00d60$d0424590$70c6d0b0$@samsung.com>
 <CABBYNZKbrdPPEXbFK34a5Hp_Rf3K2N9vzBwXjuafhxNDUB2Zrg@mail.gmail.com>
 <003b01d00d6b$3723cfe0$a56b6fa0$@samsung.com>
 <CABBYNZJ=uY6_C_4n2B6Os4E5N9WYcO42+_9cXST0nfL3cwN52w@mail.gmail.com>
 <CABBYNZKB_E7AZfDTV3TF30J-gXCV-5E1dBbLvjtnQPyG0gdggw@mail.gmail.com>
 <003c01d00d71$f818ba20$e84a2e60$@samsung.com>
 <CABBYNZJCAkQtEt7F0PEPQ7aaQXqXf9qG9eA63BYeXbboXNUonw@mail.gmail.com>
In-reply-to: <CABBYNZJCAkQtEt7F0PEPQ7aaQXqXf9qG9eA63BYeXbboXNUonw@mail.gmail.com>
Subject: RE: [PATCH BlueZ 8/8] obexd/client: Add supported_features support
Date: Tue, 02 Dec 2014 12:07:38 +0530
Message-id: <000901d00dfa$7cb387f0$761a97d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, December 01, 2014 8:12 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH BlueZ 8/8] obexd/client: Add supported_features
> support
> 
> Hi Gowtham,
> 
> On Mon, Dec 1, 2014 at 4:19 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi Luiz,
> >
> >> -----Original Message-----
> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> >> Sent: Monday, December 01, 2014 7:30 PM
> >> To: Gowtham Anandha Babu
> >> Cc: linux-bluetooth@vger.kernel.org
> >> Subject: Re: [PATCH BlueZ 8/8] obexd/client: Add supported_features
> >> support
> >>
> >> Hi Gowtham,
> >>
> >> On Mon, Dec 1, 2014 at 3:34 PM, Luiz Augusto von Dentz
> >> <luiz.dentz@gmail.com> wrote:
> >> > Hi Gowtham,
> >> >
> >> > On Mon, Dec 1, 2014 at 3:31 PM, Gowtham Anandha Babu
> >> > <gowtham.ab@samsung.com> wrote:
> >> >> Hi Luiz,
> >> >>
> >> >>> -----Original Message-----
> >> >>> From: linux-bluetooth-owner@vger.kernel.org
> >> >>> [mailto:linux-bluetooth- owner@vger.kernel.org] On Behalf Of Luiz
> >> >>> Augusto von Dentz
> >> >>> Sent: Monday, December 01, 2014 6:22 PM
> >> >>> To: Gowtham Anandha Babu
> >> >>> Cc: linux-bluetooth@vger.kernel.org
> >> >>> Subject: Re: [PATCH BlueZ 8/8] obexd/client: Add
> >> >>> supported_features support
> >> >>>
> >> >>> Hi Gowtham,
> >> >>>
> >> >>> On Mon, Dec 1, 2014 at 2:17 PM, Gowtham Anandha Babu
> >> >>> <gowtham.ab@samsung.com> wrote:
> >> >>> > Hi Luiz,
> >> >>> >
> >> >>> >> -----Original Message-----
> >> >>> >> From: linux-bluetooth-owner@vger.kernel.org
> >> >>> >> [mailto:linux-bluetooth- owner@vger.kernel.org] On Behalf Of
> >> >>> >> Luiz Augusto von Dentz
> >> >>> >> Sent: Monday, December 01, 2014 2:17 PM
> >> >>> >> To: linux-bluetooth@vger.kernel.org
> >> >>> >> Subject: [PATCH BlueZ 8/8] obexd/client: Add
> >> >>> >> supported_features support
> >> >>> >>
> >> >>> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> >>> >>
> >> >>> >> This adds supported_features support to obc_driver so driver
> >> >>> >> can provide this information when connecting.
> >> >>> >>
> >> >>> >> This is required by PBAP 1.2 (page 48):
> >> >>> >>
> >> >>> >>   'Mandatory if the PSE advertises a PbapSupportedFeatures
> >> >>> >> attribute
> >> in
> >> >>> >>    its SDP record, else excluded.'
> >> >>> >> ---
> >> >>> >>  obexd/client/driver.h  |  1 +
> >> >>> >>  obexd/client/pbap.c    | 36
> >> >>> ++++++++++++++++++++++++++++++++++++
> >> >>> >>  obexd/client/session.c | 25 ++++++++++++++++++++++++-
> >> >>> >>  3 files changed, 61 insertions(+), 1 deletion(-)
> >> >>> >>
> >> >>> >> diff --git a/obexd/client/driver.h b/obexd/client/driver.h
> >> >>> >> index
> >> >>> >> f1c0646..0112219 100644
> >> >>> >> --- a/obexd/client/driver.h
> >> >>> >> +++ b/obexd/client/driver.h
> >> >>> >> @@ -26,6 +26,7 @@ struct obc_driver {
> >> >>> >>       const char *uuid;
> >> >>> >>       void *target;
> >> >>> >>       gsize target_len;
> >> >>> >> +     void *(*supported_features) (struct obc_session
> >> >>> >> + *session);
> >> >>> >>       int (*probe) (struct obc_session *session);
> >> >>> >>       void (*remove) (struct obc_session *session);  }; diff
> >> >>> >> --git a/obexd/client/pbap.c b/obexd/client/pbap.c index
> >> >>> >> 812a7fb..57632b4
> >> >>> >> 100644
> >> >>> >> --- a/obexd/client/pbap.c
> >> >>> >> +++ b/obexd/client/pbap.c
> >> >>> >> @@ -76,6 +76,7 @@
> >> >>> >>  #define PRIMARY_COUNTER_TAG  0X0A
> >> >>> >>  #define SECONDARY_COUNTER_TAG        0X0B
> >> >>> >>  #define DATABASEID_TAG               0X0D
> >> >>> >> +#define SUPPORTED_FEATURES_TAG  0x10
> >> >>> >>
> >> >>> >>  #define DOWNLOAD_FEATURE     0x00000001
> >> >>> >>  #define BROWSE_FEATURE               0x00000002
> >> >>> >> @@ -1230,6 +1231,40 @@ static void parse_service_record(struct
> >> >>> >> pbap_data
> >> >>> >> *pbap)
> >> >>> >>
> >> >>> >>  }
> >> >>> >>
> >> >>> >> +static void *pbap_supported_features(struct obc_session
> >> >>> >> +*session)
> >> {
> >> >>> >> +     const void *data;
> >> >>> >> +     uint16_t version;
> >> >>> >> +
> >> >>> >> +     /* Version */
> >> >>> >> +     data = obc_session_get_attribute(session,
> >> >>> >> SDP_ATTR_PFILE_DESC_LIST);
> >> >>> >> +     if (!data)
> >> >>> >> +             return NULL;
> >> >>> >> +
> >> >>> >> +     version = GPOINTER_TO_UINT(data);
> >> >>> >> +
> >> >>> >> +     if (version < 0x0102)
> >> >>> >> +             return NULL;
> >> >>> >> +
> >> >>> >> +     /* Supported Feature Bits */
> >> >>> >> +     data = obc_session_get_attribute(session,
> >> >>> >> +
> >> >>> >>       SDP_ATTR_PBAP_SUPPORTED_FEATURES);
> >> >>> >> +     if (!data)
> >> >>> >> +             return NULL;
> >> >>> >> +
> >> >>> >> +     return g_obex_apparam_set_uint32(NULL,
> >> >>> >> SUPPORTED_FEATURES_TAG,
> >> >>> >> +                                             DOWNLOAD_FEATURE |
> >> >>> >> +                                             BROWSE_FEATURE |
> >> >>> >> +
> >> >>> >> + DATABASEID_FEATURE |
> >> >>> >> +
> >> >>> >> + FOLDER_VERSION_FEATURE
> >> >>> >> |
> >> >>> >> +
> >> >>> >> + VCARD_SELECTING_FEATURE
> >> >>> >> |
> >> >>> >> +
> >> >>> >> + ENHANCED_CALLS_FEATURE
> >> >>> >> |
> >> >>> >> +                                             UCI_FEATURE |
> >> >>> >> +                                             UID_FEATURE |
> >> >>> >> +
> >> >>> >> + REFERENCING_FEATURE |
> >> >>> >> +
> >> >>> >> +DEFAULT_IMAGE_FEATURE); }
> >> >>> >> +
> >> >>> >>  static int pbap_probe(struct obc_session *session)  {
> >> >>> >>       struct pbap_data *pbap;
> >> >>> >> @@ -1274,6 +1309,7 @@ static struct obc_driver pbap = {
> >> >>> >>       .uuid = PBAP_UUID,
> >> >>> >>       .target = OBEX_PBAP_UUID,
> >> >>> >>       .target_len = OBEX_PBAP_UUID_LEN,
> >> >>> >> +     .supported_features = pbap_supported_features,
> >> >>> >>       .probe = pbap_probe,
> >> >>> >>       .remove = pbap_remove
> >> >>> >>  };
> >> >>> >> diff --git a/obexd/client/session.c b/obexd/client/session.c
> >> >>> >> index 9bba6c6..d2ae4fd 100644
> >> >>> >> --- a/obexd/client/session.c
> >> >>> >> +++ b/obexd/client/session.c
> >> >>> >> @@ -345,6 +345,7 @@ static void transport_func(GIOChannel *io,
> >> >>> >> GError *err, gpointer user_data)
> >> >>> >>       struct obc_driver *driver = session->driver;
> >> >>> >>       struct obc_transport *transport = session->transport;
> >> >>> >>       GObex *obex;
> >> >>> >> +     GObexApparam *apparam;
> >> >>> >>       GObexTransportType type;
> >> >>> >>       int tx_mtu = -1;
> >> >>> >>       int rx_mtu = -1;
> >> >>> >> @@ -370,7 +371,29 @@ static void transport_func(GIOChannel
> >> >>> >> *io, GError *err, gpointer user_data)
> >> >>> >>
> >> >>> >>       g_io_channel_set_close_on_unref(io, TRUE);
> >> >>> >>
> >> >>> >> -     if (driver->target != NULL)
> >> >>> >> +     apparam = NULL;
> >> >>> >> +
> >> >>> >> +     if (driver->supported_features)
> >> >>> >> +             apparam = driver->supported_features(session);
> >> >>> >> +
> >> >>> >> +     if (apparam) {
> >> >>> >> +             uint8_t buf[1024];
> >> >>> >> +             ssize_t len;
> >> >>> >> +
> >> >>> >> +             len = g_obex_apparam_encode(apparam, buf,
> sizeof(buf));
> >> >>> >> +             if (driver->target)
> >> >>> >> +                     g_obex_connect(obex, connect_cb, callback, &err,
> >> >>> >> +                                     G_OBEX_HDR_TARGET,
> >> >>> >> +                                     driver->target, driver->target_len,
> >> >>> >> +                                     G_OBEX_HDR_APPARAM,
> >> >>> >> +                                     buf, len,
> >> >>> >> +                                     G_OBEX_HDR_INVALID);
> >> >>> >> +             else
> >> >>> >> +                     g_obex_connect(obex, connect_cb, callback, &err,
> >> >>> >> +                                     G_OBEX_HDR_APPARAM, buf, len,
> >> >>> >> +                                     G_OBEX_HDR_INVALID);
> >> >>> >> +             g_obex_apparam_free(apparam);
> >> >>> >> +     } else if (driver->target)
> >> >>> >>               g_obex_connect(obex, connect_cb, callback, &err,
> >> >>> >>                       G_OBEX_HDR_TARGET, driver->target,
> >> >>> >> driver-
> >> >>> >> >target_len,
> >> >>> >>                       G_OBEX_HDR_INVALID);
> >> >>> >> --
> >> >>> >> 1.9.3
> >> >>> >>
> >> >>> >> --
> >> >>> >> To unsubscribe from this list: send the line "unsubscribe
> >> >>> >> linux-
> >> bluetooth"
> >> >>> > in
> >> >>> >> the body of a message to majordomo@vger.kernel.org More
> >> majordomo
> >> >>> >> info at  http://vger.kernel.org/majordomo-info.html
> >> >>> >
> >> >>> >
> >> >>> >
> >> >>> > I applied this patch locally and tested with PTS.
> >> >>> > The PTS test case: TP/SSM/BV-09-C [PCE Shares
> >> PbapSupportedFeature
> >> >>> > bits] is failing.
> >> >>> > According to PBAP V1.2 Spec - Section 6.4 - OBEX Connect
> >> >>> > request format, the PbapSupportedFeatures are shared during
> >> >>> > obex connect(after applying the this patch).
> >> >>> > Still the above test case is failing.
> >> >>> > Am I mapping anything wrong?
> >> >>>
> >> >>> Have you applied the full set? Maybe the PCE record needs
> >> >>> updating as well, but normally it is not mandatory.
> >> >>>
> >> >>>
> >> >>> --
> >> >>> Luiz Augusto von Dentz
> >> >>> --
> >> >>> To unsubscribe from this list: send the line "unsubscribe
> >> >>> linux-bluetooth" in the body of a message to
> >> >>> majordomo@vger.kernel.org More majordomo info at
> >> >>> http://vger.kernel.org/majordomo-info.html
> >> >>
> >> >>
> >> >> Yes, I applied the complete set and tested it. Still that TC is failing.
> >> >> Just want to know how it is failing, because I tried
> >> >> 1) Applying this patch set - not passing
> >> >> 2) Added below attribute in the src/profile PCE record at the end
> >> >> as below
> >> - not passing
> >> >>                <attribute id=\"0x0317\">
> >> >>                         <uint32 value=\"0x00000003\"/>
> >> >>                 </attribute>
> >> >>
> >> >> May be it’s a PTS Issue. Anyway it's not mandatory.
> >> >
> >> > I will try it as well, btw does the logs indicate anything useful?
> >>
> >> Btw, what TC is failing?
> >>
> >
> > The PTS test case: TP/SSM/BV-09-C [PCE Shares PbapSupportedFeature
> bits] is failing.
> > Test objective is to verify that the PCE can share its
> PbapSupportedFeatures bits with a server.
> >
> > Steps I followed:
> > 1) Ran Bluetoothd
> > 2) Ran obexd
> > 3) Initiated the above mentioned TC in PTS tool.
> > 4) ./pbap-client 00:1B:DC:07:33:4E >> err.txt
> >
> > Bluetoothd logs:
> >
> > bluetoothd[2740]: src/adapter.c:connected_callback() hci0 device
> > 00:1B:DC:07:33:4E connected eir_len 21
> > bluetoothd[2740]: src/adapter.c:dev_disconnected() Device
> > 00:1B:DC:07:33:4E disconnected, reason 2
> > bluetoothd[2740]: src/adapter.c:adapter_remove_connection()
> > bluetoothd[2740]: plugins/policy.c:disconnect_cb() reason 2
> > bluetoothd[2740]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> > 00:1B:DC:07:33:4E type 0 status 0xe
> > bluetoothd[2740]: src/device.c:device_bonding_complete() bonding (nil)
> > status 0x0e
> > bluetoothd[2740]: src/device.c:device_bonding_failed() status 14
> > bluetoothd[2740]: src/adapter.c:resume_discovery()
> >
> > Obexd logs: Nothing while executing the TC
> 
> It is probably better if you can use obexctl> connect <address> pbap, also it
> would be good to have the HCI traces to be able to detect if PTS is really
> setting the record properly, for example if it is not advertising 0x0102 in the
> record we will not attempt to send the parameters.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

After changing the "PBAP Role:  as 1.2 " in PICS, it is passing.

HCI trace: 

HCI sniffer - Bluetooth packet analyzer ver 5.25
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:1B:DC:07:33:4E ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 76 bdaddr 00:1B:DC:07:33:4E type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 76
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:1B:DC:07:33:4E mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 76 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 76
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 76 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 76 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1B:DC:07:33:4E mode 2 clkoffset 0x0000
< ACL data: handle 76 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0038
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
< ACL data: handle 76 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1B:DC:07:33:4E name 'PTS-PBAP-GOWTHAM-AB'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 76 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 76 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x02b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
        Unicast Connectless Data Reception
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 76 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic) 
> ACL data: handle 76 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
< ACL data: handle 76 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 76 flags 0x00 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000112f-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 115
    L2CAP(d): cid 0x0040 len 111 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x6a
          count 103
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000b
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x112f (PBAP PSE) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1130 (PBAP) uint 0x102 > >
              aid 0x0100 (SrvName)
                 str 50 68 6f 6e 65 62 6f 6f 6b 0a 41 63 63 65 73 73 20 50 53 45 20 50 54 53
              aid 0x0200 (VersionNumList)
                 uint 0x1005
              aid 0x0314 (SuppRepositories)
                 uint 0xf
              aid 0x0317 (unknown)
                 uint 0x3ff
          cont 00
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 76
< ACL data: handle 76 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:1B:DC:07:33:4E
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:1B:DC:07:33:4E key E07D49C59D7D98B121A2CFCD41E05458
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:1B:DC:07:33:4E
> ACL data: handle 76 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 76
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 76 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 76 encrypt 0x01
< ACL data: handle 76 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 4101 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 76 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 76 flags 0x00 dlen 27
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 15
      MTU 32767 
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000, MPS 298) 
> ACL data: handle 76 flags 0x02 dlen 27
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 15
      MTU 4096 
      RFC 0x03 (Enhanced Retransmission, TxWin 8, MaxTx 16, RTo 0, MTo 0, MPS 1691) 
< ACL data: handle 76 flags 0x00 dlen 29
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 15
      MTU 4096 
      RFC 0x03 (Enhanced Retransmission, TxWin 8, MaxTx 16, RTo 2000, MTo 12000, MPS 298) 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 29
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 15
      MTU 4096 
      RFC 0x03 (Enhanced Retransmission, TxWin 24, MaxTx 0, RTo 256, MTo 256, MPS 298) 
< ACL data: handle 76 flags 0x00 dlen 43
    L2CAP(d): cid 0x0040 len 39 ctrl 0x0000 fcs 0x1dc9 [psm 4101]
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 ctrl 0x0101 fcs 0xe8d5 [psm 4101]
      S-frame: Receiver Ready (RR) ReqSeq 1
> ACL data: handle 76 flags 0x02 dlen 39
    L2CAP(d): cid 0x0041 len 35 ctrl 0x0100 fcs 0x1c79 [psm 4101]
      I-frame: Unsegmented TxSeq 0 ReqSeq 1
< ACL data: handle 76 flags 0x00 dlen 8
    L2CAP(d): cid 0x0040 len 4 ctrl 0x0101 fcs 0x14d4 [psm 4101]
      S-frame: Receiver Ready (RR) ReqSeq 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
< ACL data: handle 76 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 76 reason 0x13
    Reason: Remote User Terminated Connection

PTS Output:

Test case : TC_PCE_SSM_BV_09_C started
	- SPP Service successfully registered
	- SDP Service record: 'HFP-AG Service Record' successfully registered
	- SDP Service record successfully registered
	- PBAP successfully initialized
	- MTC: IUT successfully sent OBEX CONNECT request.
	- MTC: Extract Support Feature Successful
	- MTC: SDP Record contained Supported Feature
	- MTC: No more incoming message.
	- CM_PTC_EXIT
	- PBAP : Test case ended.
Final Verdict : Pass

Thanks.

Regards,
Gowtham Anandha Babu


