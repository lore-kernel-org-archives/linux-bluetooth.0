Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-ID: <20031224142613.GE2657@elmicha.333200002251-0001.dialin.t-online.de>
References: <3FE5D72B.2000108@nue.et-inf.uni-siegen.de> <1072032518.2684.90.camel@pegasus> <3FE6021B.2010702@nue.et-inf.uni-siegen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FE6021B.2010702@nue.et-inf.uni-siegen.de>
Subject: [Bluez-users] Re: bluepin with SuSE 9.0
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
Date: Wed, 24 Dec 2003 15:26:13 +0100

Michael Schmidt wrote:

> So I ask other people on the mailing list to test the script with other 
> distributions.

I can confirm that your version of the bluepin script works on Gentoo,
when I call

  /usr/local/bin/bluepin in 11:22:33:44:55:66

as root (it asks for the PIN in a nice GTK2 dialog, and prints
"PIN:12345").

The bluepin script from bluez-utils-2.3 didn't work here:

# /usr/bin/bluepin in 11:22:33:44:55:66
Traceback (most recent call last):
  File "/usr/bin/bluepin", line 39, in ?
    class Dialog(GtkDialog):
NameError: name 'GtkDialog' is not defined


Regards...
		Michael


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
