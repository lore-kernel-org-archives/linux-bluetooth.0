Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ and headset
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402022242.43547.cijoml@volny.cz>
References: <200402022018.05536.cijoml@volny.cz>
	 <1075756519.29899.193.camel@pegasus>  <200402022242.43547.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1075762637.29899.257.camel@pegasus>
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
Date: Mon, 02 Feb 2004 23:57:18 +0100

Hi Michal,

> > the complete SCO/eSCO stuff needs to be reworked, but I don't see any
> > future for an OSS driver. ALSA is the choosen architecture for 2.6 and
> > onwords.
> 
> Well, so implementation from:
> http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
> 
> will never be included and you want write your own implementation?

I don't want to do this, but we have to, because of Bluetooth 1.2 and
eSCO etc. The other point is, that the snd-bluez-sco driver should be
integrated directly into the SCO module and not running as a kernel
thread, because there is no need for it. However I actually don't know
how this all should look like and work together with the Headset and
Cordless Telephony profiles. And what about A2DP which carries audio
streams over an ACL link?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
