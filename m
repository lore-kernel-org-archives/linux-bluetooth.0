Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sat, 13 Mar 2010 14:30:01 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: tmonahan@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
Message-ID: <20100313171654.GB19188@vigoh>
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>
 <1267753300.29510.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267753300.29510.25.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

* Marcel Holtmann <marcel@holtmann.org> [2010-03-04 17:41:40 -0800]:

> Hi Tim,
> 
> > QuIC (Qualcomm Innovation Center, Inc., a member of the Code Aurora Forum)
> > is planning an implementation of AMP for BlueZ.  Here are some details of
> > our technical approach.  We are interested in comments from the BlueZ
> > development community on validity and whether there are areas we have
> > missed.
> > 
> > Features:
> > - Completion of L2CAP with ERTM
> > 
> > - Addition of L2CAP Channel Management and AMP Manager
> > 
> > - DBUS support to access AMP features, control AMP settings, etc.
> > 
> > - Updates to Test Programs (hcidump, hciemu, l2test, ...)
> > 
> > - Creation of a Fake PAL to facilitate desktop development using wired TCP
> > 
> > - Legacy L2CAP sockets take advantage of AMP, if so enabled using new
> > controls (sockopts or DBUS)
> > 
> > - Key Management extended for AMP Controller Keys
> > 
> > 
> > L2CAP and ERTM
> > --------------
> > 
> > A prerequisite for AMP support is a fully functional L2CAP ERTM
> > implementation, including optional L2CAP features not currently included
> > in BlueZ.
> > 
> > Our overall approach is to build on the existing ERTM code in the
> > bluetooth-testing tree, extending the present socket interfaces that are
> > visible to userspace.  The extensions we foresee are sockopt configuration
> > of MPS (max PDU size), TX window size (currently hard coded), and a simple
> > AMP control policy ("BR/EDR only", "initiate on or move to AMP", or
> > "initiate on or move to BR/EDR, allow incoming move").
> 
> I was under the impression it is best to match the MPS with the ACL MTU
> from the controller? So do we need really an option less. Less options
> are less confusing for users.

MaxTransmit should be in the sockopt too.

> 
> > There are a few protocol-level enhancements required.  One is to support
> > L2CAP lockstep configuration, in addition to the present standard
> > configuration process.  Another addition is support for the extended TX
> > window option.
> > 
> > Core ERTM functionality (without the proposed additional features) is
> > still a work in progress, and the main area that needs attention is the
> > implementation of the transmitter (XMIT and WAIT_F) and receiver (RECV and
> > SREJ_SENT) state tables as defined in the ERTM spec.
> > 
> > 
> > L2CAP and Channel Management for AMP
> > ------------------------------------
> > 
> > Once ERTM is working without AMP, the state machine will have to be
> > extended to account for the extra demands of creating channels directly on
> > an AMP controller and AMP channel moves.  L2CAP will have to deal with two
> > controllers (BR/EDR and AMP) while the channel move is taking place, and
> > correctly handle lockstep reconfiguration of the L2CAP channel when the
> > move is completing.
> > 
> > To enable AMP, L2CAP itself will need to be enhanced to support the A2MP
> > fixed channel and to use the AMP Manager to create/disconnect physical and
> > logical links on an AMP controller.  Additionally L2CAP will need to
> > manage channels according to the new AMP control, moving them as
> > appropriate and handling remote move requests.
> > 
> > The AMP Manager function will need to be created. It will support
> > signaling on the A2MP channel and the create/disconnect of AMP physical
> > and logical links.
> > 
> > HCI will need to be extended to support data-block-based flow control. AMP
> > Controllers will be presented to BlueZ as HCI devices of a new type.
> 
> The block-based flow control is a missing piece, but the AMP type
> extension has been merged upstream. We can create HCI_BREDR and
> HCI_80211 controllers now. The AMP controllers are for now forced to be
> raw devices, but that can be changed easily once we have the controller
> init for AMP up and ready.
> 
> > DBUS Additions (bluetoothd)
> > ---------------------------
> > 
> > org.bluez.Adapter : A new property is added, containing a list of the
> > associated org.bluez.AmpAdapter objects ("/org/bluez/amp{0, 1, 2, ...}"). 
> > Associating a given AmpAdapter to a parent BR/EDR device
> > ("/org/bluez/hci{n}") is one method of org.bluez.AmpAdapter . AmpAdapter
> > has other methods to obtain the local controller's type and status, and
> > the number of physical links it carries, and to mark whether it is
> > available for use by the Amp Manager.
> > 
> > org.bluez.Device : A new method begins the AMP Discovery procedure for
> > that Device; an alternative would be to add the procedure to what
> > DiscoverServices() does. A new property contains the cached remote AMP
> > Device list.
> 
> I have to reject this. I don't seen any need to expose this. We could
> just do this all internally inside the kernel. The AMP policy should
> trigger these automatically and if AMP usage is allowed, we just pick
> the right AMP. Involving the user in AMP discovery makes no sense and
> complicates the user cases.
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
