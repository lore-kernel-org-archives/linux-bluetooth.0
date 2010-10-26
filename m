Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000001cb747a$9fd61270$df823750$@org>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>
	<AANLkTinS-NhD3FhqcnpNRRdHKxn4mm+2zTmysrSeSjW8@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F8440581D@SC1EXMB-MBCL.global.atheros.com>
	<AANLkTinnjXuAOBTY8VZz756VdrDFv0-OVKPNkwWbxi9-@mail.gmail.com>
	<000001cb747a$9fd61270$df823750$@org>
Date: Mon, 25 Oct 2010 23:51:46 -0300
Message-ID: <AANLkTimTgRV=Ang1JFQpOKXc0bVA6PSOA8WAUo4B7_Wv@mail.gmail.com>
Subject: Re: [RFC] LE connections and advertising management
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Brian Redding <bredding@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Mon, Oct 25, 2010 at 4:27 PM, Brian Redding <bredding@codeaurora.org> wrote:
> Hi Claudio,
>
> Are there still interfaces that need to be added to attribute-api.txt to handle client and server characteristic configuration as well as presentation and aggregate formats?  I see those as TODO items but wondered if the APIs for them have been defined yet.
>
> One thing to note on the server API is that a GATT-based profile could specify behavior on a characteristic value that when the characteristic value is read to perform some action in a similar way as a hardware register.  It appears that the notes I'm reading in the code thus far only consider changes (or writes) to characteristic values for the watch code.
>
> Also does the current API handle included services?
>
> The Bluetooth SIG is beginning to look at 3rd party application developer API's for both client and servers for various platforms so understanding what is currently defined in BlueZ and what still needs to be added would be useful.
>
> Thanks,
> Brian
> ---
> Brian A. Redding
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

The API to address characteristic descriptors is still being defined.
We are focusing in the advertising and connection management at the
moment. If you have suggestion of how to represent the descriptors in
the attribute API, suggestions are welcome!

There isn't a server API at the moment, we implemented a server for
testing purpose only. But we will need to define it soon.
Which pages/section of the spec describes this read characteristic behavior?

Included services are not supported by our client. How important is
it? It is mandatory for qualification?

Regards,
Claudio.
