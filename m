Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 19:08:48 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] LE based Remote Name Request
Message-ID: <20111118220848.GA17225@samus.indt.org>
References: <4EC6B482.1070106@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC6B482.1070106@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 11:39 Fri 18 Nov, Brian Gix wrote:
> 
> LE does not have a Remote Name Request like BR/EDR has.  It does
> have the ability to fairly efficiently request the remote device
> name, however, which we should implement.  Currently the only
> support we offer for obtaining the remote device name is to pluck it
> out of the Advertising packets (Formatted identically to EIR) which
> works for most devices, but as with BR/EDR, there is no requirement
> that devices include their name in their advertising data.
> 
> The Device Name characteristic is Mandatory, and may only exist once
> for a device.  If it is less than 20 bytes may therefore be read
> with a single ReadByType GATT command (uuid16: 0x2a00) over the full
> 1-0xFFFF range. It must also be readable without security, so can be
> done without first going through SMP.
> 
> We may not want to featurize this particular functionality at all,
> since all of the components to obtain this info is already
> available: We just need to set up an ATT socket in BlueZ, and make
> the request.  However, when we talk about Scanning for devices, and
> automatically forwarding the Remote Name via a MGMT evevnt, the
> precedence is there to supply it from the kernel.  And if we were to
> go down that path, we would also want to simultaneously offer access
> to the equally Mandatory and Unsecured "Appearance" Characteristic
> (uuid16: 0x2a01) which is LE's sort-of equivilent to the BR/EDR
> Class-Of-Device.
> 
> So: What are the feelings about doing Remote Name (And Appearance)
> discovery in the kernel, probably as part of the LE Discovery
> mechanism?  I favor putting it in the kernel, due to the equivalent
> functionality available to BR/EDR there.

I am in favor of this, more because of the Appearance than the Name 
discovery. The Name most well behaved devices will provide through
the Advertising Data, Appearance we can only discover via GATT and
it is very useful for the user.

> 
> Also, there is no coincidence that I offer this RFC at the same time
> as I bring up the Write Signed Command functionality from earlier
> today. Both concern usages of GATT (or at least ATT) in a way not
> currently supported. It is also a case where ideally, we would use a
> low-latency connect-read-disconnect methodology.
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
