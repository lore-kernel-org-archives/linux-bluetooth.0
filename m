Return-Path: <cyrus@holtmann.org>
From: "Brian Redding" <bredding@codeaurora.org>
To: "'Mike Tsai'" <Mike.Tsai@Atheros.com>,
	"'Claudio Takahasi'" <claudio.takahasi@openbossa.org>
Cc: "'BlueZ development'" <linux-bluetooth@vger.kernel.org>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>	<35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>	<AANLkTinS-NhD3FhqcnpNRRdHKxn4mm+2zTmysrSeSjW8@mail.gmail.com>	<35B17FE5076C7040809188FBE7913F983F8440581D@SC1EXMB-MBCL.global.atheros.com>	<AANLkTinnjXuAOBTY8VZz756VdrDFv0-OVKPNkwWbxi9-@mail.gmail.com>	<35B17FE5076C7040809188FBE7913F983F84405C72@SC1EXMB-MBCL.global.atheros.com> <AANLkTim7iLhzALuxX07veEwVEObwcfVFuQEpnjTVABAn@mail.gmail.com> <35B17FE5076C7040809188FBE7913F983F847B44A8@SC1EXMB-MBCL.global.atheros.com>
In-Reply-To: <35B17FE5076C7040809188FBE7913F983F847B44A8@SC1EXMB-MBCL.global.atheros.com>
Subject: RE: [RFC] LE connections and advertising management
Date: Tue, 2 Nov 2010 15:23:29 -0500
Message-ID: <000201cb7acb$d05ac330$71104990$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> [Claudio]
> Is it allowed duplicated UUIDs for the same primary service? We are
> not handling this right now.
> It seems that you already have a proprietary implementation ;-)
> 
> [Mike Tsai] I think it is probably not allowed to duplicate
> characteristic within the same primary services. However, there may be
> duplicated primary services within a server or duplicated included
> service within a server, or same characteristic inside 2 different
> primary services. So I don't know if you have any mechanism to let
> GAttrib get the correct characteristic within all these duplicated
> services by just passing the 128 bits UUID?

The GATT places no limitation on multiple instances of characteristics or
services.  The recommendation to profile writers when duplicate
characteristics exist within a service is that each characteristic has a
characteristic presentation descriptor that distinguishes each instance of
the characteristic.  The same would apply to multiple instances of a
service.  There are other methods to distinguish multiple instances of
services and characteristics including different UUIDs so there isn't a
single approach.  The approach though is specified by the profile.

Brian
---
Brian A. Redding
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

