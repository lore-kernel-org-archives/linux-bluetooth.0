Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <IA90PC$632BFAAAF7249FD9F21D4DC661567C69@libero.it>
References: <IA90PC$632BFAAAF7249FD9F21D4DC661567C69@libero.it>
Content-Type: text/plain
Message-Id: <1105613213.7961.158.camel@pegasus>
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
Date: Thu, 13 Jan 2005 11:46:53 +0100

Hi Jers,

> > > # Default link mode
> > > #   none   - no specific policy
> > > #   accept - always accept incoming connections
> > > #   master - become master on incoming connections,
> > > #            deny role switch on outgoing connections
> > > #
> > > lm accept,master;
> > > #
> > > #lm accept;
> >
> > you changed this. Why? There can't be two device with a master role in
> > the same a piconet.
> 
> I know that. Maybe I wasn't accurate in the description of my problem. I'm
> sorry...
> The above script is the hcid.conf file of the master. For slaves I have "lm
> accept".

this is not needed, because you use "pand --master ..." and this is
enought to force the role switch.

> I want to create a piconet with a single master and two slaves.
> In a previous corrispondance, you suggested me:
> - to upgrade my bluez packages. I did that.
> - to check the limitation for firmware pre HCI 16.4. I did that.
> 
> - to check the link policy because the "hciconfig -a" command showed it no
> set for any device. This is my current problem.
> 
> "hciconfig -a" still shows me that there is no link policy set for any
> device but, for all dongles,  in the hcid.conf I have

Is hcid running?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
