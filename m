Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050626104000.28921.qmail@web52801.mail.yahoo.com>
From: Naved Aziz <no2alikebd@yahoo.com>
Subject: Re: [Bluez-users] BlueZ on ETRAX 100LX devboard 82+
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42AF2149.1030701@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sun, 26 Jun 2005 03:40:00 -0700 (PDT)


Hi Marco,

Thanks a lot for your help.  I wrote my own program
using rfcomm, and have been able to establish
connections with phones.

I have also been able to write data to phones. 
However, I am currently having trouble reading data
sent from the phone to the board.  

The application running on the phone receives data
from me, displays it, and then echoes it back.

The program I have written is pretty much the same as
the RFCOMM's main.c's cmd_connect function, except now
it receives an argument from the user and sends that
out through a socket once it has connected with a
phone.  This part works fine.  

Just after the write function call, I call read as:

chk_read = read (sk, readbuff, 2);                   

with sk being the file descriptor of the socket
connected to the phone, readbuff being an array of
type unsigned char and size 100, and reading in only 2
characters.  I have earlier initialized readbuff as:

memset (dread, 0, 100);

However, when I send data to the phone and it receives
this data and displays it, once it has sent the data
back to the board, the board does not receive it. 
Rather it waits for data to be received, and once
disconnected displays that chk_read has been assigned
a -1, meaning no data has been read.  I have called
the read function for reading more than 2 characters
(have used readbuff's maximum size, 100), but still no
good.

Any idead what's going wrong here? Any help will be
greatly appreciated.

Thanks and sincerely,

Naved





--- Marco Trudel <mtrudel@gmx.ch> wrote:

> > My question is this: instead of creating a device
> > using ioctl(), do you know how to assign this
> already
> > created device to dev in the above if statement?
> 
> no. I never worked with such devices.
> 
> > The device resides in the /dev directory.  This is
> a
> > problem I will face even if I write step(6)
> > separately
> 
> actually no. There's no need for a device, use a
> socket.
> 
> > becuase the question of using an already
> > created device will still come up.
> 
> what for? not for bluez...
> 
> 
> regards
> Marco
> 
> 
>
-------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux
> Migration Strategies
> from IBM. Find simple to follow Roadmaps,
> straightforward articles,
> informative Webcasts and more! Get everything you
> need to get up to
> speed, fast.
>
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
