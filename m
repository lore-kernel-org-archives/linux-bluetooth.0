Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Jerky MX900 mouse movement with 2.6.7-mh1,
	hidp and hidd
From: Marcel Holtmann <marcel@holtmann.org>
To: Vesa Halttunen <vesuri@jormas.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087769891.524.2.camel@pc.vesuri.net>
References: <1087757523.839.10.camel@pc.vesuri.net>
	 <1087767604.4781.52.camel@pegasus>  <1087760721.1232.5.camel@pc.vesuri.net>
	 <1087770579.4781.59.camel@pegasus> <1087763282.1232.17.camel@pc.vesuri.net>
	 <1087765554.4781.67.camel@pegasus>  <1087764428.551.3.camel@pc.vesuri.net>
	 <1087768641.4781.74.camel@pegasus>  <1087767270.860.4.camel@pc.vesuri.net>
	 <1087774058.4781.140.camel@pegasus>  <1087769891.524.2.camel@pc.vesuri.net>
Content-Type: text/plain
Message-Id: <1087787761.4781.152.camel@pegasus>
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
Date: Mon, 21 Jun 2004 05:16:02 +0200

Hi Vesa,

> > I recharged the batteries of my MX900 and I don't have any problem with
> > it. The mouse is working perfect with my setup.
> 
> Uhhuh. This is embarrassing.
> 
> It turned out that I wasn't running hcid at all. I commented it out
> since I thought it isn't necessary with hidd. I was wrong.
> 
> Everything works fine now - no need for bthid. Thanks again for help. :)

I didn't see how this was connected to hcid, but if it works, everything
is fine. Have fun with it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
