Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101110160757.GC3275@vigoh>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1288791271-13857-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1289367190.9615.235.camel@aeonflux>
	<99B09243E1A5DA4898CDD8B7001114480BD700C239@EXMB04.eu.tieto.com>
	<20101110160757.GC3275@vigoh>
Date: Wed, 10 Nov 2010 23:46:27 +0200
Message-ID: <AANLkTino6tJbpEMWxz-PLBmOyb8=3KCr1uDm9dxSbp98@mail.gmail.com>
Subject: Re: [PATCH 1/4] Sim Access Profile API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Waldemar.Rymarkiewicz@tieto.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, suraj@atheros.com, johan.hedberg@gmail.com,
	joakim.xj.ceder@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 10, 2010 at 6:07 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Waldemar,
>
> * Waldemar.Rymarkiewicz@tieto.com <Waldemar.Rymarkiewicz@tieto.com> [2010=
-11-10 13:12:53 +0200]:
>
>> Hi Marcel,
>>
>> >> + =A0 =A0 =A0 =A0 =A0void Disable()
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Shudown SAP server and remove th=
e SDP record.
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Possible errors: org.bluez.Error=
.Failed
>> >
>> >I don't like this. If you have properties then just changing
>> >the property should be enough. So a SetProperty is more appropriate.
>>
>> I see another option to get rid of 'Enabled' property and leave the meth=
ods. What would you say on that?
>
> It's not a good a idea. We have been moving everything we can to a set
> property operation instead of a method call. Do that as method is add
> unnecessary code to BlueZ once we already have set property there.
>
>>
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0void Disconnect(boolean type)
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Disconnect SAP client from the s=
erver.
>> >The 'type'
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parameter indicates disconnectio=
n type.
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0True =A0- gracefull disconnectio=
n
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0False - immediate disconnection
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Possible errors: org.bluez.Error=
.Failed
>> >
>> >I don't like this style of method names at all. Using method
>> >names like GracefulDisconnect and ImmediateDisconnect would be better.
>>
>> That's fine.
>>
>> >However I am not sure we should differentiate here at all. We
>> >should always to the graceful disconnect. What will the
>> >immediate disconnect bring us?
>>
>> That's actually intended for testing only. One of PTS test cases expects=
 the tester to trigger immediate disconnect.
>> In practce, it is only used when connection to sim card is lost, but thi=
s is obviously done internally.
>
>
> So this shouldn't be in the API, no one is going to use it. You can
> create something internally for the immediate disconnection that you go
> and set manually inside the code. Make sure to comment in the code why
> you are adding this there. That can also be a option in some of the
> bluetooth config files. Let's see what others think here.

Actually this looks a lot like virtual cable unplug that PTS wants to
hid, it is just crap that nobody use, so maybe e.g.
--enable-pts-bullshit would actually make sense to activate the
nonsense that pts wants, well it is still annoying to recompile just
to run PTS tests. For hid the virtual cable unplug can be emulate via
RemoveDevice, so maybe it make sense to do a immediate disconnect in
such case for sap too, but this is still inconvenient since you have
to repair after doing it.

--=20
Luiz Augusto von Dentz
Computer Engineer
