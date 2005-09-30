Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Heike C. Zimmerer" <nospam05q2@gmx.net>
Message-ID: <dhj2vm$qdg$1@sea.gmane.org>
References: <BAY108-F5564514E2210C816E00E2D68F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Logitehc BT headset question
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
Date: Fri, 30 Sep 2005 12:03:51 +0200

"djails sliajd" <djails@hotmail.com> writes:

> It looks like this headset has some minor bugs (at least the one I have). I 
> would like to know if anyone has had sucessful tries with the logitech 
> mobile pro or mobile freedom headset with bluez and btsco.

The Mobile Pro is running here.  The only thing that doesn't work is
mic gain - the mixer setting doesn't do anything.  For now, I'm using
a patched btsco which does the mixing by software.  This, however,
doesn't really belong into the driver, but until now I didn't have the
time to mess around with ALSA and its softmixer plugin.

Greetings,

Heike



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
