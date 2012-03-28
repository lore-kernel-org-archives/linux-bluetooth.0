Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC BlueZ 0/2] Add support for find included services
Date: Wed, 28 Mar 2012 07:30:11 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B466EAD@DNCE02.ent.ti.com>
References: <1332857166-25002-1-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1332857166-25002-1-git-send-email-jefferson.delfes@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jefferson,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Jefferson Delfes
> Sent: Tuesday, March 27, 2012 4:06 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Jefferson Delfes
> Subject: [RFC BlueZ 0/2] Add support for find included services
> 
> This patch series introduces support for find included services.
> The interactive mode of gatttool receives a new command "included" that
> uses gatt_find_included to find these services in given range.
> 
> We don't have any way to test find included services with 128-bit
> UUID128. Yet in PTS, there is only a 16-bit UUID test case. So if
> anyone can test this, would be great.
> We can also extend plugins/gatt-example.c to test 128-bit UUID
> includes.
> 
This patch set looks like it is working properly with 16 bit uuids. I tested it with included services as primaries and as secondaries, and I even looked for included services inside other included services (secondary services which have includes). Take a look at this :
[CON][64:9c:8e:e5:a0:e9][LE]> primary
attr handle: 0x0001, end grp handle: 0x000b uuid: 00001800-0000-1000-8000-00805f9b34fb
attr handle: 0x000c, end grp handle: 0x0016 uuid: 00001800-0000-1000-8000-00805f9b34fb
attr handle: 0x0017, end grp handle: 0x0019 uuid: 00001801-0000-1000-8000-00805f9b34fb
attr handle: 0x001a, end grp handle: 0x0043 uuid: 00009000-0000-1000-8000-00805f9b34fb
attr handle: 0x0044, end grp handle: 0x0046 uuid: 0000a000-0000-1000-8000-00805f9b34fb
attr handle: 0x0050, end grp handle: 0x0055 uuid: 0000a002-0000-1000-8000-00805f9b34fb
attr handle: 0x0056, end grp handle: 0x005a uuid: 0000a003-0000-1000-8000-00805f9b34fb
attr handle: 0x005b, end grp handle: 0x005d uuid: 0000a004-0000-1000-8000-00805f9b34fb
attr handle: 0x0064, end grp handle: 0x0069 uuid: 0000a001-0000-1000-8000-00805f9b34fb
attr handle: 0x006a, end grp handle: 0x006c uuid: 0000a008-0000-0000-0123-456789abcdef
attr handle: 0x0070, end grp handle: 0x0078 uuid: 0000a007-0000-0000-0123-456789abcdef
attr handle: 0x0079, end grp handle: 0x007d uuid: 00001802-0000-1000-8000-00805f9b34fb
attr handle: 0x007e, end grp handle: 0x0080 uuid: 00001804-0000-1000-8000-00805f9b34fb
attr handle: 0x0081, end grp handle: 0x0083 uuid: 00001803-0000-1000-8000-00805f9b34fb
[CON][64:9c:8e:e5:a0:e9][LE]> included 0x01 0x6c
[CON][64:9c:8e:e5:a0:e9][LE]> 

This is a secondary service, including another secondary service, both do not show up in the primaries list above, as they should:
handle: 0x004b, start handle: 0x0047, end handle: 0x0049 uuid: 0000a006-0000-1000-8000-00805f9b34fb 

handle: 0x0051, start handle: 0x004a, end handle: 0x004f uuid: 0000a005-0000-1000-8000-00805f9b34fb
handle: 0x005f, start handle: 0x0047, end handle: 0x0049 uuid: 0000a006-0000-1000-8000-00805f9b34fb
handle: 0x0065, start handle: 0x005e, end handle: 0x0063 uuid: 0000a005-0000-1000-8000-00805f9b34fb

[CON][64:9c:8e:e5:a0:e9][LE]> included 0x01 0x78
However, when I tried to search for included services inside a 128bit service, which includes another 128bit secondary service, the gatttool first did not return any result, and then I got a segmentation fault. 



> Jefferson Delfes (2):
>   GATT: Add support for find included services
>   gatttool: Add "included" command
> 
>  attrib/gatt.c        |  173
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h        |    9 +++
>  attrib/interactive.c |   54 ++++++++++++++++
>  3 files changed, 236 insertions(+)
> 
> --
> 1.7.9.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks,
Chen Ganir

