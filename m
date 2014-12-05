Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141015145000.GA26735@t440s.fdxtended.com>
References: <CAB0Wyv=3HBi6wnStgjGFwg7HUODoYj3mZBVTnZnC+tb+Mipyxw@mail.gmail.com>
	<20141015145000.GA26735@t440s.fdxtended.com>
Date: Fri, 5 Dec 2014 17:32:11 +0800
Message-ID: <CAB0WyvnOCKYXoCt8yRQRSP-_Jn8-y1kHVu88KrBsp9AXFw+-hA@mail.gmail.com>
Subject: Re: BT-4.1 features (e.g. concurrent GAP operations) support
From: "Min Jun,Xi" <xi.minjun@gmail.com>
To: "Min Jun,Xi" <xi.minjun@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 15, 2014 at 10:50 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Oct 15, 2014, Min Jun,Xi wrote:
>> Where can I find the latest BT-4.1 features support for
>> Bluetooth-subsystem and BlueZ?
>
> I don't think the detailed feature status is documented anywhere but the
> code, so the most reliable way would be to get the latest user space and
> kernel trees and experiment with them yourself.
>
>> In the 4.1 features, I know connection-oriented channels has been supported;
>>
>> I have one question about this new feature (Bluetooth Specification
>> Version 4.1[Vol 3] page 293 of 668, ): "2.2.2.5 Concurrent Operation
>> in Multiple GAP Roles"; this feature is very useful to support
>> mesh-like topology,
>>
>> From the description in chapter 2.2.2.5, the controller should support
>> operations in multiple GAP roles concurrently, and the host should
>> read the supported Link Layer States and State combinations from the
>> Controller before any procedures or modes are used.

Sorry, I might not make it clear. The concurrent multiple GAP
operations include more operations than "both scan and advertise
at the same time " as you said.

It should follow the Link Layer States and State combinations as BT4.1
core spec or later.

On page 33 of 174, BLUETOOTH SPECIFICATION Version 4.1 [Vol 6], it says that:

1.1.1 State and Role Combination Restrictions
The Link Layer may optionally support multiple state machines. If it
does sup- port multiple state machines, then:
• The Link Layer in the Connection State may operate in the Master
Role and Slave Role at the same time.
• The Link Layer in the Connection State operating in the Slave Role
may have multiple connections.
• The Link Layer in the Connection State operating in the Master Role
may have multiple connections.
• All other combinations of states and roles may also be supported.
A Link Layer implementation is not required to support all the
possible state combinations that are allowed by this specification.

You can find more combinations that BT4.0 core spec doesn't allow.

>>
>> Can anyone tell me if the bluetooth subsystem has supported the Link
>> Layer states and the States combinations? I am also looking for the
>> Controller support operations in multiple GAP roles concurrently, can
>> anyone know if CSR/Nordic/Broadcom has got the USB dongles which
>> supports concurrent operation and can used under Linux?
>
> We don't specifically look at the controller supported states at the
> moment but simply stick to what we know existing controllers to be
> capable of. This means that you will be able to both scan and advertise
> at the same time (i.e. act as central and peripheral). What we do limit
> (since we don't know if HW that supports it) is new LE connection
> creation when there already is an existing slave-role connection.
>
Sorry, I didn't make it clear in my last mail


I download the latest bluez (currently bluez-5.25) source code, and
from hciconfig.c, we can see there's one sub-command called
"lestates", which will detect and list all the supported link layer
states for the specified HCI interface.

Unfortunately,  the combinations are not updated following the 4.1 and
4.2 core specs.

At least from page 33 of 174, BLUETOOTH SPECIFICATION Version 4.1 [Vol
6], it says that

     1.1.1 State and Role Combination Restrictions
     The Link Layer may optionally support multiple state machines. If
it does sup- port multiple state machines, then:
      • The Link Layer in the Connection State may operate in the
Master Role and Slave Role at the same time.
      • The Link Layer in the Connection State operating in the Slave
Role may have multiple connections.
      • The Link Layer in the Connection State operating in the Master
Role may have multiple connections.
      • All other combinations of states and roles may also be supported.
     A Link Layer implementation is not required to support all the
possible state combinations that are allowed by this specification.

Compared the current state combinations listed in hciconfig.c (line 119-153):

    static void print_le_states(uint64_t states)
    {
    int i;
    const char *le_states[] = {
    "Non-connectable Advertising State" ,
    "Scannable Advertising State",
    "Connectable Advertising State",
    "Directed Advertising State",
    "Passive Scanning State",
    "Active Scanning State",
    "Initiating State/Connection State in Master Role",
    "Connection State in the Slave Role",
    "Non-connectable Advertising State and Passive Scanning State combination",
    "Scannable Advertising State and Passive Scanning State combination",
    "Connectable Advertising State and Passive Scanning State combination",
    "Directed Advertising State and Passive Scanning State combination",
    "Non-connectable Advertising State and Active Scanning State combination",
    "Scannable Advertising State and Active Scanning State combination",
    "Connectable Advertising State and Active Scanning State combination",
    "Directed Advertising State and Active Scanning State combination",
    "Non-connectable Advertising State and Initiating State combination",
    "Scannable Advertising State and Initiating State combination",
    "Non-connectable Advertising State and Master Role combination",
    "Scannable Advertising State and Master Role combination",
    "Non-connectable Advertising State and Slave Role combination",
    "Scannable Advertising State and Slave Role combination",
    "Passive Scanning State and Initiating State combination",
    "Active Scanning State and Initiating State combination",
    "Passive Scanning State and Master Role combination",
    "Active Scanning State and Master Role combination",
    "Passive Scanning State and Slave Role combination",
    "Active Scanning State and Slave Role combination",
    "Initiating State and Master Role combination/Master Role and
Master Role combination",
    NULL
    };

the hciconfig command doesn't try to detect if the interface supports
multiple state machines and if the interface supports following state
combinations:
      • The Link Layer in the Connection State may operate in the
Master Role and Slave Role at the same time.
      • The Link Layer in the Connection State operating in the Slave
Role may have multiple connections.
      • The Link Layer in the Connection State operating in the Master
Role may have multiple connections.
      • All other combinations of states and roles may also be supported.

Based on this situation, I don't think what you said here is correct.
The latest Bluez implementation doesn't follow Bluetooth 4.1 core spec
to detect the LE device's capability.

> Johan



-- 
Best regards,
Xi Minjun
