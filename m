Return-Path: <bluez-users-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Smartcard replacement security?
References: <20050323094241.380D34A3@arbetsmyra.dyndns.org> <1111590295.1916.3.camel@pegasus>
In-Reply-To: <1111590295.1916.3.camel@pegasus>
MIME-Version: 1.0
Message-Id: <20050323154630.F2A554A3@arbetsmyra.dyndns.org>
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
Date: Wed, 23 Mar 2005 16:45:52 +0100


> > paired of course. But then, how "unsafe" is this realy? Can someone
> > else spoof my phone and thus fooling my computer other than using
> > some kind of brute force? Authentication is made two-ways, right?
>
> this depends on how your automatic unlocking is working. If you know
> the link key and the BD_ADDR you can spoof anything.
> Marcel


Sure, but I was woundering how hard it is for an intruder to guess the 
link key. Of course if he sniff the traffic while doing the pairing 
with PIN he knows my code, but if he misses this pairing, then what is 
his chanses? The BD_ADDR is of course public (via a nearby scan).

I haven't read the whole spec but minor parts of it. It says 
authentication can be made one-way or both-ways. Do BlueZ support both 
of these ways? Which is the most commonly used?

Regards
/Ronny




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
