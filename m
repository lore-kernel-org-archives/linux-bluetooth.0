Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Aug 2012 10:32:25 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Power the device up after a rfkill unblock
Message-ID: <20120824133225.GA7128@echo>
References: <1345664010-30471-1-git-send-email-vinicius.gomes@openbossa.org>
 <1345664010-30471-2-git-send-email-vinicius.gomes@openbossa.org>
 <20120824122800.GA27292@x220.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120824122800.GA27292@x220.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 15:28 Fri 24 Aug, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Wed, Aug 22, 2012, Vinicius Costa Gomes wrote:
> > With the HCI_SETUP patches, this is all that is needed to make the
> > case when a adapter is added with Bluetooth blocked in rfkill to work.
> > 
> > When rfkill is unblocked, the device will be powered on, and if not
> > needed it will be automatically powered off.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/hci_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index fa974a1..395dcc6 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1061,8 +1061,10 @@ static int hci_rfkill_set_block(void *data, bool blocked)
> >  
> >  	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
> >  
> > -	if (!blocked)
> > +	if (!blocked) {
> > +		schedule_work(&hdev->power_on);
> 
> Don't you need to check for HCI_SETUP before calling schedule_work here?
> It should be possible to have an adapter powered off and toggling rfkill
> back and forth shouldn't cause it to be powered on.

Most probably. Nice catch. Thanks.

I am going to try it and see if it doesn't have any unexpected side effects.


Cheers,
-- 
Vinicius
