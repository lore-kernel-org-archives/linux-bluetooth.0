Return-Path: <cyrus@holtmann.org>
Message-ID: <5453A5D5.3060801@intel.com>
Date: Fri, 31 Oct 2014 16:08:05 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: HCI H5 peer reset detection
References: <1412780068-19449-1-git-send-email-loic.poulain@intel.com> <20141031083908.GB18888@t440s.P-661HNU-F1>
In-Reply-To: <20141031083908.GB18888@t440s.P-661HNU-F1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

This is just the expected behavior as described int the specification:

UART Spec says:
If the UART synchronization is lost in the communication from Host to Host
Controller, then the Host Controller shall send a Hardware Error Event 
to tell
the Host about the synchronization error. The Host Controller will then 
expect to
receive an HCI_Reset command from the Host in order to perform a reset. The
Host Controller will also use the HCI_Reset command in the byte stream from
Host to Host Controller to re-synchronize.

H5 part says:
If a SYNC message is received while in the Active State, it is assumed 
that the
peer device has reset. The local device should therefore perform a full 
reset of
the upper stack, and start Link Establishment again at the Uninitialized 
State.

So, hardware error seems the best way to warn host stack about the H5 
controller
reset.

Regarding the "upper stack", I know that Bluedroid restarts on hardware 
error, but
I ignore the Bluez behavior.

Regards,
Loic

On 31/10/2014 09:39, Johan Hedberg wrote:
> Hi Loic,
>
> On Wed, Oct 08, 2014, Loic Poulain wrote:
>> This patch resets the HCI H5 driver data/state to unitialized and
>> reports an HCI hardware error event to notify the upper stack that
>> HCI synchronization has been lost. H5 will be re-synchronized and
>> upper stack should generate an HCI Reset command.
> I couldn't find anywhere where we'd currently do this "upper stack"
> behavior that you describe (there . Did you have some follow-up patches to
> implement that?
>
> Johan

-- 
Intel Open Source Technology Center
http://oss.intel.com/

