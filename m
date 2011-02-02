Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 15:41:14 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] Bluetooth: process received S-frames when socket is
 locked by user process
Message-ID: <20110202174114.GI2273@joana>
References: <1296479571-2971-1-git-send-email-suraj@atheros.com>
 <20110202162818.GD2273@joana>
 <4D49879F.8020000@Atheros.com>
 <20110202165112.GG2273@joana>
 <4D4995D7.6070408@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D4995D7.6070408@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@Atheros.com> [2011-02-02 23:05:19 +0530]:

> Hi Gustavo,
> 
> On 2/2/2011 10:21 PM, Gustavo F. Padovan wrote:
> > This one: e454c844644683571617896ab2a4ce0109c1943e
> >
> > The issue fixed by this patch is very similar to what you reported
> 
> Is this commit available in 
> "git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-next-2.6.git" 
> tree?

Yes, it is also available in Linus' tree.

commit e454c844644683571617896ab2a4ce0109c1943e
Author: Gustavo F. Padovan <padovan@profusion.mobi>
Date:   Tue Sep 21 16:31:11 2010 -0300

    Bluetooth: Fix deadlock in the ERTM logic
    
    The Enhanced Retransmission Mode(ERTM) is a realiable mode of operation
    of the Bluetooth L2CAP layer. Think on it like a simplified version of
    TCP.
    The problem we were facing here was a deadlock. ERTM uses a backlog
    queue to queue incomimg packets while the user is helding the lock. At
    some moment the sk_sndbuf can be exceeded and we can't alloc new skbs
    then the code sleep with the lock to wait for memory, that stalls the
    ERTM connection once we can't read the acknowledgements packets in the
    backlog queue to free memory and make the allocation of outcoming skb
    successful.
    successful.
    
    This patch actually affect all users of bt_skb_send_alloc(), i.e., all
    L2CAP modes and SCO.
    
    We are safe against socket states changes or channels deletion while the
    we are sleeping wait memory. Checking for the sk->sk_err and
    sk->sk_shutdown make the code safe, since any action that can leave the
    socket or the channel in a not usable state set one of the struct
    members at least. Then we can check both of them when getting the lock
    again and return with the proper error if something unexpected happens.
    
    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
    Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>



-- 
Gustavo F. Padovan
http://profusion.mobi
