Return-Path: <dyonutz@yahoo.com>
Message-ID: <20040611091730.90395.qmail@web50907.mail.yahoo.com>
Date: Fri, 11 Jun 2004 02:17:30 -0700 (PDT)
From: ionut dediu <dyonutz@yahoo.com>
Subject: Re: [Bluez-devel] L2Cap Connection problem : PC - Nokia 6600
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1086456578.16316.89.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

    Thank you very much for your fast reply. I have
hcid running and my phone and the PC are indeed paired
( as I can see from the phone ). 
    I also tried establishing a RFCOMM connection, but
that didn't work also. I guess the problem is from the
bluetooth J2ME API implementation which doesn't
establish the correct security parameters. Anyway, I
did the same program on the phone in Symbian C++, and
it works. If someone else tried programming in J2ME
for bluetooth between a phone and a PC running BlueZ,
please reply and tell me if you had the same
authentication problems.
     Thanks again. Best of luck.

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
> 
> > I'm a newbie (big surprise :). I'm trying to make
> a
> > simple chat application between a Nokia 6600 phone
> > (using j2me ) and my PC (using BlueZ) over L2CAP.
> The
> > problem is that I can't get the connection to
> start.
> > I'm guessing it's from connection parameters
> > negotiation (probably imtu and omtu). First I
> didn't
> > supply any of the mtus, neither on pc nor phone,
> then
> > I used the same values (512). On both situations I
> get
> > the following error message from connect : Can't
> > connect. Connection refused(111). The phone is the
> > server, and the PC is the client. I don't specify
> a
> > psm on the connection string url on the phone
> because
> > I get an exception. Instead I let the BCC of the
> phone
> > supply me one. Then using the sdptool I find the
> psm
> > (which is allways 4097 <-> 0x1001) and use it in
> the
> > client application on the PC to connect. The code
> is
> > very simple. Here it is :
> 
> I can't tell you anything about J2ME programming,
> but in general there
> is no need to give the MTU values. The L2CAP will
> negotiate the default
> values. In most cases it is 672.
> 
> > HCIDump - HCI packet analyzer ver 1.8
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Create Connection(0x01|0x0005) plen
> 13
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Connect Complete(0x03) plen 11
> > < ACL data: handle 0x0029 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 4097 scid 0x0040
> > > HCI Event: Number of Completed Packets(0x13)
> plen 5
> > > HCI Event: Max Slots Change(0x1b) plen 3
> > > ACL data: handle 0x0029 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0040
> > result 1 status 2
> > > HCI Event: QoS Setup Complete(0x0d) plen 21
> > > ACL data: handle 0x0029 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0040
> > result 3 status 0
> > < HCI Command: Disconnect(0x01|0x0006) plen 3
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Disconn Complete(0x05) plen 4
> > 
> > What means result 3 status 0, from hcidump ? Sorry
> I'm
> > not familiar with hcidump. Thanks a lot in
> advance.
> 
> You can open the Bluetooth specification and look it
> up. However the
> result 3 means "Connection refused - security
> block". There is no
> pairing between your devices or the hcid is not
> running.
> 
> Some line above you have result 1 with status 2 and
> this means
> "Connection pending" with "Authorization pending".
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by the new
> InstallShield X.
> From Windows to Linux, servers to mobile,
> InstallShield X is the one
> installation-authoring solution that does it all.
> Learn more and
> evaluate today!
> http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-devel



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
