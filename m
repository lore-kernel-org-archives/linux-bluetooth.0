Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061219155102.GK7959@suse.de>
References: <20061219155102.GK7959@suse.de>
Date: Tue, 19 Dec 2006 17:00:53 +0100
Message-Id: <1166544053.7309.7.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid.conf options not honored after DBus API
	had	been used?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> I am observing the following:
> After i have set the mode with SetMode and the timeout with
> SetDiscoverableTimeout, the corresponding settings in /etc/bluetooth/hcid.conf
> (discovto for example) are no longer used (i can enter there whatever i want
> and restart hcid, but hcid simply won't care).
> 
> I am assuming this is a feature :-)
> I am, however, getting some bugreports of people that are confused that
> this no longer "works as expected", especially since they are making settings
> in a config tool (let's call it "YaST" :-) which are not honored.
> 
> So how to proceed here best? Let YaST write the hcid.conf _and_ set the
> settings with apitest? Just drop this part of the YaST configuration tool?
> Remove /var/lib/bluetooth/*/config on every boot? ;-)
> 
> I am right now tempted to say "we do no longer need a system wide config
> tool since we have the DBus API" and drop almost all of the YaST
> bluetooth module (keep only the stuff where you can disable bluetooth
> completely, enable each daemon separately and specify the daemon
> options).
> But then, shouldn't we remove all the stuff that is more or less
> obsolete from the shipped hcid.conf and just use compiled-in defaults
> until somebody comes along and configures the system via the DBus API?
> 
> Any opinions? How is this handled on other distributions?

once you have values set through the D-Bus API they have priority and
that is the only possible choice. The provided configuration options in
hcid.conf are only default values for the distributions. No user should
ever modify these values. This also means that YaST should no longer
modify hcid.conf. Simply call the appropriate method via dbus-send.

In general you can have as many configuration tools as you want. The
only small thing you need to take care of is to listen to signals for
your settings, because another tool might change a value while you are
running.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
