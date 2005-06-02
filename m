Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050602164634.85367.qmail@web26108.mail.ukl.yahoo.com>
From: Rodrigo Almeida <rodrigoalmeida_fr@yahoo.fr>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Newbie Question: Setting 2 BT Mice to specific /dev/input/mouse* files
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
Date: Thu, 2 Jun 2005 18:46:33 +0200 (CEST)

Hi

(I'm in a Vanilla kernel, 2.6.11-mh2 patch, with the
Logitech DiNovo USB HUB in HCI mode with 2 IOGEAR mini
mice)

I'm working on a project that uses 2 BT Mice
simultaneously. They don't perform the same functions
(core pointer control, ex.) each one has a specific
interaction function associated. In order to deal with
these two mice separately, I've to write in my
XF86Config file like this:

  Option       "Device" "/dev/input/mouse1"
and
  Option       "Device" "/dev/input/mouse2"

rather than:
  Option       "Device" "/dev/input/mice"
and
  Option       "Device" "/dev/input/mice"

The problem for me is that bluetooth mice seems to
behave differently than other mice. They'll not keep
on the same /dev/input/mouse* during all the use time,
but they will change from the /dev/input/mouse2 to
/dev/input/mouse3, for example.

I've searched in this mail list for related problems
with no success. I've also read some HOTPLUG tutorials
and FAQs but I haven't found anywhere yet containing
clues to the way that this dev files are picked.

Does anyone knows some pointer or FAQ to these issues
of DEV files or a clue for why BlueZ works like this?

Thanks for any help,
Rodrigo


	

	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
