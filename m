Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 16:59:31 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	pkrystad@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv1 01/17] Bluetooth: A2MP: Create A2MP channel
Message-ID: <20120528135924.GB3537@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337351150-20526-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1205221039100.2239@mathewm-linux>
 <20120523074950.GA32022@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205230842040.6526@mathewm-linux>
 <20120524075105.GB24715@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205240853590.18142@mathewm-linux>
 <20120525080904.GF3089@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205250918520.2070@mathewm-linux>
 <20120528072454.GB31961@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120528072454.GB31961@aemeltch-MOBL1>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, May 28, 2012 at 10:24:56AM +0300, Andrei Emeltchenko wrote:
> > >>The risk is not memory leaks - if the other device closes the ACL,
> > >>then the A2MP channel will be cleaned up.  But if you had two BlueZ
> > >>devices with A2MP connected to each other, the ACL would never close
> > >>as long as the devices remained powered and in range!  Nothing would
> > >>trigger the flush as long as the hci_conn is held.
> > >
> > >Does it indicate that we have problem with rather freeing amp_mgr?
> > 
> > It looks like the amp_mgr will be freed if the channel is closed.
> > There's nothing that will close the channel except for:
> > 
> > * Remote device disconnects the ACL
> > * Remote device goes out of range
> > * Local BR/EDR controller is powered down or reset
> > 
> > >>I think the checks for hci_conn_put are necessary, even if they are
> > >>ugly.
> > >
> > >I think that if I have hci_conn_hold when creating channel and
> > >hci_conn_put when closing channel that does not differ from the case when
> > >I do not have hci_conn_put/hold.
> > 
> > If there was something that closed the A2MP channel, there would be
> > no difference.  But nothing closes the A2MP channel.
> 
> I actually was thinking about timers which could do clean up.
> 
> > >So you are probably referring to the case when hci_conn needs to be closed
> > >but cannot because it has hci_conn_hold in a2mp channel?
> > 
> > Yes.
> > 
> > >This also means that we still have L2CAP channel (a2mp) hanging.
> > >This seems right to me if I did not miss something.
> > 
> > Since A2MP is a fixed channel, it is not opened and closed like
> > typical L2CAP channels.  Consider this scenario:
> > 
> > 1. Remote device decides to connect
> > 2. ACL is created
> > 3. Remote device sends A2MP discover
> > 4. A2MP channel is set up, AMP manager is created, hci_conn_hold for
> > A2MP channel
> > 5. Remote device connects L2CAP channel over BR/EDR.  hci_conn_hold
> > for the data channel
> > 6. A2MP communication to set up physical link
> > 7. L2CAP channel move to AMP controller
> > 8. Data sent over AMP.
> > 9. L2CAP channel disconnected, hci_conn_put for the data channel
> > 10. Device stays in range.  hci_conn reference count is not 0, so
> > ACL is not closed.
> 
> My concern here if A2MP does not reference hci_conn can hci_conn be
> removed while we still have A2MP chan in some situation?

I just tested code with PTS and got one crash:

<------8<--------------------------------------------------------------------
|  [  275.100760] [5] hci_chan_del: hci0 conn f3ff0800 chan e818e540
|  [  275.109610] [19] l2cap_send_rr_or_rnr: chan e806b800, poll 0
|  [  275.127922] [19] l2cap_send_sframe: chan e806b800, control f5ef3ed8
|  [  275.133532] [19] l2cap_send_sframe: reqseq 2, final 0, poll 0, super 0
|  [  275.173033] [5] hci_conn_del: hci0 conn f3ff0800 handle 11
|  [  275.181131] [5] hci_chan_list_flush: conn f3ff0800
|  [  275.202645] [5] amp_mgr_put: mgr e8260600
<------8<--------------------------------------------------------------------

Here we deleted the last L2CAP channel

<------8<------------------------------------------------------------------
|  [  275.295020] BUG: unable to handle kernel NULL pointer dereference at
|  (null)
|  [  275.298791] IP: [<f8362e6c>] l2cap_do_send+0x1c/0xa0 [bluetooth]
|  [  275.298791] *pde = 00000000
|  [  275.298791] Oops: 0000 [#1] SMP
<------8<------------------------------------------------------------------

Then we got the crash probably hci_conn deleted faster then we get reply
from AMP controller

<------8<---------------------------------------------------------------------
|  [  275.298791] EIP: [<f8362e6c>] l2cap_do_send+0x1c/0xa0 [bluetooth]
|  SS:ESP 0068:f5ef3e58
|  [  275.298791] CR2: 0000000000000000
|  [  276.553113] Bluetooth: hci1 command tx timeout
|  [  276.553706] ---[ end trace b08f23ddb2b49a2e ]---
|  [  276.577494] [30] hci_queue_cb: Queue cmd ed3d5540 opt e8260600
|  [  276.723885] [30] l2cap_segment_sdu: chan e806b800, msg f5919e94, len 22
|  [  276.790990] BUG: unable to handle kernel NULL pointer dereference at
|  00000010
|  [  276.794865] IP: [<f83694dd>] l2cap_chan_send+0x28d/0xb40 [bluetooth]
<------8<---------------------------------------------------------------------

Best regards 
Andrei Emeltchenko 
