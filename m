Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40EEC9CD.8030003@gmx.de>
From: Holger Frydrych <h.frydrych@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Logitech diNovo hub not recognized?
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
Date: Fri, 09 Jul 2004 18:37:33 +0200

Hi,

I've bought a Logitech diNovo set some time ago which I have used in 
non-bluetooth mode so far (because I do not have any other bluetooth 
devices anyway, and the procedure to switch into bluetooth mode seemed 
to complicated to me to be worth the time). But now that I've read that 
with the latest tools and kernel patches and the use of the HIDP 
protocol the process should have become quite the easy task, I decided 
to give it a try.
Well, so I downloaded the 2.6.7 kernel, applied the mh1 patch (and 
additionally the ck5 patch, if that matters) and configured it along 
with the bluetooth options. Then I rebooted with the new kernel and 
executed the bluetooth start script, which should have been about all to 
do, at least so far that I've read in this mailing list here. But, well, 
nothing at all happens... The hub does not switch to Bluetooth mode, and 
any attempt to use hcitool to search for bluetooth devices just reports 
me a "device not found" error.
I've since tried to compile the bluetooth parts both as modules and as 
built-in and compiled virtually everything in there, but so far no 
success. I can still use this 'hid2hci' tool, which obviously switches 
the hub to HCI mode, but that results in my keyboard and mouse not 
working anymore, and I didn't succeed in reconnecting them.
So my question is, am I missing something or am I doing it completely 
wrong? Thanks for any help you can offer.


Best regards

Holger Frydrych


P.S.: I did not attach any output or configuration file to this mail 
since I am not really sure what might be helpful. If you need anything, 
just tell me, I'll provide any such feedback that I can.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
