Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de4657605010303287a6eb6db@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MTU in l2test
In-Reply-To: <1104750031.8894.48.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de4657604123007015c2c9461@mail.gmail.com>
	 <1104674721.8894.10.camel@pegasus>
	 <2de4657605010302474a44519e@mail.gmail.com>
	 <1104750031.8894.48.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 3 Jan 2005 16:58:10 +0530

On Mon, 03 Jan 2005 12:00:31 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> > > > I am varying the mtu and data size variables in the l2test program.
> > > > From the docs, I learnt that maximum L2CAP payload is 65535 bytes. I
> > > > am unable to set the data size above 45000 bytes inspite of setting my
> > > > MTU to 65535 (both on the sender and the receiver).
> > > > I get an error saying "Send failed. Resource temporarily unavailable".
> > > >  Hope you can help me with this one.
> > >
> > > the MTU is different for incoming and outgoing side. With what kind of
> > > device and what commands lines are you testing these.
> >
> > I am using anycom-120 dongles and using the l2test utility.  I am also
> > setting the incoming and outgoing mtu values (imtu and omtu variables)
> > to the same value, say 65000 bytes. My 'datasize' is about 45000
> > bytes. I get the error as mentioned above.
> 
> what is the output of "hciconfig -a" of the Anycom dongle. Check when
> this error occurs. Do you see it only when calling the send()/write()
> function? Maybe there is a buffer problem. What do you see with hcidump?
> Is the MTU correctly negotiated?

hi marcel,

the "hciconfig -a" shows

hci0:   Type: USB
        BD Address: 00:0B:0D:30:5D:EA ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:114526 acl:28 sco:0 events:15460 errors:0
        TX bytes:4857089 acl:39552 sco:0 commands:1400 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DH5
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)

I get this error when i use the send() function to pump the data out.
May be there is a problem with the HCI buffer. Is there some way to
add a delay. The L2CAP connection is correctly established and the MTU
is also correctly negotiated to the set value (65000) as seen in the
hcidump on both sides.

regards,
manjunath 

> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
