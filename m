Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth PAN Connection - NAP and GN
Date: Fri, 12 Feb 2016 17:00:22 +0100
Message-ID: <2478946.W935PEPn7x@ix>
In-Reply-To: <3916CF28FA2C014B862815C318D03FF5A0A7493B03@Courier.syntech.org>
References: <3916CF28FA2C014B862815C318D03FF5A0A7493B03@Courier.syntech.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tuesday 09 February 2016 13:17:56 Jon Hoffman wrote:
> Hello,
> I am hoping that someone on this list can tell me what I am doing wrong or
> at least point me in the right direction.
> 
> As part of a number of proof-of-concepts, I am trying to setup a PAN between
> two devices.  For this particular proof-of-concepts I am trying to setup a
> Bluetooth Legacy connection.  I have successfully setup this connection
> using the NAP scenario however we are not looking to route anything outside
> of connection.  Since we do not want to route (security also says we need
> to disable routing) we would prefer to use either a GN (Group Ad-Hoc
> Network) or a PANU-PANU connection however I have been unable to get this
> to work.
> 
> My slave device (where the server is being setup at) is running the Linux
> kernel 4.4 (also tried it on a 4.1.13 kernel) with Bluez 5.35 (tried it
> with 5.23 on the 4.1.13 kernel).  I have tried three master devices (device
> making the connection) and have the same issue with all three.  They are:
> -Linux kernel 4.1.13 with bluez 5.23 using blueman as the UI
>   -Windows 10
>   -iOS 9.2.1
> 
> I have run hcidump to see what is going on during the pairing/connection of
> the NAP connection and also the GN connection to see what is different. 
> Below are sniplets of what I am seeing.  For the NAP connection I am seeing
> this:
> 
> information about the NAP from the hcidump
>            record #6
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10007
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1116 (NAP) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
>                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 >
> > > aid 0x0005 (BrwGrpList)
>                  < uuid-16 0x1002 (PubBrwsGrp) >
>               aid 0x0006 (LangBaseAttrIDList)
>                  < uint 0x656e uint 0x6a uint 0x100 >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1116 (NAP) uint 0x100 > >
>               aid 0x0100 (SrvName)
>                  str "Network service"
>               aid 0x0101 (SrvDesc)
>                  str "Network service"
>               aid 0x030a (SecurityDescription)
>                  uint 0x1
>               aid 0x030b (NetAccessType)
>                  uint 0xfffe
>               aid 0x030c (MaxNetAccessRate)
>                  uint 0x0
> 
> Then for the actual connection attempt I see this:
> > ACL data: handle 11 flags 0x02 dlen 12
> 
>     L2CAP(s): Connect req: psm 15 scid 0x0041
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
>       Connection pending - Authorization pending
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>       Connection successful
> 
> And after this my connection is established and all is well.  For the GN
> network this is what I am seeing beginning with the information about the
> GN.
> 
>            record #6
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10007
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1117 (GN) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
>                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 >
> > > aid 0x0005 (BrwGrpList)
>                  < uuid-16 0x1002 (PubBrwsGrp) >
>               aid 0x0006 (LangBaseAttrIDList)
>                  < uint 0x656e uint 0x6a uint 0x100 >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1117 (GN) uint 0x100 > >
>               aid 0x0100 (SrvName)
>                  str "Network service"
>               aid 0x0101 (SrvDesc)
>                  str "Network service"
>               aid 0x030a (SecurityDescription)
>                  uint 0x1
> 
> and when the connection is made I see this:
> > ACL data: handle 11 flags 0x02 dlen 12
> 
>     L2CAP(s): Connect req: psm 15 scid 0x0041
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
>       Connection pending - Authorization pending
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 status 0
>       Connection refused - security block

This looks like connection was rejected due to missing authorization. Are you 
sure you have default agent registered in your system?

Providing also 'bluetoothd -n -d'  logs would put some light on this issue.

-- 
pozdrawiam
Szymon Janc
