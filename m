Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket CF adaptor, limited to 2-3KB/sec RFCOMM
	PPP connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jay W. Summet" <summetj@cc.gatech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0410201018500.19016@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
	 <1097752969.4640.40.camel@notepaq>
	 <Pine.GSO.4.58.0410141051300.8280@gaia3.cc.gatech.edu>
	 <1097929292.4911.37.camel@pegasus>
	 <Pine.GSO.4.58.0410201018500.19016@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1098287183.13853.15.camel@pegasus>
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
Date: Wed, 20 Oct 2004 17:46:23 +0200

Hi Jay,

> > what I assume is that the link manager on the Socket card is not doing a
> > good job, because it should select a different packet type automaticly
> > to get the best troughput as possible. However this card is very old and
> > maybe you should simply ask Socket to get one of there newer cards with
> > a CSR chip.
> 
> This card should be the latest that Socket makes, I just bought it, and
> the "Rev" version is "G". The card is software upgradable, but my
> understanding is that the latest firmware is version G.
> 
> Do you know of a newer card that they make?

if it is the G version then it won't work with the dtl1_cs driver. What
does "hciconfig -a" say?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
