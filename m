Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425C3612.9030609@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth ans Scripts
References: <200504121820.11615.lists@naasa.net>
In-Reply-To: <200504121820.11615.lists@naasa.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Tue, 12 Apr 2005 22:56:50 +0200

Joerg Platte wrote:
> Hi!
> 
> Currently I'm doing some Bluetooth connection and performance tests. I want to 
> create connections, park them and transfer data and so on.

As much as I know, you won't find bluetooth hardware that supports parking.
respectively, you might park devices, but you won't be able to have up to 
248 parked and 7 active devices...
the limit of 7 stays...

> I could write a C 
> program doing all this stuff, but this may take a long time and is not 
> flexible. Does anyone know a Bluez-"frontend" written in a high level 
> (Script) language which is capable of doing all kind of connection handling 
> and data transfer?

java, jsr82?


regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
