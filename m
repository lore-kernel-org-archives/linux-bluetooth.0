Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test-number of frames
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576050108064064adf3df@mail.gmail.com>
References: <2de4657605010801137c118137@mail.gmail.com>
	 <1105193094.8137.5.camel@pegasus>
	 <2de4657605010806154c793575@mail.gmail.com>
	 <1105194404.8137.7.camel@pegasus>
	 <2de46576050108064064adf3df@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1105203974.8149.1.camel@pegasus>
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
Date: Sat, 08 Jan 2005 18:06:14 +0100

Hi Manjunath,

> > check with 2.6.10 and bluez-{libs|utils}-2.13. What command lines do you
> > use on each side?
> 
> on the tx, 
> l2test -s -N 5000 dest_bdaddr
> 
> on the rx,
> l2test -r
> 
> If i change N to 500, it works fine......but after packet 512, the
> connection is reset...

I just tested it with a 2.6.10-mh1 and the latest l2test from CVS. No
problem to send 5000 packets. However this might be an endian bug
somewhere. What is your host hardware?

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
