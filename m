Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602241539w43797d37i6fa2321a12693a12@mail.gmail.com>
From: "John McCabe-Dansted" <gmatht@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
In-Reply-To: <43FF1CE1.90604@tootai.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43FB7C2C.2030203@tootai.net>
	 <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>
	 <43FC9783.5050708@tootai.net>
	 <fd87b6160602221602i3e3ea582md5f31fb4b69e5d65@mail.gmail.com>
	 <43FE2C18.7030306@tootai.net>
	 <fd87b6160602231604i5574b370uba09acf45c7d1a14@mail.gmail.com>
	 <43FF1CE1.90604@tootai.net>
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
Date: Sat, 25 Feb 2006 12:39:40 +1300

On 2/25/06, Administrator TOOTAI <admin@tootai.net> wrote:
> John McCabe-Dansted a =E9crit :
> >If you really don't have any bluetooth devices, you may as well stop
> >snd-bt-sco from loading next time you boot, e.g. by typing
> >         sudo mv /lib/modules/`uname -r`/extra/snd-bt-sco.ko{,.bak}
> >
> >
> Ah, I can do this ;-)?
>
> Sure I have I have a bluetooth device, my sentence is to be understand
> like "at the time I want to hibernate, no bluetooth device is attached." =
:-)

I just remembered, hibernated doesn't work for me either when
snd_bt_sco is *loaded*. However, if there are no processes are using
it,  you should be able to remove it using the rmmod command,
   i.e. rmmod -w snd_bt_sco.

For this reason I have added:

  killall kmix
  killall btsco
  (sleep 1
  killall -9 kmix
  killall -9 btsco)
  rmmod -w snd_bt_sco &

To the start of my /usr/sbin/hibernate file. This allows me to
reliably hibernate (with kubuntu 5.10, you may have to kill a
different set of processes, though I doubt that you will have to kill
all processes listed by <lsof | grep snd>) . I have also added

  modprobe snd_bt_sco

to the end of this file so as to reload the module when coming out of hiber=
nate.

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
