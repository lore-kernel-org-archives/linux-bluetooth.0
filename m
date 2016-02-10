Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 10 Feb 2016 14:37:08 +0100
From: Maxime Chevallier <chevalliersebmax@gmail.com>
To: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth PAN Connection - NAP and GN
Message-ID: <20160210133708.GA26024@vps217108.ovh.net>
References: <3916CF28FA2C014B862815C318D03FF5A0A7493B03@Courier.syntech.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3916CF28FA2C014B862815C318D03FF5A0A7493B03@Courier.syntech.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 09, 2016 at 01:17:56PM -0500, Jon Hoffman wrote:
> Hello,
> I am hoping that someone on this list can tell me what I am doing wrong or at least point me in the right direction.
> 
> As part of a number of proof-of-concepts, I am trying to setup a PAN between two devices.  For this particular proof-of-concepts I am trying to setup a Bluetooth Legacy connection.  I have successfully setup this connection using the NAP scenario however we are not looking to route anything outside of connection.  Since we do not want to route (security also says we need to disable routing) we would prefer to use either a GN (Group Ad-Hoc Network) or a PANU-PANU connection however I have been unable to get this to work.   
> 
> My slave device (where the server is being setup at) is running the Linux kernel 4.4 (also tried it on a 4.1.13 kernel) with Bluez 5.35 (tried it with 5.23 on the 4.1.13 kernel).  I have tried three master devices (device making the connection) and have the same issue with all three.  They are:
>   -Linux kernel 4.1.13 with bluez 5.23 using blueman as the UI
>   -Windows 10
>   -iOS 9.2.1
> 
> I have run hcidump to see what is going on during the pairing/connection of the NAP connection and also the GN connection to see what is different.  Below are sniplets of what I am seeing.  For the NAP connection I am seeing this:
> 
> information about the NAP from the hcidump
>            record #6
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10007
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1116 (NAP) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
>                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 > > >
>               aid 0x0005 (BrwGrpList)
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
> 
> > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 15 scid 0x0041
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
>       Connection pending - Authorization pending
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>       Connection successful
> 
> And after this my connection is established and all is well.  For the GN network this is what I am seeing beginning with the information about the GN.
> 
>            record #6
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10007
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1117 (GN) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
>                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 > > >
>               aid 0x0005 (BrwGrpList)
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
> 
> > ACL data: handle 11 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 15 scid 0x0041
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
>       Connection pending - Authorization pending
> < ACL data: handle 11 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 status 0
>       Connection refused - security block
> 
> Since the issue is obviously a security block I have tried to figure out how to disable the security.  I have ran hciconfig with the noauth and noencrypt options but those do not seem to help.  I have also use bluetoothctl to trust the devices which worked to get the NAP working.  I have done a lot of reading but I have been unable to find much on the GN or PANU options.  Here is what I do to setup the server:
> 
>         echo "Setting up routing"
>         /etc/init.d/radvd restart
> 
>         echo "setting up bridge"
>         brctl addbr pan0
>         brctl setfd pan0 0
>         brctl stp pan0 off
> 
>         echo "setting pan0 local IP address"
>         ifconfig pan0 192.168.3.2 
>         ifconfig pan0 inet6 add fd00::5ef3:70ff:xxxx:xxxx/64
>         ip link set pan0 up
> 
>         echo "starting bt-network server"
>         #bt-network -d -s nap pan0 
>         bt-network -d -s gn pan0 
>         sleep 1
> 
>         #echo "starting dhcp server"
>         /etc/init.d/dnsmasq restart 
>         sleep 1
> 
>         echo " "
> 
> I enable the bt-network line for the particular connection I am trying to setup.
> I know I am probably just missing something pretty easy but I have been chasing this for a few days now and I cannot seem to find what I am missing.  Any suggestions or ideas of where to look would be appreciated.
> Thanks,
> 
>  Jon

Hi Jon,

Unfortunately, I have no answer to your problem, but I would like
to back you up on this issue, since I ran into the exact same problem a
few month ago, and didn't make any progress since.

I remember looking at the test-pan script packaged with blueZ, and modifying
it to make it work with the GN role, but unsuccessfully.

Here is the mail I sent at the time :
http://permalink.gmane.org/gmane.linux.bluez.kernel/64144

I hope someone can help us on this issue,

Thanks,

Maxime
