Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43FB7F8F.3030707@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
References: <43FB7C2C.2030203@tootai.net>
In-Reply-To: <43FB7C2C.2030203@tootai.net>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Tue, 21 Feb 2006 14:01:03 -0700

Hi

This is a known problem. It sounds like stopping the btsco userspace app
first doesn't necessarily help (but it might). We might just be missing
something small... we need help here from someone who is motivated to
dig into the problem.

Brad

> I face a problem using Suspend2+hibernate with snd-bt-sco and latest
> 2.6.15-4 from Debian SID.
> 
> Feb 21 21:29:32 nomade kernel: Stopping tasks failed.
> Feb 21 21:29:32 nomade kernel: Tasks that refused to be refrigerated and
> haven't since exited:
> Feb 21 21:29:32 nomade kernel:  - snd-bt-scod (#2708) signalled and todo
> list empty.
> 
> Thanks for any hint.
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
