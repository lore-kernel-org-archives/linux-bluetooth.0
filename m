Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de4657605010302474a44519e@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MTU in l2test
In-Reply-To: <1104674721.8894.10.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de4657604123007015c2c9461@mail.gmail.com>
	 <1104674721.8894.10.camel@pegasus>
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
Date: Mon, 3 Jan 2005 16:17:12 +0530

On Sun, 02 Jan 2005 15:05:21 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> > I am varying the mtu and data size variables in the l2test program.
> > From the docs, I learnt that maximum L2CAP payload is 65535 bytes. I
> > am unable to set the data size above 45000 bytes inspite of setting my
> > MTU to 65535 (both on the sender and the receiver).
> > I get an error saying "Send failed. Resource temporarily unavailable".
> >  Hope you can help me with this one.
> 
> the MTU is different for incoming and outgoing side. With what kind of
> device and what commands lines are you testing these.

I am using anycom-120 dongles and using the l2test utility.  I am also
setting the incoming and outgoing mtu values (imtu and omtu variables)
to the same value, say 65000 bytes. My 'datasize' is about 45000
bytes. I get the error as mentioned above.

thanks,
Regards,
manjunath

> 
> 
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
