Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 09:58:09 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 04/17] Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc
Message-ID: <20120914065807.GB7483@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347437192-24694-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209130814370.19321@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209130814370.19321@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 13, 2012 at 08:28:06AM -0700, Mat Martineau wrote:
> >When receiving A2MP Get AMP Assoc Request execute Read Local AMP Assoc
> >HCI command to AMP controller. If the AMP Assoc data is larger then it
> >can fit to HCI event only fragment is read. When all fragments are read
> >send A2MP Get AMP Assoc Response.
> >
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

...

> >+void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status)
> >+{
> >+	struct amp_mgr *mgr;
> >+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
> >+	struct a2mp_amp_assoc_rsp *rsp;
> >+	size_t len;
> >+
> >+	mgr = amp_mgr_lookup_by_state(READ_LOC_AMP_ASSOC);
> 
> What if multiple amp managers are in the READ_LOC_AMP_ASSOC state?
> Is that possible if multiple remote devices send GETAMPASSOC at the
> same time?

In this very unrealistic case I still do not see a problem. All those HCI
requests would be serialized and response would be sent for all AMP
managers.

Best regards 
Andrei Emeltchenko 

