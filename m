Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43FCA1EA.8080400@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
References: <43FB7C2C.2030203@tootai.net> <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com> <43FC9783.5050708@tootai.net>
In-Reply-To: <43FC9783.5050708@tootai.net>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 22 Feb 2006 10:39:54 -0700

Hi

> I killed all stuff concerning sound, it change nothing.
> 
> Brad: who could be able to help us to solve the problem? If I good
> remember, 2.6.14 or earlier 2.6.15 had'nt have the problem. Could it be
> related to the modification made in btsco version 1.9 (begining of month)?

This has been a longstanding bug... maybe your setup changed recently to
cause it to show up.

The change last week shouldn't affect this. The only significant change
was between .40 and .41 and was there to enforce card ordering iirc.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
