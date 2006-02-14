Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602140426x662ffa26id1fb386397280da8@mail.gmail.com>
References: <e1effdeb0602130950x5834aa71lb6eeeec3fc5bb4cd@mail.gmail.com>
	 <1139902844.21873.2.camel@localhost>
	 <e1effdeb0602140426x662ffa26id1fb386397280da8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139921486.21873.18.camel@localhost>
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
Date: Tue, 14 Feb 2006 13:51:26 +0100

Hi Claudio,

> > I applied the patch to keep it going, but we need to rework the data
> > object associated with the device path. Using it like this
> >
> >         const uint8_t hci_mode = dbus_data->path_data;
> >
> > won't work forever and actually it is bad coding.
> 
> I don't know exactly what is problem, but I guess it should be related
> to uint32 to uint8 casting.

the casting is not that big problem. It is a misuse of the variable,
because the name is not clear. In other code paths you might use the
path_data variable too and then it clashes. These things are really hard
to debug.

> I will change the path_data to a device settings structure, where I
> want store the scan mode and the discoverable timeout. In my opinion
> the discoverable timeout should be unique for each local adapter. Do
> you have any comments or suggestion?
> 
> 
>  struct device_settings {
>          uint32_t discoverable_to;
>          uint8_t  scan_mode;
>  };
> 
>  struct hci_dbus_data {
>          uint16_t dev_id;
>          uint16_t path_id;
>          struct device_settings dev_settings;
>  };

I don't see any need for another nested structure. Actually I would
prefer using something like this:

	struct hci_dbus_data {
		uint16_t dev_id;
		uint16_t path_id;
		uint8_t mode;
		uint32_t discoverable_timeout;
	}

> I am planning use the SIGALARM. Another option is integrate inside the
> main loop, using a poll timeout. However it is a little bit more
> complicated.

In the end we might need to integrate it into the main loop, because
this looks like the cleanest approach to me. However for now it might be
enough to use SIGALARM.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
