Return-Path: <cyrus@holtmann.org>
From: "Bram Jansen" <bramsbox@gmail.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
References: <AE1FAD2818FF4B8E90DE8C156874A782@radon>
	<E1F40683-65D7-49AC-A515-44D9035ED97A@gmail.com>
Date: Wed, 9 Jul 2008 11:28:21 +0200
Message-ID: <A11CE28965CC41E7BAE76CD934C7F6F0@radon>
MIME-Version: 1.0
In-Reply-To: <E1F40683-65D7-49AC-A515-44D9035ED97A@gmail.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Host is down
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Johan,

This did the trick.
Thanks a lot.

Regards,

Bram

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Johan
Hedberg
Sent: 08 July 2008 19:38
To: BlueZ users
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Host is down

Hi Bram,

On Jul 8, 2008, at 20:19, Bram Jansen wrote:
> Can anyone please point me in the right direction about why after  
> the above steps I only see the following line when I type
>
> rfcomm show rfcomm0
>
> I get the result
>             rfcomm0: 01:00:00:00:00:00 channel 1 clean
>
> and not
>             rfcomm0: <bdaddr> channel 1 clean

That's because (as the man-page states) the parameters to rfcomm bind  
are:
rfcomm bind <dev> <bdaddr> <channel>

Where <dev> is the number of the device node you want to use (e.g. 0  
for rfcomm0).

If you give the command as you do the rfcomm tool will interpret your  
bdaddr as the device node number (atoi(00:...") will yield 0) and 1 as  
the remote address (which is why you see "01:00:...") and use the  
channel 1 which is the default when no channel has been specified.

Johan

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
