Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110609190943.GC2533@joana>
References: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com>
	<BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com>
	<BANLkTi=qBBOkmcS4SD+QJ-BLu7is=ghLTg@mail.gmail.com>
	<A4DF21E7-112D-4AA7-9043-90C744A33CE0@signove.com>
	<20110609122805.GA8875@dell.ccr.corp.intel.com>
	<82461851-7132-415D-A9D1-AE5C1B64440E@signove.com>
	<20110609190943.GC2533@joana>
Date: Fri, 10 Jun 2011 11:12:13 -0300
Message-ID: <BANLkTin_0ViMcqPQBE54q18R4GBDAAETnw@mail.gmail.com>
Subject: Re: Read clock not implemented in management
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Elvis Pfutzenreuter <epx@signove.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Santiago Carot <sancane@gmail.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Jun 9, 2011 at 4:09 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> * Elvis Pfutzenreuter <epx@signove.com> [2011-06-09 09:42:42 -0300]:
>
>> On Jun 9, 2011, at 9:28 AM, Johan Hedberg wrote:
>>
>> > Hi,
>> >
>> > On Thu, Jun 09, 2011, Elvis Pfutzenreuter wrote:
>> >>> Coming back to this issue. I'm not caught up with this stuff and I
>> >>> dont know if there are any special reason to not provide a read clock
>> >>> functionality in the bluetooth API. although I think it's a pity  to
>> >>> restrict MCAP features after the good work Elvis did in CSP.
>> >>
>> >> More to the point, could we implement HCI read clock for mgmt interface? Or
>> >> it simply won't have read clock by design?
>> >
>> > There's no obvious reason why it couldn't have it. However other means
>> > should be considered too, e.g. would it be cleaner to get the info
>> > directly through the socket (using a socket option or something
>> > similar)? Or was this already considered when the HCI socket solution
>> > was implemented?
>>
>> Not exactly, I just made use of hci_read_clock() that already existed in BlueZ
>> API, and copied the code into hciops.
>>
>> Getting clock via a socket option sounds better to me since a) we need
>> connection ACL to read it, getting it through a L2CAP socket would imply the
>> ACL; b) it would allow other apps to use the feature (e.g. PyBluez that
>> currently reads clock using an HCI socket).
>
> Getting it from a L2CAP socket does not seems right. If you want to read a
> clock value, probably the ACL link is already there. Implement this on
> the management interface is the best option.
>
>        Gustavo
>

We gonna need a similar approach to read the Tx Power and RSSI of an active
connection to implement the Proximity Profile(Path Loss Service). It'd
be good to
keep consistency, using the same approach if possible.

What are your arguments against L2CAP socket options? Blocking: wait
for response
of the HCI commands. Something else?

If we agree to use management interface I think we need to add another
channel, use
HCI_CHANNEL_CONTROL doesn't look correct to me.

BR,
Claudio.
