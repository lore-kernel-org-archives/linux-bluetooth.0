Return-Path: <cyrus@holtmann.org>
Message-ID: <1391708079.1460.0.camel@bali>
Subject: Re: [RFC v8 06/10] Bluetooth: Introduce LE auto connection
 infrastructure
From: Andre Guedes <andre.guedes@openbossa.org>
To: Vinicius Costa Gomes <vcgomes@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 06 Feb 2014 14:34:39 -0300
In-Reply-To: <20140206160209.GA26623@molly>
References: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org>
	 <1391639006-26311-6-git-send-email-andre.guedes@openbossa.org>
	 <20140206160209.GA26623@molly>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, 2014-02-06 at 14:02 -0200, Vinicius Costa Gomes wrote:
> Hi Andre,
> 
> On 19:23 Wed 05 Feb, Andre Guedes wrote:
> > This patch introduces the LE auto connection infrastructure which
> > will be used to implement the LE auto connection options.
> >
> > In summary, the auto connection mechanism works as follows: Once the
> > first pending LE connection is created, the background scanning is
> > started. When the target device is found in range, the kernel
> > autonomously starts the connection attempt. If connection is
> > established successfully, that pending LE connection is deleted and
> > the background is stopped.
> >
> > To achieve that, this patch introduces the hci_update_background_scan()
> > which controls the background scanning state. This function starts or
> > stops the background scanning based on the hdev->pend_le_conns list. If
> > there is no pending LE connection, the background scanning is stopped.
> > Otherwise, we start the background scanning.
> >
> > Then, every time a pending LE connection is added we call hci_update_
> > background_scan() so the background scanning is started (in case it is
> > not already running). Likewise, every time a pending LE connection is
> > deleted we call hci_update_background_scan() so the background scanning
> > is stopped (in case this was the last pending LE connection) or it is
> > started again (in case we have more pending LE connections). Finally,
> > we also call hci_update_background_scan() in hci_le_conn_failed() so
> > the background scan is restarted in case the connection establishment
> > fails. This way the background scanning keeps running until all pending
> > LE connection are established.
> >
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> 
> [snip]
> 
> >  static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> >  	u8 num_reports = skb->data[0];
> >  	void *ptr = &skb->data[1];
> >  	s8 rssi;
> >
> > +	hci_dev_lock(hdev);
> > +
> >  	while (num_reports--) {
> >  		struct hci_ev_le_advertising_info *ev = ptr;
> >
> > +		check_pending_le_conn(hdev, &ev->bdaddr, ev->bdaddr_type);
> > +
> 
> Shouldn't the event type be checked to see if it is a connectable event?

Sure. I'm fixing it.

Thanks,

Andre


