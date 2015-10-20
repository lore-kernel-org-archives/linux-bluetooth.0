Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v1 0/3] Fix L2CAP ERTM shutdown locking
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Tue, 20 Oct 2015 15:50:29 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Harish Jenny K N <harish_kandiga@mentor.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <3C4BE3EF-3D97-4AEE-89D2-8EA19D5A99AE@holtmann.org>
References: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> Details of the issue are described in the thread
> [RFC] Bluetooth ERTM L2CAP deadlocks (hung tasks) due to l2cap_sock_shutdown()
> and kernel.org Bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=99301
> 
> Summary
> =======
> 
> This is a continuation with the discussion in 
> http://marc.info/?l=linux-bluetooth&m=143507884817418&w=2
> 
> The latest discussion can be found in the thread
> [PATCH v1 0/7] Avoid L2CAP ERTM shutdown hung tasks
> http://www.spinics.net/lists/linux-bluetooth/msg64576.html
> 
> Note some of the patches from the orginal patchset had been applied to
> bluetooth-next by the maintainers. This new patchset applies to what is
> currently in bluetooth-next.
> 
> The solution is for preventing various flavours of hung task relating to
> l2cap_sock_shutdown() when the connection type is ERTM. The solution improves
> the locking to allow __l2cap_wait_ack() to wait with no locks held.
> 
> Locking Solution
> ================
> 
> This solution reorganises the l2cap_sock_shutdown() function which is designed
> to only action shutdown of the channel when shutdown is not already in progress.
> 
> This solution also reorganizes the mutex lock and is now only protecting
> l2cap_chan_close(). This is now consistent with other places where
> l2cap_chan_close() is called.
> 
> If a conn connection exists, call mutex_lock(&conn->chan_lock) 
> before calling l2cap_chan_close() to ensure other L2CAP protocol operations 
> do not interfere.
> 
> Note that the conn structure has to be protected from being freed as it is 
> possible for the connection to be disconnected whilst the locks are not held.
> This solution allows the mutex lock to be used even when the connection has
> just been disconnected.
> 
> In addition this solution reduces the scope of chan locking.
> 
> The only place where chan locking is needed is the call to
> l2cap_chan_close(chan, 0) which if necessary closes the channel. Therefore, move
> the l2cap_chan_lock(chan) and l2cap_chan_unlock(chan) locking calls to be around
> l2cap_chan_close(chan, 0).
> 
> This allows __l2cap_wait_ack() to be called with no mutex lock and no chan lock
> being held so L2CAP messaging over the ACL link can be done unimpaired. Note
> that the sk lock is released whilst __l2cap_wait_ack() waits meaning that no
> locks are held whilst waiting for ACKs.
> 
> Disconnection Request race condition modification
> =================================================
> 
> There is a L2CAP protocol race between the local peer and the remote peer
> demanding disconnection of the L2CAP link.
> 
> When L2CAP ERTM is used, l2cap_sock_shutdown() can be called from userland to
> disconnect L2CAP. However, there can be a delay introduced by waiting for ACKs.
> During this waiting period, the remote peer may have sent a Disconnection
> Request.
> 
> This means that during this waiting period, the remote peer may have sent a
> Disconnection Request which is actioned by the kernel. Therefore, recheck the
> shutdown status of the socket after waiting for ACKs because there is no need to
> do further processing if the connection has gone.
> 
> Testing
> =======
> 
> We do not use x86 based systems so we are unable to check whether bluetooth-next
> is working with this patchset.
> 
> SO_LINGER time was not formally tested. Our crash logs suggested that SO_LINGER
> time was not used.
> 
> This has been tested in kernels 3.8 and 3.14 on an ARM based board for a
> commercial product. Results show that the hung tasks no longer occur and
> the revised locking seems to work OK.
> 
> Some limited testing on ARM 3.14 kernel using l2cap_tester and hci_vhci module
> was done but this should be repeated by someone on bluetooth-next before
> accepting the changes.
> 
> Note that the failure scenario was Media player AVRCP browsing. Waiting for
> ACK's is unimportant in this scenario because it does not matter whether
> a media browsing request such as "get item" was successfully transferred at the
> point of shutting down the channel.
> 
> These patches have not been tested on a bluetooth-next based build. However,
> bluetooth-next with the patches applied has been built using x86_64_defconfig
> with Bluetooth enabled.
> 
> v1 changes
> ==========
> 
> 0001-Bluetooth-Unwind-l2cap_sock_shutdown.patch was introduced
> to handle l2cap_sock_shutdown() function which is designed to only 
> action shutdown of the channel when shutdown is not already in progress.
> This patch also reorganise the code flow by adding a goto to jump to the 
> end of function handling when shutdown is already being actioned.
> 
> 0002-Bluetooth-Reorganize-mutex-lock-in-l2cap_sock_shutdo.patch was introduced
> to reorganize the mutex lock and also reduce the scope of chan locking.
> 
> 0003-Bluetooth-l2cap_disconnection_req-priority-over-shut.patch was introduced 
> to handle a L2CAP protocol race between the local peer and the remote peer
> demanding disconnection of the L2CAP link, when L2CAP ERTM is used.
> 
> TODO list
> =========
> 
> Check if __l2cap_wait_ack() is really needed because the L2CAP ACKs only ensure
> that the upper layer messsages got to the remote peer. It does not ensure that
> an upper layer response message will come back before the shutdown completes.  
> 
> Feedback
> ========
> 
> Please review and provide comments on this solution. Thanks.
> 
> Patchset
> ========
> 
> Patches are based on bluetooth-next master branch (14 October 2015):
> 
> Dean Jenkins (3):
> Bluetooth: Unwind l2cap_sock_shutdown()
> Bluetooth: Reorganize mutex lock in l2cap_sock_shutdown()
> Bluetooth: l2cap_disconnection_req priority over shutdown
> 
> net/bluetooth/l2cap_sock.c | 71 ++++++++++++++++++++++++++++++----------------
> 1 file changed, 47 insertions(+), 24 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

