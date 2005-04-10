Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050410024913.10180.qmail@web50708.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] pm-325 help
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sat, 9 Apr 2005 19:49:12 -0700 (PDT)


--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi John,
> 
> > As I replied, though, I tried other channels to no
> > avail, and I followed your exact instructions to
> try
> > to find the correct channel, and pasted you the
> > results of that, but never got a response.
> 
> when you reply you always break the thread and this
> is not useful. Fix
> your mail client.
> 
> And if all 30 RFCOMM channel behave the same then
> your phone has some
> weird setting. If the PN command is not answered
> with a response then
> there is no channel, so try the next one.
> 
> Regards
> 
> Marcel
> 
> 


I tried this for channels 0-10 and got nothing
 sdptool search --bdaddr 08:00:37:12:C4:B1 dun
--channel 10
Searching for dun on 08:00:37:12:C4:B1 ...


It seems like rfcomm doesn't show anything either
rfcomm -i 08:00:37:12:C4:B1
returns nothing.




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
