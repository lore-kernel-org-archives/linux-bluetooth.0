Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>
From: "John McCabe-Dansted" <gmatht@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
In-Reply-To: <43FB7C2C.2030203@tootai.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43FB7C2C.2030203@tootai.net>
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
Date: Wed, 22 Feb 2006 12:05:59 +1300

I found that killing all running kmix processes allowed me to shutdown.
this can be done by typing from the command line:
        killall kmix
        killall -9 kmix

Does this help? What desktop are you using? (E.g. KDE or Gnome)

On 2/22/06, Administrator TOOTAI <admin@tootai.net> wrote:
> Hi all,
>
> I face a problem using Suspend2+hibernate with snd-bt-sco and latest
> 2.6.15-4 from Debian SID.
>
> Feb 21 21:29:32 nomade kernel: Stopping tasks failed.
> Feb 21 21:29:32 nomade kernel: Tasks that refused to be refrigerated and
> haven't since exited:
> Feb 21 21:29:32 nomade kernel:  - snd-bt-scod (#2708) signalled and todo
> list empty.

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
