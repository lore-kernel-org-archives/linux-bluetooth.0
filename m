Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to recognize whether the connected device
	isa headset
From: Marcel Holtmann <marcel@holtmann.org>
To: binch@mobilesoft.com.cn
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041023033956.B69D23669@mail.mobilesoft.com.cn>
References: <20041023033956.B69D23669@mail.mobilesoft.com.cn>
Content-Type: text/plain
Message-Id: <1098539260.26310.5.camel@pegasus>
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
Date: Sat, 23 Oct 2004 15:47:39 +0200

Hi Chen,

> >> > actually the class of device value can be inside the inquiry cache and
> >> > you will see it when a remote device requests a connection. However we
> >> > don't really store these information together with the connection to
> >> > make them available afterwards. Any patch is welcome.
> >> 
> >> Can you tell me exactly how I can obtain the class of device, including
> >> using which API or tool or which C file I need to check? I only know the
> >> sdp approach (code in sdptool.c) to check the services provided by
> >> device.
> >
> >this must be done inside the kernel code and actually there is still the
> >case where the master connects without a previous inquiry and so the
> >class of device can be unknown.
> I have tried hcitool inq command and find that at the last column there is a 
> 'class: 0x200404', I refer to the BT spec then find that this can be used for
> my purpose, am I right? But what do you mean that this task must be done in
> the kernel?

when you run you get a copy of the inquiry cache inside the kernel. The
cache is per host device. If some creates a connection the COD value
from the inquiry should be copied over to the hci_conn structure. For an
incoming connection it must be copied from the connection request event,
but there is still a connection creation without a previous inquiry that
may don't have valid COD value. If this is changed then you have the COD
along with the other information of your specific connection. You can
workaround in userspace, but this is more complex then doing a patch for
the kernel HCI layer.

> >> > > My phone  will be appeared in 3G conference next month, so I am very
> >> > > anxious about the bluetooth feature...
> >> > 
> >> > What does this mean? Is it good or is it bad? And btw my first name is
> >> > Marcel and not Holtmann.
> >> Sorry,Marcel. What I am anxious about is this task is very urgent, the
> >> bluetooth feature is very important(my boss says), if I can't
> >> complish...
> >> 
> >> Sorry for expressing my individual trifle in this list...
> >
> >this is ok, but remember that your company wants to make money with a
> >product and we don't ;)
> Thanks. Actually, I am a driver engineer, my manager send me to do the driver for
> our Bluetooth chip, after some investigate I find the driver is not needed if we 
> don't use vendor-specific command, the BlueZ is really a very good stuff.

and even specific vendor commands are possible. Take a look at the
hciattach source code or the cmd_revision() part of hciconfig. Oh and
btw what kind of Bluetooth chip are you using?

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
