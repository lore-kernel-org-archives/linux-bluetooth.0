Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417086297-23687-1-git-send-email-s.nageshmurt@samsung.com>
References: <1417086297-23687-1-git-send-email-s.nageshmurt@samsung.com>
Date: Fri, 28 Nov 2014 10:33:37 +0200
Message-ID: <CABBYNZ+nO1j_hyP28bBRnWaNtnbUOSBdGQzBb6ay1iOGOYQ2Nw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audio/sink: Fix Update of a2dp-sink state
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Thu, Nov 27, 2014 at 1:04 PM, Sagar Nageshmurthy
<s.nageshmurt@samsung.com> wrote:
> a2dp-sink state is updated as disconnected even before signalling channel
> disconnection. So when fast connect/disconnect attempts are tried connection
> request fails.
>
> Currently when transport channel is disconnected AVDTP state is updated as
> AVDTP_STATE_IDLE. At this point still signalling channel exists. Even then
> a2dp-sink state is updated as disconnected which is wrong. With this
> patch a2dp-sink state is updated as disconnected after signalling channel
> disconnection i.e. when sink state is set to SINK_STATE_DISCONNECTED.
>
> a2dp-sink state is updated as DISCONNECTED at 05:43:29.
> But the A2DP signalling channel (CID 0x0042) is disconnected at 05:43:31.
>
> 05:43:29  profiles/audio/avdtp.c:session_cb()
> 05:43:29  profiles/audio/avdtp.c:avdtp_parse_resp() CLOSE request succeeded
> 05:43:29  profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMING -> CLOSING
> 05:43:29  profiles/audio/a2dp.c:close_cfm() Source 0xb734b190: Close_Cfm
> 05:43:29  profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: CLOSING -> IDLE
> 05:43:29  profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_BC_47_60_F5_88_89/fd1: TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
> 05:43:29  src/service.c:change_state() 0xb7358100: device BC:47:60:F5:88:89 profile a2dp-sink state changed: disconnecting -> disconnected (0)
> 05:43:30  profiles/audio/avdtp.c:set_disconnect_timer() name : HS300
> 05:43:30  profiles/audio/avdtp.c:avdtp_unref() 0xb7358900: ref=0
> 05:43:31  profiles/audio/avdtp.c:disconnect_timeout()
> 05:43:31  profiles/audio/avdtp.c:connection_lost() Disconnected from BC:47:60:F5:88:89 with error.  Connection timed out (110)
> 05:43:31  profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_BC_47_60_F5_88_89: SINK_STATE_PLAYING -> SINK_STATE_DISCONNECTED
> 05:43:31  profiles/audio/avdtp.c:connection_lost() 0xb7358900: ref=0
> 05:43:31  profiles/audio/avdtp.c:avdtp_free() 0xb7358900
> 05:43:31  profiles/audio/avdtp.c:disconnect_acl_timeout()
> 05:43:31  src/device.c:btd_device_disconnect()
> 05:43:31  src/device.c:btd_device_disconnect() Connected State : 1
> 05:43:31  src/adapter.c:dev_disconnected() Device BC:47:60:F5:88:89 disconnected, reason 2
>
> 2014-01-01 05:43:29.915453 > ACL data: handle 12 flags 0x02 dlen 6
>     L2CAP(d): cid 0x0042 len 2 [psm 25]
>       AVDTP(s): Close rsp: transaction 5 nsp 0x00
> 2014-01-01 05:43:29.916038 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0b43 scid 0x0043
> 2014-01-01 05:43:29.916654 > ACL data: handle 12 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> 2014-01-01 05:43:29.916797 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x1701 scid 0x0041
> 2014-01-01 05:43:29.917973 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x1701
> 2014-01-01 05:43:29.918107 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x1701
> 2014-01-01 05:43:29.921713 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x5f40 scid 0x0040
> 2014-01-01 05:43:29.922595 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> 2014-01-01 05:43:29.924527 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> 2014-01-01 05:43:29.928890 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> 2014-01-01 05:43:29.951891 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x1701 scid 0x0041
> 2014-01-01 05:43:29.953093 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0b43 scid 0x0043
> 2014-01-01 05:43:30.029197 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x5f40 scid 0x0040
> 2014-01-01 05:43:31.108839 < ACL data: handle 12 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x5a42 scid 0x0042
> 2014-01-01 05:43:31.159232 > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x5a42 scid 0x0042
> 2014-01-01 05:43:31.211347 < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 12 reason 0x13
>     Reason: Remote User Terminated Connection
> 2014-01-01 05:43:31.212105 > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> 2014-01-01 05:43:31.273439 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 1
> 2014-01-01 05:43:31.290860 > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 12 reason 0x16
>     Reason: Connection Terminated by Local Host
> ---
>  profiles/audio/sink.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> index f475709..bd4c329 100644
> --- a/profiles/audio/sink.c
> +++ b/profiles/audio/sink.c
> @@ -105,6 +105,8 @@ static void sink_set_state(struct sink *sink, sink_state_t new_state)
>         if (new_state != SINK_STATE_DISCONNECTED)
>                 return;
>
> +       btd_service_disconnecting_complete(service, 0);
> +
>         if (sink->session) {
>                 avdtp_unref(sink->session);
>                 sink->session = NULL;
> @@ -147,8 +149,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
>
>         switch (new_state) {
>         case AVDTP_STATE_IDLE:
> -               btd_service_disconnecting_complete(sink->service, 0);
> -
>                 if (sink->disconnect_id > 0) {
>                         a2dp_cancel(sink->disconnect_id);
>                         sink->disconnect_id = 0;
> --
> 1.7.9.5

This is by design actually, we only consider stream state not session
state from the service point of view, so perhaps we need to check what
is going on if we do fast Connect/Disconnect operations, it might be
that something is broken and we could not reuse the session if one
already exists.


-- 
Luiz Augusto von Dentz
