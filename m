Return-Path: <klaus@encephalon.dk>
Date: Tue, 24 Feb 2004 09:53:51 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
Message-ID: <20040224085351.GA3782@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk> <1077573810.2791.161.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077573810.2791.161.camel@pegasus>
From: klaus@encephalon.dk (Klaus Holst)
List-ID: <bluez-users.lists.sourceforge.net>

* Marcel Holtmann <marcel@holtmann.org> [2004-02-23 23:03:30 +0100]:

> Hi Klaus,
> 
> > I have just installed bluez with partial success. I am using a belkin usb adaptor
> > and linux 2.4.25 with the latest bluez installed. The adaptor is recognized and 
> > I am able to connect a Pocket PC (WM2003) to the linux-machine using "Network Access Service". 
> > However pppd is never started and I am not able to transmit any packets from the PPC.
> > 
> > Starting pand,dund etc:
> > Feb 23 18:51:28 mini hcid[5972]: HCI daemon ver 2.4 started
> > Feb 23 18:51:28 mini hcid[5972]: Starting security manager 0
> > Feb 23 18:51:28 mini bluetooth: hcid startup succeeded
> > Feb 23 18:51:28 mini sdpd[5978]: sdpd v1.5 started
> > Feb 23 18:51:28 mini bluetooth: sdpd startup succeeded
> > Feb 23 18:51:34 mini pand[5986]: PAN daemon ver 1.1
> > Feb 23 18:51:34 mini pan: pand startup succeeded
> > Feb 23 18:51:34 mini dund[5990]: DUN daemon ver 1.1
> > Feb 23 18:51:34 mini pan: dund startup succeeded
> > Feb 23 18:52:13 mini hcid[5972]: link_key_request (sba=00:03:C9:2E:6C:F6, dba=00:04:3E:A2:2D:C9)
> > Feb 23 18:52:16 mini pand[5997]: New connection from 00:04:3E:A2:2D:C9 bnep0
> > 
> > And pppd is never started as I suppose it should?
> 
> your new connection is a PAN connection and so you don't need pppd. Set
> up your new bnep0 device with ifconfig etc. and go ahead.
> 
> Regards
> 
> Marcel
> 

Thanks for the quick reply. I tried to set up bnep0:
 
bnep0     Link encap:Ethernet  HWaddr 00:03:C9:2E:6C:F6  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:2182 (2.1 Kb)  TX bytes:319 (319.0 b)

But I am still not able to ping anything from the pocket pc (using vxUtils). The pocket pc
has been assigned the ip adr:169.254.121.94 and subnet mask: 255.255.0.0 - probably assigned by
itself because of timeout.

I guess I am missing a step or two in the setup-process?

Best regards
Klaus
