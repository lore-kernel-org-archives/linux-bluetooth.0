Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050109235803.GC5291@penguinhosting.net>
References: <20050109212302.GB5291@penguinhosting.net>
	 <1105324578.8637.8.camel@pegasus>
	 <20050109235803.GC5291@penguinhosting.net>
Content-Type: text/plain
Message-Id: <1105329941.8637.11.camel@pegasus>
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
Date: Mon, 10 Jan 2005 05:05:41 +0100

Hi Ian,

> > > I never get a PIN entry request (as I did with the mouse) or any other
> > > error.  There's a long pause between the "Connecting to device" and the
> > > "Can't create".  According to lib.c in the kernel, ENOSYS is returned
> > > on an unrecognized error code, but I don't know enough about the packet
> > > formats to figure out what byte is the error code, or what else it might
> > > mean.  Attached is an hcidump during the "hidd --search" run.
> > 
> > at that pause you should type a numeric PIN on your keyboard and then
> > press return.
> 
> Sorry, wasn't clear enough.  When I'm running in X, the PIN dialog pops
> up as expected for the mouse, and not for the keyboard.  The blocking
> call for that pause from hidd, according to strace, is:
> 
> bind(4, {sa_family=AF_BLUETOOTH, sa_data="\0\0\212\323\4\241\16\0\0\0\0\0\0\0"}, 10) = 0
> setsockopt(4, SOL_TCP, TCP_NODELAY, "0\0000\0\377\377", 6) = 0
> connect(4, {sa_family=AF_BLUETOOTH, sa_data="\21\0\34N:\225\n\0\0\0\0\0\0\0"}, 10
> 
> (pause is here)
> 
> = -1 ENOSYS (Function not implemented)
> 
> Typing a PIN in that space simply causes the expected:
> 
> sheba% 0000
> zsh: command not found: 0000

you should type the PIN on the keypad of the Bluetooth keyboard. After
that the PIN dialog should popup and you have to repeat the PIN.

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
