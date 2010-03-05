Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1267753300.29510.25.camel@localhost.localdomain>
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>
	 <1267753300.29510.25.camel@localhost.localdomain>
Date: Fri, 5 Mar 2010 14:45:19 +0200
Message-ID: <2d5a2c101003050445m6a305d7dm321d124fc3d75af5@mail.gmail.com>
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: tmonahan@codeaurora.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 5, 2010 at 3:41 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Tim,
>
>> QuIC (Qualcomm Innovation Center, Inc., a member of the Code Aurora Foru=
m)
>> is planning an implementation of AMP for BlueZ. =A0Here are some details=
 of
>> our technical approach. =A0We are interested in comments from the BlueZ
>> development community on validity and whether there are areas we have
>> missed.
>>
>> Features:
>> - Completion of L2CAP with ERTM
>>
>> - Addition of L2CAP Channel Management and AMP Manager
>>
>> - DBUS support to access AMP features, control AMP settings, etc.
>>
>> - Updates to Test Programs (hcidump, hciemu, l2test, ...)
>>
>> - Creation of a Fake PAL to facilitate desktop development using wired T=
CP
>>
>> - Legacy L2CAP sockets take advantage of AMP, if so enabled using new
>> controls (sockopts or DBUS)
>>
>> - Key Management extended for AMP Controller Keys
>>
>>
>> L2CAP and ERTM
>> --------------
>>
>> A prerequisite for AMP support is a fully functional L2CAP ERTM
>> implementation, including optional L2CAP features not currently included
>> in BlueZ.
>>
>> Our overall approach is to build on the existing ERTM code in the
>> bluetooth-testing tree, extending the present socket interfaces that are
>> visible to userspace. =A0The extensions we foresee are sockopt configura=
tion
>> of MPS (max PDU size), TX window size (currently hard coded), and a simp=
le
>> AMP control policy ("BR/EDR only", "initiate on or move to AMP", or
>> "initiate on or move to BR/EDR, allow incoming move").
>
> I was under the impression it is best to match the MPS with the ACL MTU
> from the controller? So do we need really an option less. Less options
> are less confusing for users.
>
>> There are a few protocol-level enhancements required. =A0One is to suppo=
rt
>> L2CAP lockstep configuration, in addition to the present standard
>> configuration process. =A0Another addition is support for the extended T=
X
>> window option.
>>
>> Core ERTM functionality (without the proposed additional features) is
>> still a work in progress, and the main area that needs attention is the
>> implementation of the transmitter (XMIT and WAIT_F) and receiver (RECV a=
nd
>> SREJ_SENT) state tables as defined in the ERTM spec.
>>
>>
>> L2CAP and Channel Management for AMP
>> ------------------------------------
>>
>> Once ERTM is working without AMP, the state machine will have to be
>> extended to account for the extra demands of creating channels directly =
on
>> an AMP controller and AMP channel moves. =A0L2CAP will have to deal with=
 two
>> controllers (BR/EDR and AMP) while the channel move is taking place, and
>> correctly handle lockstep reconfiguration of the L2CAP channel when the
>> move is completing.
>>
>> To enable AMP, L2CAP itself will need to be enhanced to support the A2MP
>> fixed channel and to use the AMP Manager to create/disconnect physical a=
nd
>> logical links on an AMP controller. =A0Additionally L2CAP will need to
>> manage channels according to the new AMP control, moving them as
>> appropriate and handling remote move requests.
>>
>> The AMP Manager function will need to be created. It will support
>> signaling on the A2MP channel and the create/disconnect of AMP physical
>> and logical links.
>>
>> HCI will need to be extended to support data-block-based flow control. A=
MP
>> Controllers will be presented to BlueZ as HCI devices of a new type.
>
> The block-based flow control is a missing piece, but the AMP type
> extension has been merged upstream. We can create HCI_BREDR and
> HCI_80211 controllers now. The AMP controllers are for now forced to be
> raw devices, but that can be changed easily once we have the controller
> init for AMP up and ready.
>
>> DBUS Additions (bluetoothd)
>> ---------------------------
>>
>> org.bluez.Adapter : A new property is added, containing a list of the
>> associated org.bluez.AmpAdapter objects ("/org/bluez/amp{0, 1, 2, ...}")=
.
>> Associating a given AmpAdapter to a parent BR/EDR device
>> ("/org/bluez/hci{n}") is one method of org.bluez.AmpAdapter . AmpAdapter
>> has other methods to obtain the local controller's type and status, and
>> the number of physical links it carries, and to mark whether it is
>> available for use by the Amp Manager.
>>
>> org.bluez.Device : A new method begins the AMP Discovery procedure for
>> that Device; an alternative would be to add the procedure to what
>> DiscoverServices() does. A new property contains the cached remote AMP
>> Device list.
>
> I have to reject this. I don't seen any need to expose this. We could
> just do this all internally inside the kernel. The AMP policy should
> trigger these automatically and if AMP usage is allowed, we just pick
> the right AMP. Involving the user in AMP discovery makes no sense and
> complicates the user cases.

I have to agree with Marcel on this, we probably don't really need any
AMP adapter exposed in BlueZ, perhaps we can have a property in the
adapter saying if the adapter  has AMP capability or not, but even
that I guess is too soon to evaluate so lets first concentrate in
kernel only leaving DBus for latter.


--=20
Luiz Augusto von Dentz
Computer Engineer
