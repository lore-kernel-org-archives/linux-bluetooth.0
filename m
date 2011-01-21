Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Jan 2011 15:10:26 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4] Bluetooth: Use non-flushable by default L2CAP data
 packets
Message-ID: <20110121171026.GB2400@joana>
References: <1294046076-3712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1294046076-3712-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294046076-3712-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-01-03 11:14:36 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Modification of Nick Pelly <npelly@google.com> patch.
> 
> With Bluetooth 2.1 ACL packets can be flushable or non-flushable. This commit
> makes ACL data packets non-flushable by default on compatible chipsets, and
> adds the BT_FLUSHABLE socket option to explicitly request flushable ACL
> data packets for a given L2CAP socket. This is useful for A2DP data which can
> be safely discarded if it can not be delivered within a short time (while
> other ACL data should not be discarded).
> 
> Note that making ACL data flushable has no effect unless the automatic flush
> timeout for that ACL link is changed from its default of 0 (infinite).
> 
> Default packet types (for compatible chipsets):
> Frame 34: 13 bytes on wire (104 bits), 13 bytes captured (104 bits)
> Bluetooth HCI H4
> Bluetooth HCI ACL Packet
>     .... 0000 0000 0010 = Connection Handle: 0x0002
>     ..00 .... .... .... = PB Flag: First Non-automatically Flushable Packet (0)
>     00.. .... .... .... = BC Flag: Point-To-Point (0)
>     Data Total Length: 8
> Bluetooth L2CAP Packet
> 
> After setting BT_FLUSHABLE
> (sock.setsockopt(274 /*SOL_BLUETOOTH*/, 8 /* BT_FLUSHABLE */, 1 /* flush */))
> Frame 34: 13 bytes on wire (104 bits), 13 bytes captured (104 bits)
> Bluetooth HCI H4
> Bluetooth HCI ACL Packet
>     .... 0000 0000 0010 = Connection Handle: 0x0002
>     ..10 .... .... .... = PB Flag: First Automatically Flushable Packet (2)
>     00.. .... .... .... = BC Flag: Point-To-Point (0)
>     Data Total Length: 8
> Bluetooth L2CAP Packet
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/bluetooth.h |    5 +++
>  include/net/bluetooth/hci.h       |    2 +
>  include/net/bluetooth/hci_core.h  |    1 +
>  include/net/bluetooth/l2cap.h     |    1 +
>  net/bluetooth/hci_core.c          |    7 +++-
>  net/bluetooth/l2cap.c             |   59 ++++++++++++++++++++++++++++++++++--
>  6 files changed, 69 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next-2.6. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
