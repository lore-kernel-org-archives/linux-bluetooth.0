Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Nicholas =?iso-8859-1?Q?A=2E_Prey=DF?= <nalp@gmx.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: [Bluez-devel] syntax for advertising a service with specific uuid
Message-ID: <20040428234554.GA2901@gmx.net>
References: <409032E8.70506@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <409032E8.70506@sun.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Apr 2004 01:45:55 +0200

On  0, Nikita Tovstoles <Nikita.Tovstoles@Sun.COM> wrote:
> Marcel Holtmann wrote:
> >>i'm not sure of the sdptool syntax for step 2.
> >>
> >>problem:
> >>1.when i do step 1, i get "Serial Port registered". but, if i issue 
> >>"sdptool get SP" afterwards, i get description of
> >>"SDP Server" (0x1000). shouldn't it return something like 
> >>"SerialPort" (0x1101)  - service class id for SerialPort per bt spec?
> >>note: actually even if i issue "sdptool add LAN", subsequent "sdptool 
> >>get LAN" returns same description as above.
> >>  
> >
> >
> >I prefer you read the manpage of sdptool. The get command needs the
> >record handle of the previous created record.
> > 
> >
> "man sdptool" returns nothing. the only thing i can look at is "sdptool 
> --help". if that's not what you were referring to, where is sdptool's 
> manpage?
> 
> %sdptool add --help
> add [--channel] service
> thanks

Maybe you are using an old/custom package of the bluez-utils that doesn't 
contain it. 

Check out CVS for the specific manpage:
bluez-utils/utils/tools/sdptool.1 
or upgrade your system too newest utils version, which should install
man page by default.

nicholas




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
