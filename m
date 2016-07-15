Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Please review and upstream to bluetooth-next
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DAC39EC0A5DE12469D14E5A0B14E6CF5054737BC@BGSMSX108.gar.corp.intel.com>
Date: Fri, 15 Jul 2016 08:50:33 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"An, Tedd" <tedd.an@intel.com>
Message-Id: <4367AF5D-B70A-4B50-8423-01D68CC660A3@holtmann.org>
References: <DAC39EC0A5DE12469D14E5A0B14E6CF505470BE4@BGSMSX108.gar.corp.intel.com> <DAC39EC0A5DE12469D14E5A0B14E6CF505473770@BGSMSX108.gar.corp.intel.com> <0331C8DC-83C0-4737-A063-5BE7B01845CB@holtmann.org> <DAC39EC0A5DE12469D14E5A0B14E6CF5054737BC@BGSMSX108.gar.corp.intel.com>
To: "G, Jaya P" <jaya.p.g@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaya,

please do not top-post on this mailing list. It is against its etiquette.

> I am sending the first patch to Bluetooth-next.
> Regarding the coding guidelines, Attached a new patchset with the coding guidelines, except for removing the kobject changes.

The kobject exposing from the driver is not acceptable. That is something that is just a plain hack. It is not a clean solution and can not be accepted upstream.

> And regarding this requirement, this came for google chrome  to check the 
> Different SKU's version on the go rather than issuing read version command for the controller.

What is the difference? I do not get it. It is specific to Intel anyway. How is this done for Broadcom or Marvell controllers? Someone needs to shed some light into this requirement. Either this is a common way for all controllers to expose a vendor revision string or it is not useful in the broader sense at all.

> And so, the design proposed that we expose a kobject file for this from btusb	. 
> And for your understanding, the Intel FW file pushed for the controller will have these 3 components 
> HW Variant : 0x000000
> FW Variant: 0x0000000000
> Patch number: 0x00
> Which is not the same for all the vendors, this information required to check which controller is 
> Inserted in our linux pc, so an additional information along VID, PID information which is same different Intel Controllers.
> This is required because, Intel SKU's have same VID,PID for different chips i.e for XX B0, XX B1 will have the same VID, PID.

I know how our SKUs work, but exposing the raw numbers is still not doing much in the end. You want to decode the numbers into something real. That is what bluemoon actually does.

> And the Linux PC or the OEM that we are supporting can have only one Bluetooth controller, so the
> Issue that you mention never happens.

Please forget about this kind of reasoning right away. That does not work with upstream. This argument alone would be a reason to reject the patch. This Linux kernel runs on multiple systems and if I attach two Intel controllers to my desktop system, I want them to work. Full stop here. You can not break other peoples machines only because this is out of scope for you. This means any design has to take this into account.

Regards

Marcel

