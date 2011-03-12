Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Mar 2011 22:33:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ed Tomlinson <edt@aei.ca>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	Mikko Vinni <mmvinni@yahoo.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
Message-ID: <20110312013349.GA2164@joana>
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com>
 <359639.21781.qm@web161807.mail.bf1.yahoo.com>
 <4D77EFEB.1020804@gmail.com>
 <201103092154.22796.edt@aei.ca>
 <20110310073206.GA1033@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110310073206.GA1033@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Johan Hedberg <johan.hedberg@gmail.com> [2011-03-10 09:32:06 +0200]:

> Hi,
> 
> On Wed, Mar 09, 2011, Ed Tomlinson wrote:
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 9c4541b..f690eb5 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -95,18 +95,17 @@ void hci_req_complete(struct hci_dev *hdev, __u16 
> > > cmd, int result)
> > >   {
> > >   	BT_DBG("%s command 0x%04x result 0x%2.2x", hdev->name, cmd, result);
> > > 
> > > +	if (hdev->req_status == HCI_REQ_PEND) {
> > > +		hdev->req_result = result;
> > > +		hdev->req_status = HCI_REQ_DONE;
> > > +		wake_up_interruptible(&hdev->req_wait_q);
> > > +	}
> > >   	/* If the request has set req_last_cmd (typical for multi-HCI
> > >   	 * command requests) check if the completed command matches
> > >   	 * this, and if not just return. Single HCI command requests
> > >   	 * typically leave req_last_cmd as 0 */
> > >   	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
> > >   		return;
> > > -
> > > -	if (hdev->req_status == HCI_REQ_PEND) {
> > > -		hdev->req_result = result;
> > > -		hdev->req_status = HCI_REQ_DONE;
> > > -		wake_up_interruptible(&hdev->req_wait_q);
> > > -	}
> > >   }
> > > 
> > >   static void hci_req_cancel(struct hci_dev *hdev, int err)
> > > 
> > 
> > Works here too - bluetooth comes up enabled.  On to Linus?
> 
> All the patch does is it re-breaks the __hci_request function by
> removing proper synchronization from it (again) and thereby hides the
> real bug which is the kernel sending commands to the controller before
> the HCI_Reset command has completed.

I got an 1.1 Bluetooth dongle that can cause this issue, now I can test this
by myself. I'll work to fix this next week.

-- 
Gustavo F. Padovan
http://profusion.mobi
