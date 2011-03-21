Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v3 4/5] Bluetooth: Add add/remove_remote_oob_data management commands
Date: Mon, 21 Mar 2011 15:42:14 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1300712821-23172-1-git-send-email-szymon.janc@tieto.com> <1300712821-23172-5-git-send-email-szymon.janc@tieto.com> <20110321142639.GA2685@piper>
In-Reply-To: <20110321142639.GA2685@piper>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103211542.14986.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,

Hi Vinicius,

> >  static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> >  	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
> > @@ -2673,6 +2704,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> >  
> >  	case HCI_EV_LE_META:
> >  		hci_le_meta_evt(hdev, skb);
> > +
> 
> Looks like you are missing a "break" here.

Thanks for spotting this, will send v4 soon.

> Cheers,

BR,
Szymon Janc
