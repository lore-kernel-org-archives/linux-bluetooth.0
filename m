Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0709280019i51e9175bl5a3fa8fa8965c75d@mail.gmail.com>
Date: Fri, 28 Sep 2007 09:19:03 +0200
From: "Andrea Galbusera" <gizero@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Detecting disconnection when using RFCOMM tty API
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,
I have a couple of question I was not able to give an answer to by
digging into the archives or FAQs.

My application uses standard linux tty primitives on the RFCOMM
devices to communicate with remote sensors. The application is
iteratively quering the device by writing command and reading back
answer. This is working fine.

I'm in the need of detecting when a link disconnection occur in order
to handle the situation. How can I do that? Is RFCOMM tty sending a
signal to my process that I can catch?
It would be a good thing also being able to manage when the link comes
back again. Shall I close and reopen the corresponding device or is
there a way to reuse the same file descriptor I was using before the
disconnection occurred?

One more bit...I see RFCOMM can be used also by a socket API. Is this
more flexible/powerfull than the standard tty? At moment I have to
stick to the legacy tty one, but for the future I should consider
switching to it, if there is any potential improvement.

Regards and TIA for help

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
