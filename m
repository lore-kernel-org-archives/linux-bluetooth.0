Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441379830-29000-1-git-send-email-biradar.a@samsung.com>
References: <1441379830-29000-1-git-send-email-biradar.a@samsung.com>
Date: Mon, 7 Sep 2015 14:45:36 +0300
Message-ID: <CABBYNZ+uyiQ=2cPHievwv=Y2fNGP8FxSZZQe8d=yREQ3bkE3Mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Wrong obex response code was sent
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anurag Biradar <biradar.a@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anurag,

On Fri, Sep 4, 2015 at 6:17 PM, Anurag Biradar <biradar.a@samsung.com> wrote:
> Issue: This issue happened with JVC carkit. When we reject incoming pbap
> connection then carkit again initiating incoming pbap connection.
>
> Analysis: Checked the hcidump of andriod and then get to know that while
> reject an incoming pbap connection it is sending packet type as RFCOMM Disc
> whereas bluez was sending packet type as DM (Disconnect Mode)
> Please check the logs below
>
> Solution: Accept the connection then drop if reject was set
>
> Andriod logs
>
> 2015-09-03 11:33:48.877598 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0041
> 2015-09-03 11:33:48.878830 < ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>       Connection successful
> 2015-09-03 11:33:48.879568 < ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>       MTU 1691
> 2015-09-03 11:33:48.947164 > ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>       MTU 1013
> 2015-09-03 11:33:48.948221 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 11 packets 2
>
> ....
>
> 2015-09-03 11:33:52.803776 < ACL data: handle 11 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 0 dlci 38 pf 1 ilen 0 fcs 0x85
> 2015-09-03 11:33:52.812981 > ACL data: handle 11 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): UA: cr 0 dlci 38 pf 1 ilen 0 fcs 0xaf
> 2015-09-03 11:33:52.813508 < ACL data: handle 11 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> 2015-09-03 11:33:52.816631 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 11 packets 2
> 2015-09-03 11:33:52.843181 > ACL data: handle 11 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> 2015-09-03 11:33:52.843636 < ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> 2015-09-03 11:33:52.869122 > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> 2015-09-03 11:33:53.014953 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 11 packets 1
>
> Logs from bluez
> 2015-01-04 18:05:04.459983 > ACL data: handle 50 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0041
> 2015-01-04 18:05:04.460074 < ACL data: handle 50 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>       Connection successful
> 2015-01-04 18:05:04.460105 < ACL data: handle 50 flags 0x00 dlen 27
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 15
>       MTU 1013
>       RFC 0x00 (Basic)
> 2015-01-04 18:05:04.463004 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 50 packets 1
> 2015-01-04 18:05:04.463676 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 50 packets 1
> 2015-01-04 18:05:04.486747 > ACL data: handle 50 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>       MTU 1013
>
> ....
>
> 2015-01-04 18:05:13.768241 < ACL data: handle 50 flags 0x00 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 30 pf 1 ilen 0 fcs 0x47
> 2015-01-04 18:05:13.771445 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 50 packets 1
> 2015-01-04 18:05:13.783896 > ACL data: handle 50 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> 2015-01-04 18:05:13.784019 < ACL data: handle 50 flags 0x00 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> 2015-01-04 18:05:13.787589 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 50 packets 1
> 2015-01-04 18:05:13.947623 > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 50 reason 0x13
>     Reason: Remote User Terminated Connection

That is basically defer_setup taking action, so we are basically
holding the channel setup until the application accepts the connection
while Android accepts the connection just to terminate it later on.

> ---
>  src/profile.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index ca1dfec..3b76e8f 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1068,17 +1068,17 @@ static void ext_auth(DBusError *err, void *user_data)
>                 goto drop;
>         }
>
> -       if (err && dbus_error_is_set(err)) {
> -               error("%s rejected %s: %s", ext->name, addr, err->message);
> -               goto drop;
> -       }
> -
>         if (!bt_io_accept(conn->io, ext_connect, conn, NULL, &gerr)) {
>                 error("bt_io_accept: %s", gerr->message);
>                 g_error_free(gerr);
>                 goto drop;
>         }
>
> +       if (err && dbus_error_is_set(err)) {
> +               error("%s rejected %s: %s", ext->name, addr, err->message);
> +               goto drop;
> +       }

This is probably not the behavior we want, otherwise there is no point
in using DEFER_SETUP since we can accept the connection right away
which enables the remote to send data while the connection is still
being authorized. Maybe DM is treated as an unclean disconnection by
the JVC carkit but I don't see why a DISC would be different, actually
by looking at the RFCOMM spec it seems DM response for SABM indicates
that the channel wont be available by retrying:

BLUETOOTH SPECIFICATION
RFCOMM with TS 07.10
Page 18 of 29:
...
Control channel with a DM frame, sent on the referenced DLCI to
indicate that the DLCI
is not open, and that the responder would not grant a request to open
it later either.
(That is, a subsequent SABM sent by initiator would be declined with DM again.)

-- 
Luiz Augusto von Dentz
