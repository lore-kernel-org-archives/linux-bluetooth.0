Return-Path: <klaus@encephalon.dk>
Date: Tue, 24 Feb 2004 22:54:00 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
Message-ID: <20040224215400.GA3875@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk> <1077573810.2791.161.camel@pegasus> <20040224085351.GA3782@encephalon.dk> <1077624875.2880.44.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077624875.2880.44.camel@pegasus>
From: klaus@encephalon.dk (Klaus Holst)
List-ID: <bluez-users.lists.sourceforge.net>



* Marcel Holtmann <marcel@holtmann.org> [2004-02-24 13:14:36 +0100]:

> > 
> > But I am still not able to ping anything from the pocket pc (using vxUtils). The pocket pc
> > has been assigned the ip adr:169.254.121.94 and subnet mask: 255.255.0.0 - probably assigned by
> > itself because of timeout.
> 
> of course you are not able to ping, because your two devices are in
> different IP networks. Configure your PDA to assign manually an IP
> number or run a DHCP server for bnep0.
> 
> Regards
> 
> Marcel
> 
> 

I manually assigned the ip-number for my PDA and That fixed the problem - Thanks for the help.
However a new problem has appeared :-). The connection is quite slow (maybe 1kb/s) and after at 
most a couple of minutes the connection is dropped and I am unable to detect hci0 from the 
server:

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:2E:6C:F6 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
        RX bytes:10342 acl:118 sco:0 events:92 errors:0
        TX bytes:33903 acl:148 sco:0 commands:19 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: HOLD SNIFF PARK 
        Link mode: ACCEPT MASTER 
Can't read local name on hci0. Connection timed out(110)


A problem with my bluez-modules?

Best regards
Klaus
