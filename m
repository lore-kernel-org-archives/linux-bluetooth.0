Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050819193855.GA25514@uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] btsco - a few comments and a small .py script
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 Aug 2005 21:38:55 +0200

Hi folks,

I've played around with btsco the last few days - now it sort of works
like intended.

I got the following comments about the procedure:

1. I'd like to suggest to put the comment about compatible dongles on
   the btsco website a little clearer.

   "If it doesn't say anything at all about SCO mapping, " wasn't clear 
   to me (being a bluetooth newbie), as it was "displaying something
   with SCO" (i.e. the MTU, but I didn't grasp the difference at first,
   as my first adapter didn't show more than the first 2 lines).

   I'd suggest to put a simple exaple there, how the results from
   "hciconfig hci0 revision" should look like. I.e. that the line 
   "SCO mapping:  HCI" should exist.


2. I think the following comment might be something for the BlueZ-FAQ,
   as I have seen more people with this problem, while googling for
   a solution:

Q: I have used the same bluetooth dongle on different machines or with
different machine configurations (e.g. using windows). Now my device
will refuse to pair again with the dongle.

A: Remove the line in /var/lib/bluetooth/[my-bdaddr]/linkkeys that is
corresponding to the device that doesn't want to pair. BlueZ thinks it
is already paired, but the Link-Key does not match.

   Another - maybe better - solution would be to initiate a re-pair
   request in case the Link fails due to wrong keys.

   I had the case that I first tested the newly bought (CSR) dongle
   using the laptop, while I actually wanted to use it on the desktop
   later. After being paired with the laptop, the headset refused
   to pair with the desktop with the same dongle.

   I've seen a rather recent question that seems to be the same problem
   on bluez-users. However the hints there point to
   /etc/bluetooth/linkkeys - is this outdated or is this due to me using
   debian packages?

   Another - possibly very interesting - solution would be to allow to
   change the bdaddr in software. This would allow me to fake the same
   dongle to have two different bdaddrs depending on where I use it,
   thus allowing the headset to correctly pair with _both_ devices,
   so that I only need to move the dongle and everything works.

   Is there such a command? Please excuse, if it is obvious. I'm very
   new to this stuff.

3. I have written a small Python-Script and a .btscorc that allows me
   to pick up Skype calls with the headset button. I got to hold the
   button, as it otherwise will just change the volume and reacting on
   those AT sequences didn't seem like a good idea to me.

   I'm not sure, if the AT-command is always the same, but that's easy
   enough to adjust. The files are at:

   http://www.acs.uni-duesseldorf.de/~becka/download/skype/

   The python script is probably ugly. I have no clue abou python -
   I just mangled the skype sample script.

4. I also have the "microphone transmits noise" problem sometimes
   (rarely). Could it be, that there is a missed byte that swaps high
   and lowbyte? It sounded a bit like this to me.

5. My cheap (EUR 22.- incl. VAT) LevelOne BLH-1000 Headset works fine,
   except for the glitch just described. It ignores microphone level
   setup, though. Loopback control works. Using the buttons, you can
   only reach Speaker Level 12 (80%) - using the mixer you can go to
   100%.


Have fun, 

Andy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
