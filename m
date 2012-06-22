Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Jun 2012 15:09:08 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Add refcnt to l2cap_conn
In-Reply-To: <1340288314-9814-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1206221423110.2543@mathewm-linux>
References: <alpine.DEB.2.02.1206080843040.15058@mathewm-linux> <1340288314-9814-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Thu, 21 Jun 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Adding kref to l2cap_conn helps to better handle racing when deleting
> l2cap_conn. Races are created when deleting conn from timeout and from
> the other execution path.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/l2cap.h |    6 ++
> net/bluetooth/l2cap_core.c    |  128 +++++++++++++++++++++++++++++++++--------
> net/bluetooth/smp.c           |    7 +--
> 3 files changed, 113 insertions(+), 28 deletions(-)
>

This v2 patch adds reference counting for the info timer.  Are there 
any other changes compared to v1?

I'm still concerned that this "reference counting" does not count 
every reference.  It only counts references used by the timers and in 
l2cap_security_cfm.  This is a fragile approach - as the code evolves, 
it's not clear what the rules are for using reference counting with 
l2cap_conn.  I think the most maintainable and robust approach is to 
make the rule "Count every reference" (including those in hci_conn and 
l2cap_chan).  What rules do you think are best for reference counting 
in this case?  It might be good to include that information in the 
commit message or comments.

Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

