Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1127399305.5344.36.camel@blade>
Mime-Version: 1.0
Subject: [Bluez-devel] D-Bus patching session opened
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
Date: Thu, 22 Sep 2005 16:28:25 +0200

Hi,

after I dropped the D-Bus 0.23 API support it is now time to really play
with the integration of D-Bus support into hcid and other daemons. This
is the first step into creating a full D-Bus aware bluetoothd in the
future.

I like to see some more D-Bus enhancements now and Claudio already
started and he's working hard in explaining his work and making me
happy. So please help him and review his code and send small patches to
make the D-Bus experience better. I think about making the D-Bus a core
dependency of bluez-utils. Does anybody have any arguments against it?

Next thing that I like to see are some Python applications that are
using GTK+ and D-Bus for a graphical interface to BlueZ. For that I
think about creating a bluez-python package. Therefor we need people who
are writing the code and other people who are creating some nice fancy
icons and graphics for it. First thing should be a D-Bus aware PIN
helper written completely in Python.

There exists a job/task for everyone :)

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
