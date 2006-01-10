Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C3E565.6080605@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Info a2play
References: <5307d89f0512200011i7a6784dfie08a56569a90381d@mail.gmail.com> <5307d89f0512201320g34b2d793p178bbd501d473e95@mail.gmail.com>
In-Reply-To: <5307d89f0512201320g34b2d793p178bbd501d473e95@mail.gmail.com>
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
Date: Tue, 10 Jan 2006 09:48:37 -0700

Patrick

> The following syntax works perfectly now!
> beep-media-player | sox -c 2 -t raw -r 44100 -w -s - -t au - |
> ./a2play -p  00:0D:44:2A:14:66
> 
> But there is still one problem: the music gets interrupted very often.
> I now used the -p option but that still doesn't help.
> On Windows XP and my cellphone, it works perfectly.

Are you using nvidia drivers? My laptop with nvidia would chop up the
audio every time I switched between windows. I think the nvidia driver
is interfering with our rtc.

My fujitsu w/ATI doesn't have the problem.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
