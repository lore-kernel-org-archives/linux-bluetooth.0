Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 25 Mar 2007 20:35:05 +0200
MIME-Version: 1.0
Message-Id: <200703252035.05891.dgollub@suse.de>
Subject: [Bluez-devel] Input service and multiple adapters
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

Hi folks,

i started playing around with the Input DBUS API and found an obscurity whe=
n =

multiple bluetooth adapters are used. Actually this is a really rare use =

case...

If i use Adapter A and call CreateDevice() and Connect() to an input device=
 .. =

everything works as expected. If Adapter A got unplugged/broken and got =

replaced by Adapter B and call CreateDevice() for the same input device. Th=
e =

result will be org.bluez.input.AlreadyExists

Again.. this is a really rare use case, but is it intended to only have one =

input device configuration for the system? What about having input device =

configuration for each Adapter?

(ugly) Example:

Interface=B7      org.bluez.input.Manager
Object path=B7    /org/bluez/input/{Adapter MAC Address ...}

This makes also the integration in the GUI a bit easier. So we can display =

which input device is configured per adapter. And suppress the output of =

bluetooth input devices if the responsible adapter is unplugged/off.

Or am i completely wrong and missed something...
... if not i fear the same problem for the Audio DBUS API as well.

best regards,
Daniel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
