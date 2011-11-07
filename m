Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 20:58:36 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/1] Bluetooth: Add LE SecMgr and mgmtops support
Message-ID: <20111107225836.GA2523@joana>
References: <4EB854F0.60808@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EB854F0.60808@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-07 14:00:16 -0800]:

> Implemented missing components of MGMTOPS interface
> Differentiated as needed between BR/EDR pairing and LE pairing
> 
> These are a combination of changes we made to get make MGMTOPS more
> robust, and provide MITM pairing options for LE.  Much work has been
> put into
> merging these changes into the current master branch of Bluetooth Next, but
> they have not been extensively tested on that build.
> 
> This is anticipated to be the first step towards upstreaming these changes,
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  include/net/bluetooth/hci.h      |   36 ++
>  include/net/bluetooth/hci_core.h |   32 ++-
>  include/net/bluetooth/l2cap.h    |    5 +
>  include/net/bluetooth/mgmt.h     |   24 ++-
>  include/net/bluetooth/smp.h      |   14 +-
>  net/bluetooth/hci_conn.c         |   58 +++-
>  net/bluetooth/hci_core.c         |   64 +++-
>  net/bluetooth/hci_event.c        |  166 ++++++---
>  net/bluetooth/hci_sock.c         |    9 +-
>  net/bluetooth/l2cap_core.c       |   15 +-
>  net/bluetooth/mgmt.c             |  743
> ++++++++++++++++++++++++++++++++------
>  net/bluetooth/smp.c              |  661 ++++++++++++++++++++++++---------
>  12 files changed, 1441 insertions(+), 386 deletions(-)

We really appreciate your contribution to upstream, but this need to be
broken in more patches, otherwise its impossible to me review and accept it.

Try to split this in logical and atomic changes, upstream the easiest things
first, like small l2cap or smp changes. New MGMT commands need one commit
for each because they need to be discussed and so on.

The are many examples of this in the mailing list.

	Gustavo
