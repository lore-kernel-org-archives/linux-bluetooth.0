Return-Path: <cyrus@holtmann.org>
Message-ID: <55B1022F.8080602@linux.intel.com>
Date: Thu, 23 Jul 2015 17:03:11 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Arend Van Spriel <arend@broadcom.com>
Subject: Re: [PATCH 1/3] Bluetooth: hci_uart: Add PM for BCM2E39
References: <1435929751-26831-1-git-send-email-frederic.danis@linux.intel.com> <55A7D771.9020705@linux.intel.com> <E0D3336E15B58B4294723AC879BA5E9426DDF7@IRVEXCHMB15.corp.ad.broadcom.com>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E9426DDF7@IRVEXCHMB15.corp.ad.broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Ilya,

On 16/07/2015 20:54, Ilya Faenson wrote:
> Hi Fred,
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Frederic Danis
> Sent: Thursday, July 16, 2015 12:10 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/3] Bluetooth: hci_uart: Add PM for BCM2E39
>
> Ping ?
>
> On 03/07/2015 15:22, Frederic Danis wrote:
> > Retrieve "shutdown" and "device_wakeup" GPIOs from ACPI.
> > Set device off during platform device enumeration.
> > Set device on only when it is attached.
>
> IF: Sorry for the delay in responding. I am not actively working on
> the similar DT driver at the moment as we have hit a DT maintainer
> roadblock for its development. I do not read this bulletin board much
> therefore. Great seeing a first take on the Broadcom BT UART ACPI
> driver! Looks like a good start to me. A few comments:
> if01. I would turn the device on when the BCM protocol is opened and
> turn the device off when the protocol is closed.

This is what I try to said by "Set device on only when it is attached.".

> if02. I would strongly encourage you to start supporting the runtime
> suspend upon a period of inactivity, resume and the
> interrupt-triggered wake as related power savings are significant. You
> would obviously need to set reasonable sleep parameters via the VSC
> then. Of course, we would also want to flow control the device in
> suspend time to avoid character loss. See my DT patches for the VSC
> and UART flow control particulars.

This is in my todo list.

> if03. We would also want at least to suspend and resume the device
> when the platform suspends/resumes as a whole.
> if04. A great enhancement would have also been to make a decision
> whether to suspend or turn off the device at the time of the platform
> suspend. That would require BT knowledge of what's paired etc. We
> would obviously need to resume or turn it back on at the platform
> resume time accordingly.
> if05. We should ideally support running on the Broadcom BT UART ACPI
> node as it ships now in hundreds of laptop/tablet/phone models while
> you apparently rely on Linux specific enhancements to this extent. We
> want to let users dual boot with BT working fine in either operating
> system. Would you publish a relevant DSL snippet of what you've done
> in the ACPI on your test platform?

I did not change anything in the ACPI table of the T100.
Here is what I extracted from T100 related to BCM2E39 :

     Scope (_SB.URT1)
     {
         Device (BTH0)
         {
             Name (_HID, "BCM2E39")  // _HID: Hardware ID
             Name (_DEP, Package (0x03)  // _DEP: Dependencies
             {
                 GPO0,
                 GPO2,
                 URT1
             })
             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 Return (0x0F)
             }

             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
             {
                 Name (UBUF, ResourceTemplate ()
                 {
                     UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne,
                         0xFC, LittleEndian, ParityTypeNone, 
FlowControlHardware,
                         0x0020, 0x0020, "\\_SB.URT1",
                         0x00, ResourceConsumer, ,
                         )
                     Interrupt (ResourceConsumer, Edge, ActiveHigh, 
ExclusiveAndWake, ,, )
                     {
                         0x00000046,
                     }
                     GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, 
IoRestrictionOutputOnly,
                         "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                         )
                         {   // Pin list
                             0x0034
                         }
                     GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, 
IoRestrictionOutputOnly,
                         "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                         )
                         {   // Pin list
                             0x0009
                         }
                 })
                 Name (PBUF, ResourceTemplate ()
                 {
                     UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne,
                         0xFC, LittleEndian, ParityTypeNone, 
FlowControlNone,
                         0x0020, 0x0020, "\\_SB.URT1",
                         0x00, ResourceConsumer, ,
                         )
                     Interrupt (ResourceConsumer, Edge, ActiveHigh, 
ExclusiveAndWake, ,, )
                     {
                         0x00000046,
                     }
                     GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, 
IoRestrictionOutputOnly,
                         "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                         )
                         {   // Pin list
                             0x0009
                         }
                     GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, 
IoRestrictionOutputOnly,
                         "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                         )
                         {   // Pin list
                             0x0034
                         }
                 })
                 Return (UBUF)
             }
         }
     }



Regards

Fred

-- 
Frederic Danis Open Source Technology Center
frederic.danis@intel.com Intel Corporation

