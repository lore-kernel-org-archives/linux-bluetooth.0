Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sdpd crashing (in uclinux)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jorge A." =?ISO-8859-1?Q?Gonz=E1lez?= <egrojorge@terra.es>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084991513.1845.117.camel@localhost>
References: <692442859.20040519115732@terra.es>
	 <1084961712.4327.34.camel@pegasus>  <1084991513.1845.117.camel@localhost>
Content-Type: text/plain
Message-Id: <1085006031.4327.106.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 20 May 2004 00:33:51 +0200

Hi Jorge,

> > please start using bluez-libs-2.7 and bluez-utils-2.7, because the SDP
> > stuff is now part of the core packages and I stopped maintaining the
> > bluez-sdp package.
> > 
> > The new Bluetooth library contains a bt_put_unaligned macro for general
> > use and I used a slight different method for non i386 platforms.
> 
> I am using bluez-libs-2.7 and bluez-utils-2.7. When I refered to sdpd I
> mean the one is located in bluez-utils-2.7/sdpd. Sorry for not saying it
> before.
> 
> The guilty instruction is:
> sdp_put_unaligned(htons(rsp_count), (uint16_t *)pTotalRecordCount);
> 
> in the line 315 of bluez-utils-2.7/sdpd/request.c
> 
> When I reach this line (because other device is trying to browse the
> local services) I get a SIGSEV so sdpd finish.
> 
> The commands I use to reach this state are:
> 
> #hcid -n -f /nfs/hcid.conf &
> #hciattach -n /dev/tts/2 any 115200 flow &
> #hciconfig hci0 up
> #sdpd -n
> 
> And the output of sdpd is:
> 
> ****  A pocket PC is trying to browse our local services
> 
> Got a svc srch req
> Seq type : 53
> Data size : 3
> Data type: 0x19
> No of elements : 1
> Expected count: 20
> Bytes scanned : 5
> Continuation State size : 0
> Checking svcRec : 0x0
> Checking svcRec : 0xb1a038
> Match count: 2
> ***** reached line 315 of request.c
> SIGSEGV
> 
> The instruction sdp_put_unaligned is replaced with the macro
> bt_put_unaligned in the not i386 version and it is  
> "memcpy((ptr), &__tmp, sizeof(*(ptr))); "
> which is crashing. There are other times that this macro is called and
> works normally, so I suppose it is a problem with the pTotalRecordCount
> pointer.
> 
> I have found out than if just after the
> pTotalRecordCount = (short*) pdata;
> 
> I do:
> 
> 	printf("pdata is %p and have %i\n",
> 	       pdata,*pdata);
> 	--this work
> 
> 	printf("pTotalRecordCount is %p and have %i\n",
> 	       pTotalRecordCount,*pTotalRecordCount));
> 	--this give me a SIGSEV!!!!
> 
> but if I write this:
> 	printf("pTotalRecordCount vale %p y contiene %i\n",
> 	       pTotalRecordCount,*((char*) pTotalRecordCount));
> this work!
> 
> This make clear that the problem is with the type of the pointers, but I
> have no idea of how to solve it, because pTotalRecordCount and similar
> ones are casted to uint16_t when they crash.
> 
> Besides these printf the only modification i have made to the code is
> defining the SDP_UNIX_PATH as "/ram/sdp" instead than "/var/run/sdp"
> because /ram is the only place where I have write access.
> 
> My compiler is arm-elf-gcc, the CPU is ARM7DMI and the kernel version is
> 2.4.22.
> 
> I hope all this information help in figuring out the problem

actually I have no idea why this fails. Does it help if you declare
pTotalRecordCount as uint16_t instead of short?

Do the old sdp_put_unaligned code for non i386 platforms from the
bluez-sdp package is working correct?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
