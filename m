Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <luiz.dentz@gmail.com>, <padovan@profusion.mobi>
CC: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<suraj@atheros.com>, <johan.hedberg@gmail.com>,
	<joakim.xj.ceder@stericsson.com>
Date: Mon, 15 Nov 2010 19:29:53 +0200
Subject: RE: [PATCH 1/4] Sim Access Profile API
Message-ID: <99B09243E1A5DA4898CDD8B7001114480BD8C2DB1D@EXMB04.eu.tieto.com>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1288791271-13857-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1289367190.9615.235.camel@aeonflux>
	<99B09243E1A5DA4898CDD8B7001114480BD700C239@EXMB04.eu.tieto.com>
	<20101110160757.GC3275@vigoh>
 <AANLkTino6tJbpEMWxz-PLBmOyb8=3KCr1uDm9dxSbp98@mail.gmail.com>
In-Reply-To: <AANLkTino6tJbpEMWxz-PLBmOyb8=3KCr1uDm9dxSbp98@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,=20

>Hi,

>>> >> + =A0 =A0 =A0 =A0 =A0void Disconnect(boolean type)
>>> >> +
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Disconnect SAP client from the =
server.
>>> >The 'type'
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parameter indicates disconnecti=
on type.
>>> >> +
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0True =A0- gracefull disconnecti=
on
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0False - immediate disconnection
>>> >> +
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Possible errors: org.bluez.Erro=
r.Failed
>>> >
>>> >I don't like this style of method names at all. Using method names=20
>>> >like GracefulDisconnect and ImmediateDisconnect would be better.
>>>
>>> That's fine.
>>>
>>> >However I am not sure we should differentiate here at all.=20
>We should=20
>>> >always to the graceful disconnect. What will the immediate=20
>>> >disconnect bring us?
>>>
>>> That's actually intended for testing only. One of PTS test=20
>cases expects the tester to trigger immediate disconnect.
>>> In practce, it is only used when connection to sim card is=20
>lost, but this is obviously done internally.
>>
>>
>> So this shouldn't be in the API, no one is going to use it. You can=20
>> create something internally for the immediate disconnection that you=20
>> go and set manually inside the code. Make sure to comment in=20
>the code=20
>> why you are adding this there. That can also be a option in some of=20
>> the bluetooth config files. Let's see what others think here.
>
>Actually this looks a lot like virtual cable unplug that PTS=20
>wants to hid, it is just crap that nobody use, so maybe e.g.
>--enable-pts-bullshit would actually make sense to activate=20
>the nonsense that pts wants, well it is still annoying to=20
>recompile just to run PTS tests. For hid the virtual cable=20
>unplug can be emulate via RemoveDevice, so maybe it make sense=20
>to do a immediate disconnect in such case for sap too, but=20
>this is still inconvenient since you have to repair after doing it.
>

So, simply let's get rid of immediate disconnect from sap api and leave if =
for sap-driver (sap-*.c file ) provider. I could extend sap-dummy api just =
for an example.

Service		org.bluez=20
Interface	org.bluez.SimAccess=20
Object path	[variable prefix]/{hci0,hci1,...}

Methods		void Disconnect()

			Disconnects SAP client from the server.

			Possible errors: org.bluez.Error.Failed

		void SetProperty(string name, variant value)

			Changes the value of the specified property. Only
			properties that are listed a read-write are changeable.

			Possible Errors: org.bluez.Error.DoesNotExist=20
					org.bluez.Error.InvalidArguments

		dict GetProperties()

			Return all properties for the interface. See the
			properties section for available properties.

			Possible Errors: org.bluez.Error.Failed

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Properties	boolean Enabled [readwrite]

			Set to true to start-up SAP server and register SDP record for=20
			it. Set to false to shutdown SAP server and remove the SDP record.

		boolean Connected [readonly]

			Indicates if SAP client is connected to the server.=20


More comments ?

Thanks,
/Waldek
