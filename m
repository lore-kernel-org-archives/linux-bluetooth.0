Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Troubles compiling btsco
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41A39A11.3040906@musikcheck.dk>
References: <41A39A11.3040906@musikcheck.dk>
Content-Type: text/plain
Message-Id: <1101243938.27351.21.camel@pegasus>
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
Date: Tue, 23 Nov 2004 22:05:38 +0100

Hi Hasse,

> I have checked out btsco from cvs from 
> http://www.gargan.org/linux/snd-bt-sco/
> 
> tried to run the bootstrap but i failed because the automake(on my 
> debian sid) didn't include --ignore-deps but only had a include-deps 
> option. I removed that

you need at least automake-1.6 for it and use update-alternatives to
select the default one.

> But when running configure I get this:
> 
> ./configure: line 2919: XIPH_PATH_AO: command not found

Maybe you need to install the libao-dev package.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
