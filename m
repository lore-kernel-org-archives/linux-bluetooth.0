Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [btsco] configure/make errors
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41EE6C49.7090908@pca.it>
References: <41ED7E8D.8030709@pca.it> <1106136920.8190.96.camel@pegasus>
	 <41EE6C49.7090908@pca.it>
Content-Type: text/plain
Message-Id: <1106151718.8190.121.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 19 Jan 2005 17:21:58 +0100

Hi Luca,

> > And again. The bootstrap thing is for making the developer happy,
> > because he must call only one program/script for getting the repository
> > ready. It is not for others ;)
> I know this, but the problem here is that if someone like me (not a
> developer, not really a newbie) wants to try his Bluetake BT420EX with
> the bluetooth-alsa project, he should go with the CVS (no other released
> versions). And so he has some problem, because there're no info about
> the requirements (automake-1.7, the Audio Output libraries and the
> Bluetooth libraries, even if the last one was my fault, it's quite
> obvious that for a Bluetooth project you need the Bluetooth libraries).
> 
> So, IMHO also for developers, at least a 'required packages' section
> should be added to the README.

I don't lead this project and so these are only my two cents. Brad is
responsible and it is actually his decision.

Maybe doing a release once in a while is a good idea, but the problem is
the kernel module is not in that shape that I would accept it. However I
like the idea of doing everything in userspace as an ALSA plugin and
that should be the way to go.

> Ok, I'll add this ASAP, but ATM Debian unstable still has 2.11 and I
> should prepare my own Debian bluez-2.13 packages.

Yeah, we really need new packages (btw 2.14) for Debian Sid.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
