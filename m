Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <424C151B.9090008@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco + Plantronics headset + Trust bt dongle -
 stops after 1 sec
References: <1112223455.7866.14.camel@localhost.localdomain>
In-Reply-To: <1112223455.7866.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 31 Mar 2005 08:19:55 -0700

Francesco

I haven't seen anyone else reporting this same problem. I agree the 
adapter diagnostics look fishy. I think it would likely help the SCO 
connection to have a different/newer adapter.

Brad

> Hi everybody and thanks for the help.
> I'm running ubuntu warty (kernel 2.6.8.1) compiled for K7, using
> bluez-utils 2.7.
> I've got a Plantronics M3000 headset and a Trust BT120 bluetooth USB
> dongle and i can't for my life get them to work together.
> I compiled btsco from CVS, kernel module included, the dongle's drivers
> get loaded (it works, at least partially, because i used it with my old
> nokia to browse the web), the snd-bt-sco module too, without warnings or
> errors. 
> Launching btsco, it seems to work, the RFCOMM connection works, clicks
> on the headset buttons are reported and acted upon, but any application
> trying to record from the headset gets only 1 second of (bad) audio and
> then stops, while playback never works, just gives background noise (but
> the headset actually becomes 'active' when an app tries to play
> something)
> Hcidump shows SCO packets from handset with voice in it (packets payload
> varies with audio in input in the microphone)
> I also failed when trying the same setup with chan_bluetooth in asterisk
> in more or less in the same way, so i suppose it's a matter of
> compatibility ?


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
