Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to recognize whether the connected device is
	a headset
From: Marcel Holtmann <marcel@holtmann.org>
To: Chen Bin <binch@mobilesoft.com.cn>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098352217.1912.4.camel@debian>
References: <1098352217.1912.4.camel@debian>
Content-Type: text/plain
Message-Id: <1098380504.4885.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 21 Oct 2004 19:41:44 +0200

Hi Chen,

> Thanks very much for previous help from Holtman, and I happen a new
> problem when I try to find out whether a connected device is a headset.
> 
> It can't be browsed using sdptool in both connected mode and discovery
> mode(paring state), I wonder how I can know its charactics after
> connected?

actually the class of device value can be inside the inquiry cache and
you will see it when a remote device requests a connection. However we
don't really store these information together with the connection to
make them available afterwards. Any patch is welcome.

What I don't get is why you can't browse when the device is connected?
Run "hcidump -X" as root and show it to us so we can see what happens.

> My phone  will be appeared in 3G conference next month, so I am very
> anxious about the bluetooth feature...

What does this mean? Is it good or is it bad? And btw my first name is
Marcel and not Holtmann.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
