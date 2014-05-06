Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 3/3] Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399384509.2316.28.camel@jrissane-mobl.ger.corp.intel.com>
Date: Tue, 6 May 2014 07:15:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <20E593DE-57AA-4802-9C34-9C5E2AE3389E@holtmann.org>
References: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com> <1399282285-32743-4-git-send-email-jukka.rissanen@linux.intel.com> <0319CACA-1EEC-4928-9C06-688937728B21@holtmann.org> <1399384509.2316.28.camel@jrissane-mobl.ger.corp.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

>>> Create a CoC dynamically instead of one fixed channel for communication
>>> to peer devices.
>>> 
>>> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>>> ---
>>> include/net/bluetooth/l2cap.h |   3 +-
>>> net/bluetooth/6lowpan.c       | 470 ++++++++++++++++++++++++++----------------
>>> net/bluetooth/6lowpan.h       |  19 +-
>>> net/bluetooth/l2cap_core.c    |  19 +-
>>> 4 files changed, 308 insertions(+), 203 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>>> index 4abdcb2..ddf0b35 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>> @@ -137,7 +137,6 @@ struct l2cap_conninfo {
>>> #define L2CAP_FC_L2CAP		0x02
>>> #define L2CAP_FC_CONNLESS	0x04
>>> #define L2CAP_FC_A2MP		0x08
>>> -#define L2CAP_FC_6LOWPAN        0x3e /* reserved and temporary value */
>>> 
>>> /* L2CAP Control Field bit masks */
>>> #define L2CAP_CTRL_SAR			0xC000
>>> @@ -244,6 +243,7 @@ struct l2cap_conn_rsp {
>>> #define L2CAP_PSM_SDP		0x0001
>>> #define L2CAP_PSM_RFCOMM	0x0003
>>> #define L2CAP_PSM_3DSP		0x0021
>>> +#define L2CAP_PSM_6LOWPAN	0x003e
>> 
>> since we have no officially assigned value, please mark this one as temporary as well. It might be actually a good idea to allow providing this value via debugfs.
> 
> Sure, via debugfs it is then.
> 
>> 
>>> 
>>> /* channel identifier */
>>> #define L2CAP_CID_SIGNALING	0x0001
>>> @@ -626,6 +626,7 @@ struct l2cap_conn {
>>> 
>>> 	struct sk_buff_head	pending_rx;
>>> 	struct work_struct	pending_rx_work;
>>> +	struct work_struct	pending_6lowpan_work;
>> 
>> Please start thinking on how we can reach the level that bluetooth_6lowpan.ko can be its own module. So all 6loWPAN specific pieces should be externally to l2cap_conn.
> 
> The 6lowpan work_struct was needed so that we do not call 6lowpan stuff
> with locking active, so this should probably still be here even if we
> have a separate 6lowpan module?

Nope. This work_struct has to go away. We need to figure out a way to do it without it. The external module should not require internal l2cap_conn elements. Especially not work_struct.

Regards

Marcel

