Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to recognize whether the connected device is
	a headset
From: Marcel Holtmann <marcel@holtmann.org>
To: Chen Bin <binch@mobilesoft.com.cn>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098408465.898.15.camel@debian>
References: <1098352217.1912.4.camel@debian>
	 <1098380504.4885.18.camel@pegasus>  <1098408465.898.15.camel@debian>
Content-Type: text/plain
Message-Id: <1098441914.4704.23.camel@pegasus>
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
Date: Fri, 22 Oct 2004 12:45:14 +0200

Hi Chen,

> > actually the class of device value can be inside the inquiry cache and
> > you will see it when a remote device requests a connection. However we
> > don't really store these information together with the connection to
> > make them available afterwards. Any patch is welcome.
> 
> Can you tell me exactly how I can obtain the class of device, including
> using which API or tool or which C file I need to check? I only know the
> sdp approach (code in sdptool.c) to check the services provided by
> device.

this must be done inside the kernel code and actually there is still the
case where the master connects without a previous inquiry and so the
class of device can be unknown.

> > > My phone  will be appeared in 3G conference next month, so I am very
> > > anxious about the bluetooth feature...
> > 
> > What does this mean? Is it good or is it bad? And btw my first name is
> > Marcel and not Holtmann.
> Sorry,Marcel. What I am anxious about is this task is very urgent, the
> bluetooth feature is very important(my boss says), if I can't
> complish...
> 
> Sorry for expressing my individual trifle in this list...

this is ok, but remember that your company wants to make money with a
product and we don't ;)

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
