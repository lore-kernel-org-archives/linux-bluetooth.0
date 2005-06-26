Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050626133650.66078.qmail@web52801.mail.yahoo.com>
From: Naved Aziz <no2alikebd@yahoo.com>
Subject: Re: [Bluez-users] BlueZ on ETRAX 100LX devboard 82+
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050626104000.28921.qmail@web52801.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-123862975-1119793010=:62741"
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
Date: Sun, 26 Jun 2005 06:36:50 -0700 (PDT)

--0-123862975-1119793010=:62741
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
 
Sorry for the typing mistake in my previous email.  It should read 
 
memset (readbuff, 0, 100);
 
not 
 
memset (dread, 0, 100);
 
 
Naved


Naved Aziz <no2alikebd@yahoo.com> wrote:

Hi Marco,

Thanks a lot for your help. I wrote my own program
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
phone. This part works fine. 

Just after the write function call, I call read as:

chk_read = read (sk, readbuff, 2); 

with sk being the file descriptor of the socket
connected to the phone, readbuff being an array of
type unsigned char and size 100, and reading in only 2
characters. I have earlier initialized readbuff as:

memset (dread, 0, 100);

However, when I send data to the phone and it receives
this data and displays it, once it has sent the data
back to the board, the board does not receive it. 
Rather it waits for data to be received, and once
disconnected displays that chk_read has been assigned
a -1, meaning no data has been read. I have called
the read function for reading more than 2 characters
(have used readbuff's maximum size, 100), but still no
good.

Any idead what's going wrong here? Any help will be
greatly appreciated.

Thanks and sincerely,

Naved





--- Marco Trudel wrote:

> > My question is this: instead of creating a device
> > using ioctl(), do you know how to assign this
> already
> > created device to dev in the above if statement?
> 
> no. I never worked with such devices.
> 
> > The device resides in the /dev directory. This is
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
Tired of spam? Yahoo! Mail has the best spam protection around 
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

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-123862975-1119793010=:62741
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Sorry for the typing mistake in my previous email.&nbsp; It should read </DIV>
<DIV>&nbsp;</DIV>
<DIV>memset (readbuff, 0, 100);</DIV>
<DIV>&nbsp;</DIV>
<DIV>not </DIV>
<DIV>&nbsp;</DIV>
<DIV>memset (dread, 0, 100);</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Naved</DIV>
<DIV><BR><BR><B><I>Naved Aziz &lt;no2alikebd@yahoo.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>Hi Marco,<BR><BR>Thanks a lot for your help. I wrote my own program<BR>using rfcomm, and have been able to establish<BR>connections with phones.<BR><BR>I have also been able to write data to phones. <BR>However, I am currently having trouble reading data<BR>sent from the phone to the board. <BR><BR>The application running on the phone receives data<BR>from me, displays it, and then echoes it back.<BR><BR>The program I have written is pretty much the same as<BR>the RFCOMM's main.c's cmd_connect function, except now<BR>it receives an argument from the user and sends that<BR>out through a socket once it has connected with a<BR>phone. This part works fine. <BR><BR>Just after the write function call, I call read as:<BR><BR>chk_read = read (sk, readbuff, 2); <BR><BR>with sk being the file descriptor of the socket<BR>connected to the phone, readbuff being an array of<BR>type unsi
 gned
 char and size 100, and reading in only 2<BR>characters. I have earlier initialized readbuff as:<BR><BR>memset (dread, 0, 100);<BR><BR>However, when I send data to the phone and it receives<BR>this data and displays it, once it has sent the data<BR>back to the board, the board does not receive it. <BR>Rather it waits for data to be received, and once<BR>disconnected displays that chk_read has been assigned<BR>a -1, meaning no data has been read. I have called<BR>the read function for reading more than 2 characters<BR>(have used readbuff's maximum size, 100), but still no<BR>good.<BR><BR>Any idead what's going wrong here? Any help will be<BR>greatly appreciated.<BR><BR>Thanks and sincerely,<BR><BR>Naved<BR><BR><BR><BR><BR><BR>--- Marco Trudel <MTRUDEL@GMX.CH>wrote:<BR><BR>&gt; &gt; My question is this: instead of creating a device<BR>&gt; &gt; using ioctl(), do you know how to assign this<BR>&gt; already<BR>&gt; &gt; created device to dev in the above if statement?<BR>&gt; <BR
 >&gt;
 no. I never worked with such devices.<BR>&gt; <BR>&gt; &gt; The device resides in the /dev directory. This is<BR>&gt; a<BR>&gt; &gt; problem I will face even if I write step(6)<BR>&gt; &gt; separately<BR>&gt; <BR>&gt; actually no. There's no need for a device, use a<BR>&gt; socket.<BR>&gt; <BR>&gt; &gt; becuase the question of using an already<BR>&gt; &gt; created device will still come up.<BR>&gt; <BR>&gt; what for? not for bluez...<BR>&gt; <BR>&gt; <BR>&gt; regards<BR>&gt; Marco<BR>&gt; <BR>&gt; <BR>&gt;<BR>-------------------------------------------------------<BR>&gt; SF.Net email is sponsored by: Discover Easy Linux<BR>&gt; Migration Strategies<BR>&gt; from IBM. Find simple to follow Roadmaps,<BR>&gt; straightforward articles,<BR>&gt; informative Webcasts and more! Get everything you<BR>&gt; need to get up to<BR>&gt; speed, fast.<BR>&gt;<BR>http://ads.osdn.com/?ad_id=7477&amp;alloc_id=16492&amp;op=click<BR>&gt; _______________________________________________<BR>&gt; Blu
 ez-users
 mailing list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt;<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>&gt; <BR><BR><BR>__________________________________________________<BR>Do You Yahoo!?<BR>Tired of spam? Yahoo! Mail has the best spam protection around <BR>http://mail.yahoo.com <BR><BR><BR>-------------------------------------------------------<BR>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies<BR>from IBM. Find simple to follow Roadmaps, straightforward articles,<BR>informative Webcasts and more! Get everything you need to get up to<BR>speed, fast. http://ads.osdn.com/?ad_id=7477&amp;alloc_id=16492&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protecti
 on
 around <br>http://mail.yahoo.com 
--0-123862975-1119793010=:62741--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
