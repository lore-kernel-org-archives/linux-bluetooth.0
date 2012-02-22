Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Feb 2012 00:42:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 0/3] Bluetooth: Change socket lock to l2cap_chan lock
Message-ID: <20120222224256.GA9544@x220.ger.corp.intel.com>
References: <1329923517-5425-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329923517-5425-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 22, 2012, Andrei Emeltchenko wrote:
> Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
> protocols above L2CAP without creating sockets.
> 
> Changes:
> 	* PATCHv3: Do not remove couple of empty lines and remove old comments.
> 	* PATCHv2: Rebase remaining parts against latest tree and merge all
> 	patches dealing with converting sk lock to chan lock together following
> 	recommendation from Ulisses and Gustavo.
> 	* PATCHv1: Added extra line (per Gustavo comment)
> 	* RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged together
> 	following recommendations from review.
> 	* RFCv5: Fixed locking bug in l2cap_data_channel, added locks in 
> 	l2cap_sock_shutdown function, fixed several styles issues.
> 	* RFCv4: Better split patches so they looks more clear and obvious,
> 	taking coments about naming change and delete unused vars. See diff change
> 	from the previous version below:
> 	* RFCv3: Split the big patch to several small (I believe logical) chunks,
> 	remove unneded locks from cleanup_listen, use the same arguments for
> 	locked/unlocked socket error functions.
> 	* RFCv2: Convert l2cap channel list back to mutex from RCU list.
> 
> Andrei Emeltchenko (3):
>   Bluetooth: Add unlocked __l2cap_chan_add function
>   Bluetooth: Change sk lock to chan lock in L2CAP core
>   Bluetooth: Remove socket lock check
> 
>  net/bluetooth/l2cap_core.c |  175 ++++++++++++++++++++++++++------------------
>  net/bluetooth/l2cap_sock.c |   26 +++++--
>  2 files changed, 125 insertions(+), 76 deletions(-)

All three patches have been applied. Thanks.

Johan
