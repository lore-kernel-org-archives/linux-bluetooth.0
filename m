Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 16:07:07 +0200
From: 'Emeltchenko Andrei' <Andrei.Emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: 'Marcel Holtmann' <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0 0/3] AMP HCI interface from A2MP
Message-ID: <20111208140704.GA2430@aemeltch-MOBL1>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322663484.26198.16.camel@aeonflux>
 <20111130151820.GB5158@aemeltch-MOBL1>
 <000001ccaff1$1ee6c0c0$5cb44240$@org>
 <1322738467.26198.26.camel@aeonflux>
 <000001ccb0bd$15c7e0b0$4157a210$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001ccb0bd$15c7e0b0$4157a210$@org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Dec 01, 2011 at 10:39:03PM -0800, Peter Krystad wrote:
> > > > > > The code adds AMP HCI commands from A2MP protocol. HCI events are handled
> > > > > > similar way as mgmt interface. amp_pending is a kind of copy of mgmt_pending.
> > > > >
> > > > > this is all kernel internal code with no interface to user space. I do
> > > > > not see the need for such a complex infrastructure. Can not just have
> > > > > proper callbacks or event callback table like with L2CAP. Or just
> > > > > something similar.
> > > >
> > > > I see this as a simple callback. amp_pending is just keeping context of HCI
> > > > command we need to handle. I also included reference counting since we had
> > > > bad experience with l2cap and rfcomm.
> > >
> > > There does have to be some way to carry the A2MP message context while performing
> > > local HCI operations to service the message. A2MP Get Remote Assoc requires multiple
> > > HCI commands with data accumulated between the commands before the response can be
> > > sent.
> > 
> > I agree, but this amp_pending seems to be wrong. I talked about changing
> > the init handling and at the same time we might can apply this to the
> > A2MP handling.
> 
> I don't think this amp_pending is the right approach either.
> 
> > Why not just set a bit in hdev->dev_flags or maybe even hcon->dev_flags
> > or something and based on that we do a nice async state machine that
> > sends the commands and results in calling back into A2MP core when its
> > finished.
> 
> I agree we can build a nice async state machine. But it needs to be carry more data
> than a bit in the hci_dev->flags. 1) For every A2MP request received we have
> to hang onto the request identifier byte to be returned in the response.  
> 2) For processing the A2MP Get AMP Assoc the partial assoc data has to be accumulated
> over multiple HCI calls before it can be returned in the response. 3) In the
> create physical link sequence the remote assoc has to be stored while it is fed
> to HCI in multiple commands, and after the channel select event the local assoc
> has to be accumulated before it can be sent back to the remote.
>  
> > That seems a bit simpler to me and more aligned in a way I wanna redo
> > the whole HCI command/event handling anyway. In addition we can just
> > expose these flags via debugfs as text and have a nice way of knowing
> > current states if something goes wrong.
> 
> In the CAF implementation there is a separate set of data structures that track all
> this context. I (and I think Andrei) think that that isn't the way to go. Storing
> the context in the hci_conn seems the best without adding more complexity. It needs

You are referring to HCI connection between BR/EDR controllers? But
context is needed when you get HCI event from AMP controller, then you
have only HCI id of AMP controller.

> to be on hci_conn not hci_dev because it possible for more than one remote AMP to send
> an A2MP command at one time. There will still need to be a flag in hci_dev->flags

This is easy solvable with amp_pending list.

> that serializes create physical link attempts, as PALs may require these to be serialized.
> 
> There is a union in the structure amp_ctx in the CAF code that summarizes the data
> that needs to kept around. I've included it at the end of this e-mail. I'm not suggesting
> use this as is, just that it shows what state has to be kept while processing
> the A2MP requests.

I feel that some data might be stored in some phy_link structure
especially state of the connection, etc.

Best regards 
Andrei Emeltchenko 

>    
> Regards,
> 
> Peter.
> 
> > > > > As far as I see it, we get an A2MP command over L2CAP fixed channel, we
> > > > > have to issue a HCI command or do some other task based on this and then
> > > > > respond to it. We only have one user of this first of all. And second of
> > > > > all, I think we can not really have pending A2MP commands anyway. This
> > > > > is pretty much one command at a time (per ACL link).
> > >
> > > A2MP commands are serialized by the sender, so A2MP message context could be
> > > associated with the hci_conn for BR-EDR.
> > 
> > That is what I thought. Thanks for confirming. So using hcon->dev_flags
> > seems like a possible way to make this a lot simpler.
> > 
> > And if the sender misbehaves, we just reject that commands that way.
> > Testing a flag is always cheaper then iterating a list.
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> /* Get AMP Assoc sequence */
> struct amp_gaa_state {
> 	__u8       req_ident;
> 	__u16      len_so_far;
> 	__u8      *assoc;
> };
> 
> /* Create Physical Link sequence */
> struct amp_cpl_state {
> 	__u8       remote_id;
> 	__u16      max_len;
> 	__u8      *remote_assoc;
> 	__u8      *local_assoc;
> 	__u16      len_so_far;
> 	__u16      rem_len;
> 	__u8       phy_handle;
> };
> 
> /* Accept Physical Link sequence */
> struct amp_apl_state {
> 	__u8       remote_id;
> 	__u8       req_ident;
> 	__u8      *remote_assoc;
> 	__u16      len_so_far;
> 	__u16      rem_len;
> 	__u8       phy_handle;
> };
> 
> struct amp_ctx {
> 	struct list_head list;
> 	struct amp_mgr *mgr;
> 	struct hci_dev *hdev;
> 	__u8       type;
> 	__u8       state;
> 	union {
> 		struct amp_gaa_state gaa;
> 		struct amp_cpl_state cpl;
> 		struct amp_apl_state apl;
> 	} d;
> 	__u8 evt_type;
> 	__u8 evt_code;
> 	__u16 opcode;
> 	__u8 id;
> 	__u8 rsp_ident;
> 
> 	struct sock *sk;
> 	struct amp_ctx *deferred;
> 	struct timer_list timer;
> };
> 
> --Peter Krystad
>   Employee of Qualcomm Innovation Center, Inc.
>   Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
