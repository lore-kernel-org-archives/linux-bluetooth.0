Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1296064762.2656.137.camel@ubuntuLab1>
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
	<1295984785.2656.98.camel@ubuntuLab1>
	<AANLkTi=4HoUKdda-GCrTQEtLSScuxB4D+btoRy+QsMG_@mail.gmail.com>
	<AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>
	<1296064762.2656.137.camel@ubuntuLab1>
Date: Wed, 26 Jan 2011 14:28:59 -0400
Message-ID: <AANLkTinbmiew-MBN7PxK5ePuObzBbHbqdteaB2nS3nty@mail.gmail.com>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 26, 2011 at 1:59 PM, Brian Gix <bgix@codeaurora.org> wrote:
> Hi Anderson,
>
> On Wed, 2011-01-26 at 09:58 -0400, Anderson Lizardo wrote:
>> On Wed, Jan 26, 2011 at 9:33 AM, Anderson Lizardo
>> <anderson.lizardo@openbossa.org> wrote:
>> > Looks like more a PTS bug, but makes me wonder if it is not better for
>> > BlueZ to have separate procedures instead of this "automatic" usage of
>> > read blob request ?
>>
>> BTW, the test which presented this issue with sending spurious read
>> blob request is named "Read Characteristic Descriptors – by client". I
>> also can see that the behavior you implemented satisfies both "Read
>> Long Characteristic Value - by client" and "Read Long Characteristic
>> Descriptor - by client" tests. All theses tests come from the GATT TS
>> document.
>
> Can you tell me the specific Test Case number(s) that you are having
> difficulty testing?  I do not have a current release of the PTS tool
> available to me at this time, although I do know that PTS is developed
> in parallel, and is just as prone to bugs as the rest of us. I should be
> able to test this stuff against the PTS guys at UPF week after next, and
> talk to the guys who are writing it.

At least these break with the current implementation:

TP/GAR/CL/BV-06-C (PTS does not expect a Read blob request after Read Request)
TP/GAR/CL/BI-12-C (test procedure expects Read Blob Request, not Read Request)
TP/GAR/CL/BI-13-C (same as above)
TP/GAR/CL/BI-14-C (same as above)
TP/GAR/CL/BI-28-C (same as above)
TP/GAR/CL/BV-07-C (same as above)

Except for the first test case, the specific requirement for a Read
Blob Request is defined on the test procedure of the GATT TS document
itself, so in these cases I don't think it's PTS bug.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
