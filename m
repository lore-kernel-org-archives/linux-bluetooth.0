Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOIEGLCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <43984EAC.7080805@xmission.com>
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
Date: Thu, 8 Dec 2005 15:42:53 -0000

Hi Brad, Marcel, Steven,

I've decided to go ahead with the kernel upgrade (unless of course you guys
advise me not to) because:
1. I think asterisk will require snd-bt-sco given my recent experience
trying to troubleshoot sound settings for asterisk; asterisk does try to
acces /dev/dsp on the machine...
2. the sco packets from the hcidump call trace change with voice input at
either end of the call (from the softphone and from the deskphone), despite
there being no sound at either end, I am optimistic that I can achieve
two-way audio should I have snd-bt-sco in the kernel.

Brad, when you said I should rebuild the kernel with a newer version, you
said:
>You'll have to rebuild sco_bt_snd too.
How can I do this? I have never done this before...

Kind Regards

Khaled

> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Brad
> Midgley
> Sent: 08 December 2005 15:18
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Bluetooth Voice Setting
>
>
> Khaled
>
> What I'm saying is asterisk either connects to (eg) /dev/dsp1 or the
> alsa device, invoking snd-bt-sco which sends/receives over bluetooth
> sockets OR asterisk sends and receives over bluetooth sockets without
> bothering with snd-bt-sco. Have a look at the code or ask the
> asterisk guy.
>
> Brad
>
> > If I am trying to use voip, then wouldn't the application
> (asterisk) require
> > the snd_bt_sco module? Perhaps this is why I am not getting any
> sound (as
> > shown in the hcidump output of my last message).
> > Is this a sensible assumption because I am using a softphone that is
> > connected to the machine configured as a handsfree headset via voip?
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep
> through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
