Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35B17FE5076C7040809188FBE7913F983F84405C72@SC1EXMB-MBCL.global.atheros.com>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>
	<AANLkTinS-NhD3FhqcnpNRRdHKxn4mm+2zTmysrSeSjW8@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F8440581D@SC1EXMB-MBCL.global.atheros.com>
	<AANLkTinnjXuAOBTY8VZz756VdrDFv0-OVKPNkwWbxi9-@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F84405C72@SC1EXMB-MBCL.global.atheros.com>
Date: Tue, 26 Oct 2010 22:01:58 -0300
Message-ID: <AANLkTim7iLhzALuxX07veEwVEObwcfVFuQEpnjTVABAn@mail.gmail.com>
Subject: Re: [RFC] LE connections and advertising management
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Mike Tsai <Mike.Tsai@atheros.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Tue, Oct 26, 2010 at 6:10 PM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
> [Mike Tsai]
> Hi Claudio,
>
>        I look at the API and it is well-defined with high level of abstraction. However, I did have a few questions here, hopefully you can answer them,
>
>        On Client side:
>
>                1. I see you didn't offer any service discovery API for client to discover the server service database (basically to get the attribute handles). So I assume that you consider GATT discovery procedure works the same way as SDP, done automatically by GATT after link is established without application's initiative. Am I correct?
>
>                2. The characteristic descriptor set via SetProperty API is limited to the 6 characteristic descriptors defined in GATT spec. However, there could be profile specific characteristic descriptors beyond these, will the SetProperty able to support these?
>
>                3. The characteristic monitoring is set up via 128 bits UUID. Do you have mechanism to handle duplicated characteristic within a server's database? How do you identify them via your API?
>
>
>        On Server side:
>
>                1. Is there an API that allows server application to register new attributes? (primary service, characteristic, included service, et al),
>
> Regards,
>
> Mike

Client side:
Yes. ALL characteristics are fetched after "create the device"
procedure.  This approach is wrong, some characteristics requires
encryption, authentication or authorization. Another aspect is that we
need to avoid excessive transactions. The idea now is try to search
for the primary service information only and "probe" the clients that
match with the registered service UUID. When "probed" the clients will
receive the GAttrib instance and the primary service handles range. It
is up to them to decide which attributes are relevant. Note that the
clients are only another "layer" implementing profile specific
features inside BlueZ.

It is a little bit unclear to me at the moment, but we can expose
Profile specific features. Such as threshold, alert level, ...

Is it allowed duplicated UUIDs for the same primary service? We are
not handling this right now.
It seems that you already have a proprietary implementation ;-)

Server side:
No API. We wrote an attribute server for testing purpose only. But we
will address this soon.

Regards,
Claudio
