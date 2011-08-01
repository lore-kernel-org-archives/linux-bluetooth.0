Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: VISHWANATH KM <a21174@motorola.com>
Date: Mon, 1 Aug 2011 18:59:30 +0530
Message-ID: <CACbkbUJ9wC4ZgAuhJ89ee4MVV+QugHNu0uAh+vhc8A7aJ1MwXw@mail.gmail.com>
Subject: Advertising cache and random address support
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Advertising cache seem to temporarily store the peer_addr_type info,
if we reboot, then we loose the information and subsequent connection
fails as we don't have the peer_addr_type, unless we re-scan

The better approach may be
1) bluez while receiving the advertising events would also store the
peer_addr_type info ( may be in dev_info structure in hciops )
2) while initiating connection bluez may pass the peer_addr_type as
part of  bt_io_connect in l2cap_connect (attrib/client.c) as part of
new option BT_IO_OPT_

Please let me know your comments on above, or if any better
approaches/alternatives on the same, thx

Regards
Vishwanath
