Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576050108064064adf3df@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] l2test-number of frames
In-Reply-To: <1105194404.8137.7.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de4657605010801137c118137@mail.gmail.com>
	 <1105193094.8137.5.camel@pegasus>
	 <2de4657605010806154c793575@mail.gmail.com>
	 <1105194404.8137.7.camel@pegasus>
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
Date: Sat, 8 Jan 2005 20:10:05 +0530

Hi marcel,

On Sat, 08 Jan 2005 15:26:44 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> > > > in the l2test, i am not able to send more than 512 frames. The utility
> > > > stops at this point every time. I want to run the utility for about
> > > > 5000 packets, but after 512 packets, i get the following error
> > > >
> > > >  "Send failed. Connection reset by peer(104)"....
> > > >
> > > > i think some constant in l2cap.cc or h is causing this problem. Hope
> > > > you can help me this one.
> > >
> > > what kernel? What utils and libs versions? What kind of devices?
> > >
> >
> > i am using linux-2.6.9 with bluez-libs-2.11 and bluez-utils-2.11. i am
> > using anycom usb-120 dongles......
> 
> check with 2.6.10 and bluez-{libs|utils}-2.13. What command lines do you
> use on each side?

on the tx, 
l2test -s -N 5000 dest_bdaddr

on the rx,
l2test -r

If i change N to 500, it works fine......but after packet 512, the
connection is reset...

Regards,
Manjunath
 


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
