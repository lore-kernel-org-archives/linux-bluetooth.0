Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Jun 2015 15:21:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth:hci_bcsp:Fix coding style -- Clean up
Message-ID: <20150620122139.GA7520@t440s.P-661HNU-F1>
References: <20150619051510.GA14012@ubuntu>
 <FBA67A82-D119-445B-A90A-B06F3D5A2E94@holtmann.org>
 <20150619095503.GA21667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150619095503.GA21667@ubuntu>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

On Fri, Jun 19, 2015, Mutharaju, Prasanna (P.) wrote:
> On Fri, Jun 19, 2015 at 11:20:43AM +0200, Marcel Holtmann wrote:
> > Hi Prasanna,
> > 
> > > Space prohibited between function name and open parenthesis '('
> > > reported by Checkpatch
> > > 
> > > Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> > > ---
> > > drivers/bluetooth/hci_bcsp.c |    8 ++++----
> > > 1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > I got a malformed patch on my side. I can not apply it with git am.
> > 
> > Regards
> > 
> > Marcel
> > 
> Hey Marcel,
> 
> I see git am applies fine on my branch. Actually, Fix is for Space warning and not 
> intended for lines > 80 chars. Any suggestions ?

No direct suggestions, but there is definitely something wrong with the
patch since I'm unable to apply it as well:

Applying: Bluetooth:hci_bcsp:Fix coding style -- Clean up
/home/jh/src/linux/.git/rebase-apply/patch:25: trailing whitespace.
					bcsp->rx_skb->data[0] & 0x80 ? 
/home/jh/src/linux/.git/rebase-apply/patch:30: space before tab in indent.
			    		&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
error: patch failed: drivers/bluetooth/hci_bcsp.c:464
error: drivers/bluetooth/hci_bcsp.c: patch does not apply
Patch failed at 0001 Bluetooth:hci_bcsp:Fix coding style -- Clean up

Johan
