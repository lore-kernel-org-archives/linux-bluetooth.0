Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdptool segfaults
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42272E36.3070503@tomtom.com>
References: <42272E36.3070503@tomtom.com>
Content-Type: text/plain
Message-Id: <1109865262.6722.84.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 03 Mar 2005 15:54:21 +0000

This looks to me like the Samsung is formatting the profile descriptor
list incorrectly. I guess it should be a sequence of sequences of
{ UUID, version } whereas the Samsung just formats it as a sequence.

On Thu, 2005-03-03 at 16:33 +0100, Dimitry Andric wrote:
> Hi,
> 
> I'm getting a weird segfault in sdptool, when I'm browsing the DUN
> service of a Samsung D500.  It crashes in sdp_get_profile_descs:
> 
> (gdb) run search --bdaddr 00:12:47:11:0B:06 DUN
> Starting program: /bin/sdptool search --bdaddr 00:12:47:11:0B:06 DUN
> Searching for DUN on 00:12:47:11:0B:06 ...
> Service Name: Dial-up networking
> Service RecHandle: 0x10002
> Service Class ID List:
>  "Dialup Networking" (0x00001103)
> Protocol Descriptor List:
>  "L2CAP" (0x00000100)
>  "RFCOMM" (0x00000003)
>    Channel: 4
> 
> Program received signal SIGSEGV, Segmentation fault.
> sdp_get_profile_descs (rec=0x28a58, profDescSeq=0xbefffcec)
>    at /home/dim/src/bluez/bluez-libs/src/sdp.c:1528
> 1528                    sdp_data_t *pVnum = seq->val.dataseq->next;
> (gdb) bt
> #0  sdp_get_profile_descs (rec=0x28a58, profDescSeq=0xbefffcec)
>    at /home/dim/src/bluez/bluez-libs/src/sdp.c:1528
> #1  0x0000a6a4 in print_service_attr (rec=0x2aab0)
>    at /home/dim/src/bluez/bluez-utils/tools/sdptool.c:904
> #2  0x0000cde0 in do_search (bdaddr=0xbefffd6c, context=0xbefffd74)
>    at /home/dim/src/bluez/bluez-utils/tools/sdptool.c:1999
> #3  0x0000d094 in cmd_search (argc=94880, argv=0x18050)
>    at /home/dim/src/bluez/bluez-utils/tools/sdptool.c:2150
> #4  0x0000d55c in main (argc=4, argv=0xbefffe08)
>    at /home/dim/src/bluez/bluez-utils/tools/sdptool.c:2319
> (gdb) p seq->val.dataseq->next
> Cannot access memory at address 0x32
> (gdb) p seq->val.dataseq      $1 = (sdp_data_t *) 0x1a
> 
> I've got no idea why val.dataseq turns out to be invalid here... It
> looks more like a UUID, it's certainly not a pointer.
> 
> I attached a HCI dump of the discovery; sdptool seems to crash on the
> following part:
> 
> > ACL data: handle 42 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x2 len 0x5
>           count 2
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10002
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-32 0x1103 (DUN) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-32 0x0100 (L2CAP) > <
>                  uuid-32 0x0003 (RFCOMM) uint 0x4 > >
>               aid 0x0100 (SrvName)
>                  str "Dial-up networking"
>               aid 0x0009 (BTProfileDescList)
>                  < uuid-32 0x1103 (DUN) >
>           cont 00
> 
> You can compare this to some DUN searches that do not cause a crash.
> For example, a SE K700 gives:
> 
> > ACL data: handle 42 flags 0x02 dlen 101
>     L2CAP(d): cid 0x0040 len 97 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x5c
>           count 89
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10000
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) > <
>                  uuid-16 0x0003 (RFCOMM) uint 0x1 > >
>               aid 0x0005 (BrwGrpList)
>                  < uuid-16 0x1002 (PubBrwsGrp) >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1103 (DUN) uint 0x100 > >
>               aid 0x0100 (SrvName)
>                  str "Dial-up Networking"
>               aid 0x0305 (unknown)
>                  bool 0x0
>           cont 00
> 
> And a Nokia 6310i gives:
> 
> > ACL data: handle 43 flags 0x01 dlen 16
>     L2CAP(d): cid 0x0040 len 108 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x67
>           count 100
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10002
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) > <
>                  uuid-16 0x0003 (RFCOMM) uint 0x1 > >
>               aid 0x0005 (BrwGrpList)
>                  < uuid-16 0x1002 (PubBrwsGrp) >
>               aid 0x0006 (LangBaseAttrIDList)
>                  < uint 0x656e uint 0x6a uint 0x100 >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1103 (DUN) uint 0x100 > >
>               aid 0x0100 (SrvName)
>                  str "Dial-up networking"
>           cont 00
> 
> So AFAICS, the difference is that most (?) phones use a uuid-16 for
> BTProfileDescList (at least for the DUN item), while the Samsung uses
> a uuid-32.  Does anyone know if this is actually allowed?  I'd guess
> the specific integer type shouldn't matter, so if it doesn't, sdptool
> probably shouldn't crash on it.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
