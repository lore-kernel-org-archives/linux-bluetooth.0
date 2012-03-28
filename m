Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC BlueZ 0/2] Add support for find included services
Date: Wed, 28 Mar 2012 15:02:24 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B467253@DNCE02.ent.ti.com>
References: <1332857166-25002-1-git-send-email-jefferson.delfes@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B466EAD@DNCE02.ent.ti.com>
 <CAJdJm_P-+3Ew3rXQzOb=EaN1afK-6tLj54cpY-9NnW0ccXOM+w@mail.gmail.com>
In-Reply-To: <CAJdJm_P-+3Ew3rXQzOb=EaN1afK-6tLj54cpY-9NnW0ccXOM+w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,
 
> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Wednesday, March 28, 2012 1:55 PM
> To: Ganir, Chen
> Cc: Jefferson Delfes; linux-bluetooth@vger.kernel.org
> Subject: Re: [RFC BlueZ 0/2] Add support for find included services
> 
> Hi Chen,
> 
> On Wed, Mar 28, 2012 at 3:30 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> > This patch set looks like it is working properly with 16 bit uuids. I
> tested it with included services as primaries and as secondaries, and I
> even looked for included services inside other included services
> (secondary services which have includes). Take a look at this :
> > [CON][64:9c:8e:e5:a0:e9][LE]> primary
> > attr handle: 0x0001, end grp handle: 0x000b uuid: 00001800-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x000c, end grp handle: 0x0016 uuid: 00001800-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x0017, end grp handle: 0x0019 uuid: 00001801-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x001a, end grp handle: 0x0043 uuid: 00009000-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x0044, end grp handle: 0x0046 uuid: 0000a000-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x0050, end grp handle: 0x0055 uuid: 0000a002-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x0056, end grp handle: 0x005a uuid: 0000a003-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x005b, end grp handle: 0x005d uuid: 0000a004-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x0064, end grp handle: 0x0069 uuid: 0000a001-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x006a, end grp handle: 0x006c uuid: 0000a008-0000-0000-
> 0123-456789abcdef
> > attr handle: 0x0070, end grp handle: 0x0078 uuid: 0000a007-0000-0000-
> 0123-456789abcdef
> > attr handle: 0x0079, end grp handle: 0x007d uuid: 00001802-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x007e, end grp handle: 0x0080 uuid: 00001804-0000-1000-
> 8000-00805f9b34fb
> > attr handle: 0x0081, end grp handle: 0x0083 uuid: 00001803-0000-1000-
> 8000-00805f9b34fb
> > [CON][64:9c:8e:e5:a0:e9][LE]> included 0x01 0x6c
> 
> Just a note, you usually give the start-end ranges of a service. In
> your example database:
> 
> 0x0001 0x000b
> 0x000c 0x0016
> ...
> 
> But I think it should work with any pair of start-end handles.
> 
Lizardo, I know that. I just wanted to get all the included services in the entire range.

> > [CON][64:9c:8e:e5:a0:e9][LE]>
> >
> > This is a secondary service, including another secondary service,
> both do not show up in the primaries list above, as they should:
> > handle: 0x004b, start handle: 0x0047, end handle: 0x0049 uuid:
> 0000a006-0000-1000-8000-00805f9b34fb
> >
> > handle: 0x0051, start handle: 0x004a, end handle: 0x004f uuid:
> 0000a005-0000-1000-8000-00805f9b34fb
> 
> The one above should have been returned by: "included 0x0050 0x0055"
> 
> > handle: 0x005f, start handle: 0x0047, end handle: 0x0049 uuid:
> 0000a006-0000-1000-8000-00805f9b34fb
> 
> This one seems to be inside a secondary service. Given that the "Find
> Included Services" GATT procedure is not recursive, we need to do this
> manually, first obtaining the range for the secondary service that
> contains the 0x005f handle:
> 
> included 0x0064 0x0069
> 
> It should return the line below:
> 
> > handle: 0x0065, start handle: 0x005e, end handle: 0x0063 uuid:
> 0000a005-0000-1000-8000-00805f9b34fb
> 
> Next, run:
> 
> included 0x005e 0x0063
> 
> Which should finally return the previous "handle: 0x005f..." line.
> 
> Chen: for Generic Attribute API, I suppose you will follow this
> recursive method. Also remember to check for cycles, and follow the
> requirements on the Core spec.
> 
> > [CON][64:9c:8e:e5:a0:e9][LE]> included 0x01 0x78
> > However, when I tried to search for included services inside a 128bit
> service, which includes another 128bit secondary service, the gatttool
> first did not return any result, and then I got a segmentation fault.
> 
> Can you send the valgrind output for this case? It should help
> Jefferson fixing the segfault.
> 
I'll try and do that today or tomorrow and send it.

> Thanks for the tests!
> 
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil



Thanks,
Chen Ganir

