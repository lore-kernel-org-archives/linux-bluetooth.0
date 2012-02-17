Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 13:03:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/3] Ease debugging patches
Message-ID: <20120217110350.GA16018@x220>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 17, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Increase isage of state_to_string and prefix hex numbers
> with object names.
> 
> Changes:
> 	v2: added 3rd patch, prefixing couple of hex with obj name
> 
> Andrei Emeltchenko (3):
>   Bluetooth: Move scope of state_to_string
>   Bluetooth: Use symbolic names for state in debug
>   Bluetooth: Prefix hex numbers with object name
> 
>  include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
>  include/net/bluetooth/l2cap.h     |    3 ++-
>  net/bluetooth/hci_conn.c          |    4 ++--
>  net/bluetooth/l2cap_core.c        |   33 ++++-----------------------------
>  net/bluetooth/l2cap_sock.c        |    2 +-
>  5 files changed, 36 insertions(+), 33 deletions(-)

All three patches have been applied to my bluetooth-next tree. Thanks.

Johan
