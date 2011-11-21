Return-Path: <cyrus@holtmann.org>
Message-ID: <1321894407.2011.18.camel@aeonflux>
Subject: Re: [RFC 3/3] Bluetooth: Add AMP initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: james.steele@accenture.com
Cc: Andrei.Emeltchenko.news@gmail.com, pkrystad@codeaurora.org,
	linux-bluetooth@vger.kernel.org
Date: Mon, 21 Nov 2011 17:53:27 +0100
In-Reply-To: <81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE@048-CH1MPN1-102.048d.mgd.msft.net>
References: <81C9FA9C1C2E9E45A9AC3EDD1858BC4312A6E6CE@048-CH1MPN1-102.048d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

> > actually I think the READ_AMP_INFO is wrong here. It should be only
> 
> > executed based on an AMP_Get_Info_Request during a connection setup
> 
> > procedure.
> 
>  
> 
> You can read the AMP info over HCI upon receiving a request by A2MP,
> but there are reasons to issue the READ_AMP_INFO command in advance.
> For example, you need the Controller_Type for responding to the
> AMP_Discover_Request.  Also you may (tenuously) want the know the
> Max_PDU_Size in advance for selecting SDU sizes (w.r.t. segmentation).
> 
>  
> 
> Certainly READ_AMP_INFO is a command intended to be issued during
> controller initialization, the majority of the values should not
> change during the lifetime of the controller, and only once that
> command has been issued will the Controller commence sending
> AMP_Status_Change_Events to communicate changes in status.  At a
> minimum READ_AMP_INFO must be issued for each AMP_Discover_Request
> (and AMP_Get_Info_Request) received; but if AMP discovery is slower,
> then transitioning a channel to an AMP link will be slower.

is the AMP_Status_Change event is issued, then I am fine with reading
the AMP controller information ones at init and just caching it. Makes
the link setup procedure simpler since we only have to deal with the
assoc information.

> > And even the READ_BUFFER_SIZE is the wrong command since by default
> the
> 
> > AMP controller is in block based flow control mode. So you would
> need to
> 
> > read the flow control mode first actually.
> 
>  
> 
> Correct, although reading the flow control mode on an AMP controller
> after a HCI_Reset *should* always return “data block mode” (as that is
> the default).  The READ_BUFFER_SIZE should only be used if
> HCI_Write_Flow_Control_Mode has been issued first (and successfully
> enabled packet based flow control).  Instead I believe we should issue
> the HCI_Read_Data_Block_Size command, where the correct information is
> then provided for the host stack (with its "new" data block flow
> control model for AMP controllers).  I don’t think there is any
> requirement forcing an AMP controller to implement packet based flow
> control, so if there is no data block flow control model in the host
> yet then initialization has to be prepared to fail upon trying to
> configure packet based flow control mode.

Reading the flow control mode and data block size should be done via the
init sequence.

> Also for AMP Controller initialization, the HCI_Set_Event_Mask_Page_2
> command should be issued to ensure the AMP related events are provided
> by the controller (by default they are turned off).  A suitable
> HCI_Set_Event_Mask command may also be needed if using enhanced flush
> on the AMP controller.  Event filters also apply to AMP controllers
> IIRC, so if following the BR/EDR example you may want to clear them
> too (although I imagine such initialization could be added when
> required).

The filters should be cleared by HCI_Reset actually. So we might just
ignore that one. I never found the HCI filters useful, but the event
mask is a good point. We need to set that one.

Regards

Marcel


