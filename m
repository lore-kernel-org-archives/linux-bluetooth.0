Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <494CE2CD.9010303@morrigan.ch>
References: <494CE2CD.9010303@morrigan.ch>
Date: Wed, 24 Dec 2008 00:13:56 +0100
Message-Id: <1230074036.4954.15.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BlueZ4.x, headset and oss problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Manuel,

> I've manged to get my headset running with BlueZ4. Sound and Voice is 
> working very well with Skype.
> 
> Now I tried to use my headset with teamspeak. I tried to run it with 
> aoss teamspeak, but the problem is now I have no /dev/dspx device for 
> the headset.

I don't even have any idea what /dev/dspx is used for. Remember that all
Bluetooth audio is virtual and lives in userspace. So if you require a
kernel device node, then the kernel (meaning ALSA) has to do some magic
here.

Regards

Marcel



------------------------------------------------------------------------------
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
