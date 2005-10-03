Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb051003070847e0d7ac@mail.gmail.com>
References: <e1effdeb05093011224be94d05@mail.gmail.com>
	 <1128160192.8555.6.camel@localhost.localdomain>
	 <e1effdeb051003070847e0d7ac@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128373377.8472.44.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 03 Oct 2005 23:02:57 +0200

Hi Claudio,

> I kept some log information, if you want remove it I can send another
> patch. The error code definition was included. I am using "hciX" in
> the path name until we receive a answer from dbus list. Services under
> the path /org/bluez/Devices weren't implemented yet.
> 
> Is there other changes in this patch?

this thing looks quite good, but now we need to clean up some other
parts of your constants and function naming. And please try to keep the
BlueZ/kernel coding style.

The overall BLUEZ_DBUS prefix looks like a good idea at the beginning,
but I think we don't need it at all. So this should be enough:

#define DEVICE_PATH		"/org/bluez/Device"
#define DEVICE_INTERFACE	"org.bluez.Device"

#define MANAGER_PATH		"/org/bluez/Manager"
#define MANAGER_INTERFACE	"org.bluez.Manager"

Please also stop to shortcut some names. For example DFT for DEFAULT.
Simple write the full name, because then it is easy to read this code.

The other thing is that I don't like the difference between *_REQ and
*_SIG in the names/constants. Please don't use them.

Also please don't include any RFCOMM, PAN, HID etc. related things,
because they are not important right now and they make my life of
merging the initial step into better D-Bus a lot harder.

For the error part we will use org.bluez.Error and not EFailed or
anything like this. Since all the error stuff is currently not used, I
don't think it is a good idea to add it to the initial patch. Looking at
HAL the use of org.bluez.NoSuchDevice, etc. seems to make sense, too.

Do we really need that service_table_t thingy now? I think we should
start without it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
