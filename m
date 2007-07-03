Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <468A7156.1050708@gmail.com>
Date: Tue, 03 Jul 2007 21:25:02 +0530
From: Rogue <roguexz@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46896137.90202@gmail.com>
	<d89ddf300707021858u2e5e8f80k35794595254736f6@mail.gmail.com>
In-Reply-To: <d89ddf300707021858u2e5e8f80k35794595254736f6@mail.gmail.com>
Subject: Re: [Bluez-devel] A few questions about bluetooth-alsa project
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad Midgley wrote:
> hey
>
>     So first up, I have built sample spec files that generate rpm
>     files out
>     of sbc and plugz. In case you are interested then I can share them
>     with
>     you all.
>
>
> sure... I could put them in contrib/
>
Do you want me to send them directly to you?

Secondly, if I build an rpm of plugz, i see that the following files are 
being generated:

plugz                     /etc/dbus-1/system.d/a2dpd.conf
plugz                     /usr/bin/a2dpd
plugz                     /usr/bin/a2dpd_ctl
plugz                     /usr/bin/headsetd
plugz                     /usr/lib/alsa-lib/libasound_module_ctl_sco.a
plugz                     /usr/lib/alsa-lib/libasound_module_ctl_sco.la
plugz                     /usr/lib/alsa-lib/libasound_module_ctl_sco.so
plugz                     /usr/lib/alsa-lib/libasound_module_ctl_sco.so.0
plugz                     
/usr/lib/alsa-lib/libasound_module_ctl_sco.so.0.0.0
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_a2dpd.a
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_a2dpd.la
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_a2dpd.so
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_a2dpd.so.0
plugz                     
/usr/lib/alsa-lib/libasound_module_pcm_a2dpd.so.0.0.0
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_sco.a
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_sco.la
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_sco.so
plugz                     /usr/lib/alsa-lib/libasound_module_pcm_sco.so.0
plugz                     
/usr/lib/alsa-lib/libasound_module_pcm_sco.so.0.0.0
plugz                     /usr/lib/liba2dpdcommon.a
plugz                     /usr/lib/liba2dpdcommon.la
plugz                     /usr/lib/liba2dpdcommon.so
plugz                     /usr/lib/liba2dpdcommon.so.0
plugz                     /usr/lib/liba2dpdcommon.so.0.0.0
plugz                     
/usr/share/dbus-1/services/com.access.a2dpd.service

I see that there are some alsa-lib modules being built. So, do I still 
need to specify a custom asoundrc file? Wouldn't the device show up 
automatically in the applet's preferences?

I am sorry if these are ignorant questions, but I am trying to learn 
what I can about this package. Regarding the work that Marcel is doing 
for bluez utils audio service, is there a project / development package 
that I can play around with?

thanks,
Rogue

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
