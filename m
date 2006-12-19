Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 19 Dec 2006 16:51:02 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061219155102.GK7959@suse.de>
MIME-Version: 1.0
Subject: [Bluez-devel] hcid.conf options not honored after DBus API had been
	used?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I am observing the following:
After i have set the mode with SetMode and the timeout with
SetDiscoverableTimeout, the corresponding settings in /etc/bluetooth/hcid.c=
onf
(discovto for example) are no longer used (i can enter there whatever i want
and restart hcid, but hcid simply won't care).

I am assuming this is a feature :-)
I am, however, getting some bugreports of people that are confused that
this no longer "works as expected", especially since they are making settin=
gs
in a config tool (let's call it "YaST" :-) which are not honored.

So how to proceed here best? Let YaST write the hcid.conf _and_ set the
settings with apitest? Just drop this part of the YaST configuration tool?
Remove /var/lib/bluetooth/*/config on every boot? ;-)

I am right now tempted to say "we do no longer need a system wide config
tool since we have the DBus API" and drop almost all of the YaST
bluetooth module (keep only the stuff where you can disable bluetooth
completely, enable each daemon separately and specify the daemon
options).
But then, shouldn't we remove all the stuff that is more or less
obsolete from the shipped hcid.conf and just use compiled-in defaults
until somebody comes along and configures the system via the DBus API?

Any opinions? How is this handled on other distributions?
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
