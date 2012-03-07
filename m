Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Mar 2012 17:50:24 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/2] Bluetooth: General HCI callback implementation
Message-ID: <20120307155021.GG3647@aemeltch-MOBL1>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <201203061602.17443.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201203061602.17443.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Janc,

On Tue, Mar 06, 2012 at 04:02:17PM +0100, Szymon Janc wrote:
> hci_add_cb could return error on failure and that could be used in hci_cmd_cb().
> 
> > +void hci_add_cb(struct hci_dev *hdev, __u16 opcode,
> > +			void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd),
> > +			void *opt, void (*destructor)(struct cb_cmd *cmd))
> > +{
> > +	struct cb_cmd *cmd;
> > +
> > +	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
> 
> Why atomic? Maybe allow to pass custom gfp mask?

I think I will use gfp mask since I use it also with spinlocks held.

Best regards 
Andrei Emeltchenko 

