Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Dec 2014 11:57:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Min Jun,Xi" <xi.minjun@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT-4.1 features (e.g. concurrent GAP operations) support
Message-ID: <20141205095724.GA10410@t440s.lan>
References: <CAB0Wyv=3HBi6wnStgjGFwg7HUODoYj3mZBVTnZnC+tb+Mipyxw@mail.gmail.com>
 <20141015145000.GA26735@t440s.fdxtended.com>
 <CAB0WyvnOCKYXoCt8yRQRSP-_Jn8-y1kHVu88KrBsp9AXFw+-hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAB0WyvnOCKYXoCt8yRQRSP-_Jn8-y1kHVu88KrBsp9AXFw+-hA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 05, 2014, Min Jun,Xi wrote:
> At least from page 33 of 174, BLUETOOTH SPECIFICATION Version 4.1 [Vol
> 6], it says that
> 
>      1.1.1 State and Role Combination Restrictions
>      The Link Layer may optionally support multiple state machines. If
> it does sup- port multiple state machines, then:
>       • The Link Layer in the Connection State may operate in the
> Master Role and Slave Role at the same time.
>       • The Link Layer in the Connection State operating in the Slave
> Role may have multiple connections.
>       • The Link Layer in the Connection State operating in the Master
> Role may have multiple connections.
>       • All other combinations of states and roles may also be supported.
>      A Link Layer implementation is not required to support all the
> possible state combinations that are allowed by this specification.
> 
> Compared the current state combinations listed in hciconfig.c (line 119-153):
> 
>     static void print_le_states(uint64_t states)
>     {
>     int i;
>     const char *le_states[] = {
>     "Non-connectable Advertising State" ,
>     "Scannable Advertising State",
>     "Connectable Advertising State",
>     "Directed Advertising State",
>     "Passive Scanning State",
>     "Active Scanning State",
>     "Initiating State/Connection State in Master Role",
>     "Connection State in the Slave Role",
>     "Non-connectable Advertising State and Passive Scanning State combination",
>     "Scannable Advertising State and Passive Scanning State combination",
>     "Connectable Advertising State and Passive Scanning State combination",
>     "Directed Advertising State and Passive Scanning State combination",
>     "Non-connectable Advertising State and Active Scanning State combination",
>     "Scannable Advertising State and Active Scanning State combination",
>     "Connectable Advertising State and Active Scanning State combination",
>     "Directed Advertising State and Active Scanning State combination",
>     "Non-connectable Advertising State and Initiating State combination",
>     "Scannable Advertising State and Initiating State combination",
>     "Non-connectable Advertising State and Master Role combination",
>     "Scannable Advertising State and Master Role combination",
>     "Non-connectable Advertising State and Slave Role combination",
>     "Scannable Advertising State and Slave Role combination",
>     "Passive Scanning State and Initiating State combination",
>     "Active Scanning State and Initiating State combination",
>     "Passive Scanning State and Master Role combination",
>     "Active Scanning State and Master Role combination",
>     "Passive Scanning State and Slave Role combination",
>     "Active Scanning State and Slave Role combination",
>     "Initiating State and Master Role combination/Master Role and
> Master Role combination",
>     NULL
>     };
> 
> the hciconfig command doesn't try to detect if the interface supports
> multiple state machines and if the interface supports following state
> combinations:
>       • The Link Layer in the Connection State may operate in the
> Master Role and Slave Role at the same time.
>       • The Link Layer in the Connection State operating in the Slave
> Role may have multiple connections.
>       • The Link Layer in the Connection State operating in the Master
> Role may have multiple connections.
>       • All other combinations of states and roles may also be supported.

I don't really see what hciconfig has to do with supporting or not
supporting the states. What you've quoted is this tool's ability to read
what the HW supports which indeed is missing decoding of the new states
(patches for that are welcome :)

It has however nothing to do with supporting or not supporting the
states. That's something that would happen completely on the kernel
side.

> Based on this situation, I don't think what you said here is correct.
> The latest Bluez implementation doesn't follow Bluetooth 4.1 core spec
> to detect the LE device's capability.

You might want to re-read what I said then. I never said that we act on
the supported states value. We do read it and store it (in
hdev->le_states) but that's all for now. That said, we should indeed add
support for the new state combinations and allow the kernel to enter
them when the hardware support is available (and again patches are
welcome for that as well :)

Johan
