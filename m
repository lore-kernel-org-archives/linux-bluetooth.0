Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection not completing?????  DT120 and T3 palm
From: Marcel Holtmann <marcel@holtmann.org>
To: J C <jjcar1526@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY14-F24b6JsnVnlBd00052861@hotmail.com>
References: <BAY14-F24b6JsnVnlBd00052861@hotmail.com>
Content-Type: text/plain
Message-Id: <1079629695.3301.53.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 18 Mar 2004 18:08:15 +0100

Hi John,

>   I am having a problem.  I first set up on my linux workstation the 
> software needed to get my T3 to surf the net through my linux box.  That all 
> seems to work well.  I next tried to get it to work on a pc104+ embedded 
> computer.  I am running the same kernel and have set things up the same way. 
>   But when I try to connect the palm to the embedded computer it fails.
> 
>   I can scan the T3 using hcitool scan.  I just am not sure why there is a 
> disconnect instead of the connection being passed so the dund daemon can 
> pick it up and start a ppp connection.  As I mentioned earlier this all 
> works on my work station.  I have spd, hcid, and dund all running.  All the 
> necessary modules load up fine too.  If anyone could please advise me.

what kernel version do use? What version of the tools are compiled? How
do you start dund?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
