Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Max Number of PANUs supported in PAN
From: Marcel Holtmann <marcel@holtmann.org>
To: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
References: <E1BcqIi-0002cT-53@sc8-sf-list2.sourceforge.net>
	 <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
Content-Type: text/plain
Message-Id: <1087939830.4209.12.camel@pegasus>
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
Date: Tue, 22 Jun 2004 23:30:30 +0200

Hi Assed,

> Can someone tell me the maximum number of users supported in one PAN?
> I guess this question boils down to:
> 
> a) Are PANUs in Parked mode supported (i.e. 200+ PANUs in one PAN 
> possible).
> b) Is the PAN able to juggle PANUs between active and parked mode so 
> they all seem "connected" and are able to communicate with each 
> other.
> 
> Also, can something tell me if something like above is possible in the BT 
> SIG PAN specification, or does it also support a maximum of 8 users in a 
> PAN.

actually this might be possible. I never tried it, but the bigger
problem will be to find a Bluetooth chip that is tested to work with
seven actives slaves and a big number of parked devices in one piconet.

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
