Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MTU in l2test
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657605010302474a44519e@mail.gmail.com>
References: <2de4657604123007015c2c9461@mail.gmail.com>
	 <1104674721.8894.10.camel@pegasus>
	 <2de4657605010302474a44519e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1104750031.8894.48.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 03 Jan 2005 12:00:31 +0100

Hi Manjunath,

> > > I am varying the mtu and data size variables in the l2test program.
> > > From the docs, I learnt that maximum L2CAP payload is 65535 bytes. I
> > > am unable to set the data size above 45000 bytes inspite of setting my
> > > MTU to 65535 (both on the sender and the receiver).
> > > I get an error saying "Send failed. Resource temporarily unavailable".
> > >  Hope you can help me with this one.
> > 
> > the MTU is different for incoming and outgoing side. With what kind of
> > device and what commands lines are you testing these.
> 
> I am using anycom-120 dongles and using the l2test utility.  I am also
> setting the incoming and outgoing mtu values (imtu and omtu variables)
> to the same value, say 65000 bytes. My 'datasize' is about 45000
> bytes. I get the error as mentioned above.

what is the output of "hciconfig -a" of the Anycom dongle. Check when
this error occurs. Do you see it only when calling the send()/write()
function? Maybe there is a buffer problem. What do you see with hcidump?
Is the MTU correctly negotiated?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
