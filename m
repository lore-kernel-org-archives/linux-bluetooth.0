Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Mackie <D.Mackie@ru.ac.za>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] running 2 rfcomm modules simultaneously
Message-ID: <20040914124718.GA76088@rucus.ru.ac.za>
References: <20040901130123.GB31321@rucus.ru.ac.za> <1094998092.5695.19.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094998092.5695.19.camel@pegasus>
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
Date: Tue, 14 Sep 2004 14:47:18 +0200

On Sun 2004-09-12 (16:08), Marcel Holtmann wrote:
> > Has anyone done something like this before?
> 
> this is not possible this way. It needs more changes to provide such a
> functionality and you must keep it inside the RFCOMM module. Why do you
> need it?

I had hoped to be able to "pick-up" data sent to the 2nd RFCOMM Module
(using a new PCM value to differentiate it from the "Original") and pass it to
another program to transport it across the network to another PC where it
would be "injected" into a modified module there. At the moment, I am only
loading the modified module, and it not absolutely necessary that both be
loaded at a time, but would be interesting to do.

-dave

-- 
 David Mackie
 MSc Student - Computer Science -  Rhodes University
 email: D.Mackie@ru.ac.za
   web: http://www.cs.ru.ac.za/research/students/g99m0302/


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
