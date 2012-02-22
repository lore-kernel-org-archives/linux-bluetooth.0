Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 16:41:46 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 2/3] Bluetooth: Change sk lock to chan lock in L2CAP
 core
Message-ID: <20120222184146.GA23348@joana>
References: <1329923517-5425-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329923517-5425-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329923517-5425-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-22 17:11:56 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Change sk lock to chan lock in l2cap core and move sk locks
> to l2cap sock code. bh_locks were used because of being RCU
> critical section. When needed use explicit socket locks.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  net/bluetooth/l2cap_core.c |  166 ++++++++++++++++++++++++++------------------
>  net/bluetooth/l2cap_sock.c |   18 ++++-
>  2 files changed, 114 insertions(+), 70 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

Now lets go to the next steps in the removal of socket usage inside L2CAP
core.

	Gustavo
