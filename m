Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 16:29:25 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCHv1 01/17] Bluetooth: A2MP: Create A2MP channel
Message-ID: <20120530132923.GA5402@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1205221039100.2239@mathewm-linux>
 <20120523074950.GA32022@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205230842040.6526@mathewm-linux>
 <20120524075105.GB24715@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205240853590.18142@mathewm-linux>
 <20120525080904.GF3089@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205250918520.2070@mathewm-linux>
 <20120528072454.GB31961@aemeltch-MOBL1>
 <20120528135924.GB3537@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205290905510.16153@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205290905510.16153@mathewm-linux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Tue, May 29, 2012 at 09:23:34AM -0700, Mat Martineau wrote:
> >>>Since A2MP is a fixed channel, it is not opened and closed like
> >>>typical L2CAP channels.  Consider this scenario:
> >>>
> >>>1. Remote device decides to connect
> >>>2. ACL is created
> >>>3. Remote device sends A2MP discover
> >>>4. A2MP channel is set up, AMP manager is created, hci_conn_hold for
> >>>A2MP channel
> >>>5. Remote device connects L2CAP channel over BR/EDR.  hci_conn_hold
> >>>for the data channel
> >>>6. A2MP communication to set up physical link
> >>>7. L2CAP channel move to AMP controller
> >>>8. Data sent over AMP.
> >>>9. L2CAP channel disconnected, hci_conn_put for the data channel
> >>>10. Device stays in range.  hci_conn reference count is not 0, so
> >>>ACL is not closed.
> >>
> >>My concern here if A2MP does not reference hci_conn can hci_conn be
> >>removed while we still have A2MP chan in some situation?
> 
> hci_conn_hold and hci_conn_put are not reference counts on the
> hci_conn structure in the typical way.  They are reference counts
> for the ACL.  When you do the last hci_conn_put, the ACL is
> disconnected after a timeout.
> 
> With or without hci_conn_hold for the A2MP channel, the ACL can
> disappear at any time.  The AMP manager must deal with that without
> crashing like it does in your trace.

OK, I found the bug, solution would be to define teardown for a2mp channel
to make sure all callbacks are cleared.

-static void a2mp_chan_no_teardown_cb(struct l2cap_chan *chan, int err)
+static void a2mp_chan_teardown_cb(struct l2cap_chan *chan, int err)
 {
-       BT_ERR("teardown for chan %p not implemented", chan);
+       struct hci_dev *hdev;
+
+       BT_DBG("chan %p", chan);
+
+       read_lock(&hci_dev_list_lock);
+       list_for_each_entry(hdev, &hci_dev_list, list) {
+               /* Iterate through AMP controllers */
+               if (hdev->amp_type == HCI_AMP)
+                       hci_cb_clear(hdev);
+       }
+       read_unlock(&hci_dev_list_lock);
 }

> >I just tested code with PTS and got one crash:
> >
> ><------8<--------------------------------------------------------------------
> >|  [  275.100760] [5] hci_chan_del: hci0 conn f3ff0800 chan e818e540
> >|  [  275.109610] [19] l2cap_send_rr_or_rnr: chan e806b800, poll 0
> >|  [  275.127922] [19] l2cap_send_sframe: chan e806b800, control f5ef3ed8
> >|  [  275.133532] [19] l2cap_send_sframe: reqseq 2, final 0, poll 0, super 0
> >|  [  275.173033] [5] hci_conn_del: hci0 conn f3ff0800 handle 11
> >|  [  275.181131] [5] hci_chan_list_flush: conn f3ff0800
> >|  [  275.202645] [5] amp_mgr_put: mgr e8260600
> ><------8<--------------------------------------------------------------------
> >
> >Here we deleted the last L2CAP channel
> 
> Ok.  The AMP manager should not attempt to send anything after this.
> 
> >
> ><------8<------------------------------------------------------------------
> >|  [  275.295020] BUG: unable to handle kernel NULL pointer dereference at
> >|  (null)
> >|  [  275.298791] IP: [<f8362e6c>] l2cap_do_send+0x1c/0xa0 [bluetooth]
> >|  [  275.298791] *pde = 00000000
> >|  [  275.298791] Oops: 0000 [#1] SMP
> ><------8<------------------------------------------------------------------
> >
> >Then we got the crash probably hci_conn deleted faster then we get reply
> >from AMP controller
> 
> This looks like a crash when the AMP manager tries to send
> something. It should not be trying to send anything at this point.
> 
> Once the AMP manager gets a state change callback with BT_CLOSED or
> a a close callback, amp_mgr->l2cap_conn and amp_mgr->a2mp_chan are
> invalid - even if the AMP manager has not been freed.

Sometimes we do not get this state change for a2mp channel.

Best regards 
Andrei Emeltchenko 
