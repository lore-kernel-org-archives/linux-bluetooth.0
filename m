Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Max Number of PANUs supported in PAN
From: Marcel Holtmann <marcel@holtmann.org>
To: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.BSO.4.58.0406222346200.5451@nemo.student.utwente.nl>
References: <E1BcqIi-0002cT-53@sc8-sf-list2.sourceforge.net>
	 <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
	 <1087939830.4209.12.camel@pegasus>
	 <Pine.BSO.4.58.0406222346200.5451@nemo.student.utwente.nl>
Content-Type: text/plain
Message-Id: <1087942444.4209.45.camel@pegasus>
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
Date: Wed, 23 Jun 2004 00:14:04 +0200

Hi Assed,

> I am not really interested in the actual number of parked devices, I just 
> assumed if you can support one parked slave, you can support an arbirtary 
> number.

I only wanna warn you of the Bluetooth chip limitations. You will play
in a league that is not fun ;)

> I will therefore re-phrase my question to: Can one PAN support 9 PANUs, 
> i.e. there will always be atleast one parked PANU. The GN will now have to 
> juggle PANUs between active and parked modes so they all seem "connected" 
> and are able to communicate with each other.

So actually it is possible to create a PAN with more than 8 members, but
you must manage the parking by yourself. I never tested such stuff and
some broadcast traffic may kick your ass.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
