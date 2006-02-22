Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43FC9783.5050708@tootai.net>
From: Administrator TOOTAI <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
References: <43FB7C2C.2030203@tootai.net> <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>
In-Reply-To: <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 22 Feb 2006 17:55:31 +0100

John McCabe-Dansted a =E9crit :

>I found that killing all running kmix processes allowed me to shutdown.
>this can be done by typing from the command line:
>        killall kmix
>        killall -9 kmix
>
>Does this help? What desktop are you using? (E.g. KDE or Gnome)
> =20
>
I killed all stuff concerning sound, it change nothing.

Brad: who could be able to help us to solve the problem? If I good=20
remember, 2.6.14 or earlier 2.6.15 had'nt have the problem. Could it be=20
related to the modification made in btsco version 1.9 (begining of month)=
?

>On 2/22/06, Administrator TOOTAI <admin@tootai.net> wrote:
> =20
>
>>Hi all,
>>
>>I face a problem using Suspend2+hibernate with snd-bt-sco and latest
>>2.6.15-4 from Debian SID.
>>
>>Feb 21 21:29:32 nomade kernel: Stopping tasks failed.
>>Feb 21 21:29:32 nomade kernel: Tasks that refused to be refrigerated an=
d
>>haven't since exited:
>>Feb 21 21:29:32 nomade kernel:  - snd-bt-scod (#2708) signalled and tod=
o
>>list empty.
>>   =20
>>
--=20
Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
