Return-Path: <cyrus@holtmann.org>
From: "Brian Redding" <bredding@codeaurora.org>
To: "'Claudio Takahasi'" <claudio.takahasi@openbossa.org>
Cc: "'BlueZ development'" <linux-bluetooth@vger.kernel.org>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>	<35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>	<AANLkTinS-NhD3FhqcnpNRRdHKxn4mm+2zTmysrSeSjW8@mail.gmail.com>	<35B17FE5076C7040809188FBE7913F983F8440581D@SC1EXMB-MBCL.global.atheros.com> <AANLkTinnjXuAOBTY8VZz756VdrDFv0-OVKPNkwWbxi9-@mail.gmail.com>
In-Reply-To: <AANLkTinnjXuAOBTY8VZz756VdrDFv0-OVKPNkwWbxi9-@mail.gmail.com>
Subject: RE: [RFC] LE connections and advertising management
Date: Mon, 25 Oct 2010 14:27:11 -0500
Message-ID: <000001cb747a$9fd61270$df823750$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> GAttrib will not be exposed to the UI. UI needs to access BlueZ GATT
> clients services using D-Bus.
> GATT clients in general will have two pieces:
> 1- UI: Qt, GTK, python, ...
> 2- "module" in the BlueZ for profile specific tasks and D-Bus service
> interface.

> You can find the current attribute API in the file: doc/attribute-api.txt

> Claudio

Hi Claudio,

Are there still interfaces that need to be added to attribute-api.txt to handle client and server characteristic configuration as well as presentation and aggregate formats?  I see those as TODO items but wondered if the APIs for them have been defined yet.

One thing to note on the server API is that a GATT-based profile could specify behavior on a characteristic value that when the characteristic value is read to perform some action in a similar way as a hardware register.  It appears that the notes I'm reading in the code thus far only consider changes (or writes) to characteristic values for the watch code.

Also does the current API handle included services?

The Bluetooth SIG is beginning to look at 3rd party application developer API's for both client and servers for various platforms so understanding what is currently defined in BlueZ and what still needs to be added would be useful.

Thanks,
Brian
---
Brian A. Redding
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


