Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <be976db60612191226p7c4660a7q45d173717c81d634@mail.gmail.com>
References: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
	<E34033EC-19D4-4112-A964-C656CA724290@gmail.com>
	<be976db60612191226p7c4660a7q45d173717c81d634@mail.gmail.com>
Message-Id: <DA1C5D3D-6945-436C-9125-EA6822AF6107@gmail.com>
From: Bas Schulte <basschulte@gmail.com>
Date: Tue, 19 Dec 2006 21:39:21 +0100
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

On 19-dec-2006, at 21:26, Mark S. Townsley wrote:

> Hi Bas:  thanks for your reply.
>
> So are you implying that if I do not go through RFCOMM and all the  
> sockets stuff, I can
> actually open /dev/rfcomm0 and get back a file descriptor just like  
> any other serial port?

Yep. I actually just managed to get mgetty working ;)

Here's how:

# rfcomm listen 3 4

This creates /dev/rfcomm3, available on channel 4. It spits out  
something like:

Waiting for connection on channel 4
Press CTRL-C for hangup

Just let this guy run.

Then start mgetty, in another terminal:

# mgetty -r -b /dev/rfcomm3

Before all of this, I did a "sdptool add --channel=4 SP" to let the  
client know there's a Serial Port service on channel 4.

 From another box, I connected to this channel and got a nice "login:  
" prompt.

Minor thing is that mgetty complains a bit about some ioctl's didn't  
go right, I don't think it likes being started from the command line,  
but it does work.

I'd say this pretty much shows you can just use plain serial io  
against these devices ;)

I don't (yet) understand exactly how rfcomm works and in what state  
it creates the device, for instance, "rfcomm bind ..." doesn't work.

Cheers,

Bas.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
