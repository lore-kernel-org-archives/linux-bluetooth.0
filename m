Return-Path: <cyrus@holtmann.org>
Message-ID: <1322059861.29909.8.camel@aeonflux>
Subject: Re: [RFC 3/3] Bluetooth: Add AMP initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: james.steele@accenture.com, pkrystad@codeaurora.org,
	linux-bluetooth@vger.kernel.org
Date: Wed, 23 Nov 2011 15:51:01 +0100
In-Reply-To: <20111123100446.GB28657@aemeltch-MOBL1>
References: <81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE@048-CH1MPN1-102.048d.mgd.msft.net>
	 <1321894407.2011.18.camel@aeonflux> <20111123100446.GB28657@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > > actually I think the READ_AMP_INFO is wrong here. It should be only
> > > > executed based on an AMP_Get_Info_Request during a connection setup
> > > > procedure.
> > > 
> > > You can read the AMP info over HCI upon receiving a request by A2MP,
> > > but there are reasons to issue the READ_AMP_INFO command in advance.
> > > For example, you need the Controller_Type for responding to the
> > > AMP_Discover_Request.  Also you may (tenuously) want the know the
> > > Max_PDU_Size in advance for selecting SDU sizes (w.r.t. segmentation).
> > > 
> > > Certainly READ_AMP_INFO is a command intended to be issued during
> > > controller initialization, the majority of the values should not
> > > change during the lifetime of the controller, and only once that
> > > command has been issued will the Controller commence sending
> > > AMP_Status_Change_Events to communicate changes in status.  At a
> > > minimum READ_AMP_INFO must be issued for each AMP_Discover_Request
> > > (and AMP_Get_Info_Request) received; but if AMP discovery is slower,
> > > then transitioning a channel to an AMP link will be slower.
> > 
> > is the AMP_Status_Change event is issued, then I am fine with reading
> > the AMP controller information ones at init and just caching it. Makes
> > the link setup procedure simpler since we only have to deal with the
> > assoc information.
> 
> So we issue READ_AMP_INFO at the init phase. When we receive A2MP
> Discovery of A2MP Get Info requests we send cached data and issue 
> READ_AMP_INFO again. Then if data change we send AMP_Status_Change
> event.

do we need to call Read_AMP_Info ever again? We get all the updates via
status change event, right?

> > > > And even the READ_BUFFER_SIZE is the wrong command since by default
> > > the
> > > > AMP controller is in block based flow control mode. So you would
> > > need to
> > > > read the flow control mode first actually.
> > > 
> > > Correct, although reading the flow control mode on an AMP controller
> > > after a HCI_Reset *should* always return “data block mode” (as that is
> > > the default).  The READ_BUFFER_SIZE should only be used if
> > > HCI_Write_Flow_Control_Mode has been issued first (and successfully
> > > enabled packet based flow control).  Instead I believe we should issue
> > > the HCI_Read_Data_Block_Size command, where the correct information is
> > > then provided for the host stack (with its "new" data block flow
> > > control model for AMP controllers).  I don’t think there is any
> > > requirement forcing an AMP controller to implement packet based flow
> > > control, so if there is no data block flow control model in the host
> > > yet then initialization has to be prepared to fail upon trying to
> > > configure packet based flow control mode.
> > 
> > Reading the flow control mode and data block size should be done via the
> > init sequence.
> 
> What about first separating init sequence to BR/EDR and AMP (making AMP
> sequence empty for now) and then adding functionality. Some commands like
> mentioned here READ_DATA_BLOCK_SIZE are missing from our implementation.

That is fine with me. Split the patches up.

Regards

Marcel


