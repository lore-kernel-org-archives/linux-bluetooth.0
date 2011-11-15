Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Nov 2011 16:22:20 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/3] Bluetooth: Allow to set AMP type for virtual HCI
Message-ID: <20111115142218.GB27081@aemeltch-MOBL1>
References: <1321267370-15727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321267370-15727-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111115120918.GA27081@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111115120918.GA27081@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 15, 2011 at 02:09:26PM +0200, Emeltchenko Andrei wrote:
> > @@ -239,6 +241,9 @@ static int vhci_open(struct inode *inode, struct file *file)
> >  	hdev->bus = HCI_VIRTUAL;
> >  	hdev->driver_data = data;
> >  
> > +	if (amp)
> > +		hdev->dev_type = HCI_AMP;
> > +
> 
> I am thinking about changing lines above to:
> 
> -       if (amp)
> +       if (amp) {
>                 hdev->dev_type = HCI_AMP;
> +               hdev->amp_type = AMP_CTRL_BLUETOOTH_ONLY;

actually it is amp_status, I have resent patches and removed ack from this
specific patch.

Best regards 
Andrei Emeltchenko  


