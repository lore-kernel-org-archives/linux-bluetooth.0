Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] running 2 rfcomm modules simultaneously
From: Marcel Holtmann <marcel@holtmann.org>
To: David Mackie <D.Mackie@ru.ac.za>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040914124718.GA76088@rucus.ru.ac.za>
References: <20040901130123.GB31321@rucus.ru.ac.za>
	 <1094998092.5695.19.camel@pegasus>  <20040914124718.GA76088@rucus.ru.ac.za>
Content-Type: text/plain
Message-Id: <1095167315.5695.136.camel@pegasus>
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
Date: Tue, 14 Sep 2004 15:08:35 +0200

Hi David,

> > this is not possible this way. It needs more changes to provide such a
> > functionality and you must keep it inside the RFCOMM module. Why do you
> > need it?
> 
> I had hoped to be able to "pick-up" data sent to the 2nd RFCOMM Module
> (using a new PCM value to differentiate it from the "Original") and pass it to
> another program to transport it across the network to another PC where it
> would be "injected" into a modified module there. At the moment, I am only
> loading the modified module, and it not absolutely necessary that both be
> loaded at a time, but would be interesting to do.

I don't really understand what you are trying to achieve, but I think
you should try it without putting RFCOMM on another PSM.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
