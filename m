Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christopher =?ISO-8859-1?Q?Bergstr=F6m?= <christopher@netsyncro.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050108192216.D6A50416118@ws5-2.us4.outblaze.com>
References: <20050108192216.D6A50416118@ws5-2.us4.outblaze.com>
Content-Type: multipart/alternative; boundary="=-9tyMScWykRiYEmtWVBry"
Message-Id: <1105222194.27527.12.camel@linux.site>
Mime-Version: 1.0
Subject: [Bluez-users] Missing sndmagic.h for btsco kernel patch
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
Date: Sat, 08 Jan 2005 23:09:54 +0100


--=-9tyMScWykRiYEmtWVBry
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Trying to get my bluetooth headset to work and so I'm going through the
steps..

I applied the kernel-2.6.7-8.24-08-04.patch for the btsco driver, but I
realized I'm missing sndmagic.h file.  I'm running Suse 9.2 with the
alsa-devel installed..  I think I noticed that RH/Fedora had a rpm
alsa-lib-devel that included this file, but wasn't sure if I could just
ignore this missing file, most likely not, or if I should give rpm in
the RH/Fedora a shot.  Or is this something simple like copying the
missing file?  First post and help is appreciated.

--=-9tyMScWykRiYEmtWVBry
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.2.4">
</HEAD>
<BODY>
Trying to get my bluetooth headset to work and so I'm going through the steps..<BR>
<BR>
I applied the kernel-2.6.7-8.24-08-04.patch for the btsco driver, but I realized I'm missing sndmagic.h file.&nbsp; I'm running Suse 9.2 with the alsa-devel installed..&nbsp; I think I noticed that RH/Fedora had a rpm alsa-lib-devel that included this file, but wasn't sure if I could just ignore this missing file, most likely not, or if I should give rpm in the RH/Fedora a shot.&nbsp; Or is this something simple like copying the missing file?&nbsp; First post and help is appreciated.
</BODY>
</HTML>

--=-9tyMScWykRiYEmtWVBry--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
