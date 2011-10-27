Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
	<alpine.DEB.2.02.1110270003090.30044@mathewm-linux>
	<7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
	<CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com>
Date: Thu, 27 Oct 2011 09:57:15 -0400
Message-ID: <CAJdJm_Po7iAOoB673XW6D3gTsCn_ME8CHEo0VcWzi5FKX9xghA@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

A few more comments, as Luiz's email reminded me of some other things.

On Thu, Oct 27, 2011 at 9:31 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Chen,
>
> On Thu, Oct 27, 2011 at 11:22 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> I do not see any reason why caching of data is required. Data should be read directly from the GATT server. Caching it may cause inconsistency. There is also no reason to read the values on characteristic object creation in the client.c file. I think the decision of reading the value should be by the user and not the system.
>> In addition, Value is not a property of a characteristic.
>
> Actually is the other way round, caching is the only way to maintain
> data consistency otherwise we will never be able to do notifications
> properly because clients can, and probably will, keep polling at
> different rate, also this remove any possibility of doing power safe
> not to me mention that we will have to queue the requests once one is
> pending which can cause other problems like timeouts and etc.

Regarding caching reads and writes, the way LE works from my POV is
that most devices (except ones which rely on Proximity Link Loss) will
have Link Supervision Timeout of a few seconds at least. I have
already seen devices with 30 seconds LSTO.

For these high latency devices (which use conservative connection
parameters for saving battery) some caching is good. But we should
provide ways to let the D-Bus API user know whether the data has
effectively been written, or updated locally. This can be done by
means of D-Bus signals. Which point us back to the reason why we have
Value as a property in the first place.

Also imagine that the API might allow a couple of D-Bus clients
talking to the same device, but using different services. In case of
temporary link loss (or high latency), the values should be kept by
BlueZ, which will then write the value once connection is restored.
Otherwise, you would see many D-Bus clients trying to read/write data
while the link is not ok.

>>> > +           int WriteValue(array{byte} value, int method)
>>> > +
>>> > +               Write the value of the characteristic, with specified
>>> method :
>>> > +               0: Write without response. Always return 0.
>>> > +               1: Write with response. Return server response code.
>>> > +               Other write methods will be added in the future.
>>> > +
>
> D-Bus does not have enum type, so please use string that describes the
> method and the return response, actually for the response it would be
> better to use void if success and use D-Bus error for invalid/error
> responses.

Luiz, while I totally agree with the D-Bus error instead of return
value (and you know about this stuff better than me :), how could we
pass the "custom"  ATT error codes to the client? Any profile can
define their own ATT error codes, and BlueZ cannot know all of them.

>>> > +           boolean Indicate [readwrite]
>>> > +
>>> > +               Indicates whether this characteristic is notified or
>>> not.
>>> > +               If GATT Client Characteristic Configuration descriptor
>>> > +               is not available for this characteristic, or if the
>>> characteristic
>>> > +               properties do not allow this, writing to this property
>>> is not
>>> > +               allowed.
>>> > +
>>> > +           boolean Notify [readwrite]
>>> > +
>>> > +               Indicates whether this characteristic is indicated or
>>> not.
>>> > +               If GATT Client Characteristic Configuration descriptor
>>> > +               is not available for this characteristic, or if the
>>> characteristic
>>> > +               properties do not allow this, writing to this property
>>> is not
>>> > +               allowed.
>
> Notify and Indicate are useless without a way to be notified, so Im
> not sure what is really the point by removing the Value property it
> cannot be signaled via PropertyChanged.

Actually, we have a way to notify which is by registering a
"Characteristics Watcher". See RegisterCharacteristicsWatcher() in
doc/attribute-api.txt.

But, I don't see why have these (writable?) D-Bus properties if we
already have RegisterCharacteristicsWatcher(). Are you suggesting that
confirmations (for indications) should be sent manually by each D-Bus
client? Too error-prone IMHO.

BlueZ knows everything needed to enable notification/indication, and
even send back confirmations in case of indication. If some
characteristic allows either notifications or indications, we could
add a second parameter to RegisterCharacteristicsWatcher().

>
>>> > +           boolean Readable [readonly]
>>> > +
>>> > +               Indicates wether this characteristic value can be read.
>>> > +
>>> > +           boolean WritableNoRsp [readonly]
>>> > +
>>> > +               Indicates whether this characteristic value can be
>>> written without
>>> > +               response.
>>> > +
>>> > +           boolean WritableRsp [readonly]
>>> > +
>>> > +               Indicates whether this characteristic can be written
>>> with response.
>>> > +
>>> > +           boolean WritableSigned [readonly]
>>
>> The WritableSigned is going to be changed to WritableAuth (this is true for both Authenticated link or signed GATT Write commands).
>>
>>> > +
>>> > +               Indicates whether this characteristic can be written
>>> with signed
>>> > +               authentication method.
>>> > +
>>> > +           boolean WritableReliable [readonly]
>>> > +
>>> > +               Indicates whether this characteristic can be written
>>> with the
>>> > +               reliable write procedure.
>>> > +
>
> Create an array of string WriteMethods which represents the methods
> supported by the characteristic.

Agreed. They are readonly anyway. and makes it easier to extend.

I would just go with "SupportedWriteMethods" of something like that :)
(but it is a detail).


Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
