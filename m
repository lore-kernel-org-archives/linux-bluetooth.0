Return-Path: <cyrus@holtmann.org>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
From: Brian Gix <bgix@codeaurora.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTinbmiew-MBN7PxK5ePuObzBbHbqdteaB2nS3nty@mail.gmail.com>
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
	 <1295984785.2656.98.camel@ubuntuLab1>
	 <AANLkTi=4HoUKdda-GCrTQEtLSScuxB4D+btoRy+QsMG_@mail.gmail.com>
	 <AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>
	 <1296064762.2656.137.camel@ubuntuLab1>
	 <AANLkTinbmiew-MBN7PxK5ePuObzBbHbqdteaB2nS3nty@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 Jan 2011 11:57:47 -0800
Message-ID: <1296071867.2656.202.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2011-01-26 at 14:28 -0400, Anderson Lizardo wrote:
> On Wed, Jan 26, 2011 at 1:59 PM, Brian Gix <bgix@codeaurora.org> wrote:
> > Hi Anderson,
> >
> > On Wed, 2011-01-26 at 09:58 -0400, Anderson Lizardo wrote:
> >> On Wed, Jan 26, 2011 at 9:33 AM, Anderson Lizardo
> >> <anderson.lizardo@openbossa.org> wrote:
> >> > Looks like more a PTS bug, but makes me wonder if it is not better for
> >> > BlueZ to have separate procedures instead of this "automatic" usage of
> >> > read blob request ?
> >>
> >> BTW, the test which presented this issue with sending spurious read
> >> blob request is named "Read Characteristic Descriptors – by client". I
> >> also can see that the behavior you implemented satisfies both "Read
> >> Long Characteristic Value - by client" and "Read Long Characteristic
> >> Descriptor - by client" tests. All theses tests come from the GATT TS
> >> document.
> >
> > Can you tell me the specific Test Case number(s) that you are having
> > difficulty testing?  I do not have a current release of the PTS tool
> > available to me at this time, although I do know that PTS is developed
> > in parallel, and is just as prone to bugs as the rest of us. I should be
> > able to test this stuff against the PTS guys at UPF week after next, and
> > talk to the guys who are writing it.
> 
> At least these break with the current implementation:
> 
> TP/GAR/CL/BV-06-C (PTS does not expect a Read blob request after Read Request)

This sounds like a PTS failure.  The actual MSC will be followed, and
the fact that a follow READ_BLOB is made is outside the scope of the
test.  If the PTS were working as a properly functioning server it
should respond with *something* even if it is "Command Not Supported" or
something, which would be handled correctly by bluez.

> TP/GAR/CL/BI-12-C (test procedure expects Read Blob Request, not Read Request)



> TP/GAR/CL/BI-13-C (same as above)
> TP/GAR/CL/BI-14-C (same as above)

These two tests will need special APIs written which do not necessarily
need to be exposed as upper layer APIs. The test in both cases is to
ensure that the client can properly handle error returns from the
server.  These are not tests that a high level application would
typically be able to run, since using an invalid offset or handle should
never come up.  However, these tests were likely added as robustness
tests for client to prevent, for example, denial of service attacks, or
other robustness issues made famous in the BT world by tools such as
Codenomicon's robustness suite.

Therefore, for these two tests, a test-only GATT API could be written
that specifies specific Handle and Offset arguments to a bare ATT
READ_BLOB call.  But I would argue against including this as an upper
layer (D-Bus) API.


> TP/GAR/CL/BI-28-C (same as above)

The above Test API would again work for this. However, again, a properly
function high level Application should never be issuing an actual Read
to an attribute that has been flagged as Write Only, or Security
Required (withoutout the security in place).

> TP/GAR/CL/BV-07-C (same as above)

I believe this Test Case itself may be flawed.  While it can also be
tested with the above described Test API, the "Read Long Characteristic
Values" GATT functionality is explicitly allowed as a chain from the
single pkt "Read Characteristic Value", from the Note (3rd Paragraph) of
page 562 in the Core 4.0 specification for GATT. (this is page 1922 of
the full Cove 4.0 PDF file) --> "Note: The Read Blob Request may be used
to read the remainder of an Attribute where the first part was read
using a simple Read Request."

The test cases are intended to ensure that the functionality used are
used correctly.  They are not intended to force the usage of unneeded
functionality.

I will talk to the PTS guys at UPF, and make sure that the PIXIT lists
are setup such that the tests required for qualification correctly
mandate the correct subset of test cases as required by the ruling
specification.

> 
> Except for the first test case, the specific requirement for a Read
> Blob Request is defined on the test procedure of the GATT TS document
> itself, so in these cases I don't think it's PTS bug.
> 
> Regards,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

