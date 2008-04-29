Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 29 Apr 2008 22:46:57 +0800
MIME-Version: 1.0
Message-Id: <200804292246.57527.Jerry87905@gmail.com>
From: Dylan <jerry87905@gmail.com>
Subject: [Bluez-devel] [GSoC 2008]bluez-python
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Greetings everyone,
I should send this earlier, ok....
First I wanna thank you guys for giving me this great opportunity. I believe 
it will be a pleasure to work with Bluez Develop team.
My name is Li Dongyang and bluez-python is a high level python binding to 
bluez using dbus-python. It will just face to Bluez 4.X API.

Currently we've encountred 2 problems.
One is about the mainloop.Many dbus and bluez operations need a mainloop,
and an option is let the user specify the mainloop they wanna use, and we 
check the type of the mainloop, and import dbus.mainloop.glib(for gmainloop) 
or dbus.mainloop.qt(for qt4 mainloop) and many other mainloops , and then set 
it as the default mainloop.
Another is about the plugin system, when new plugin come out, an option is to 
use org.freedesktop.DBus.Introspectable get the API xml, however, this makes 
we difficult to modify the method. for example, we want DefaultHeadset() of 
bluez-python return an object(not the dbus object) instance of AudioDevice or 
Headset, not the dbus object path.

Anyone wanna discuss about bluez-python, fell free to mail me or ping me at 
#bluez, my nick is missed(GMT +8)

Cheers

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
