Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076275689.14742.93.camel@akka.yeti.nocrew.org>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1076277250.6869.24.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 08 Feb 2004 22:54:10 +0100

Hi Fredrik,

> Here's an initial draft proposal for hcid DBus interfaces (as 
> currently implemented in hcid 2.4-fn8):
> 
> 	service:   "org.bluez.hcid",
> 	path:      "/org/bluez/hcid/device
> 	interface: "org.bluez.hcid.device

I think of a more generic interface. Not everything is Linux or BlueZ
related ;)

	service:	"org.bluetooth.hci"

It is Bluetooth we are talking about, so use "bluetooth.org" even if we
don't own the domain. I don't care, because it is only a name ;)

The interface is about access to a specific service or protocol, so I
want to use "hci". The hcid is only the implementation of it. For the
future I also think about having D-Bus interfaces for "sdp", "hid" etc.

>            // Returns a dictionary with hci devices
>            // as keys. The values are dictionaries with
>            // the configuration parameters. Example:
>            //    
>            //   { "hci0" : { "type"         : "USB",
>            //                "addr"         : "00:00:00:00:00:00",
>            //                "status"       : "up",
>            //                "name"         : "Fuzz",
>            //                "manufacturer" : "Company" },
>            //     "hci1" : { "type"         : ... } }
>            method: dict(string:dict(string:string)) list(void)
> 
>            // Returns a specific configuration dict with the
>            // parameters as above.
>            method: dict(string:string) get_conf(string hci_dev)

Why not a list of devices and then an extra method for every element? I
want to make this interface as open and as extendable as possible.

>            // Activates an hci device.
>            method: void up(string hci_dev)
>   
>            // Deactivates an hci device.
>            method: void down(string hci_dev)

Of course, this is obvious. What format do we use for the parameter. You
show it as string. This means "hci0" or "11:22:33:44:55:66" or both?

>            // Deactivates an hci device.
>            method: void set_name(string hci_dev, string name)

And I prefer also to have get_name. See comment above.

We must also have something for remote names, so set_local_name,
get_remote_name etc. would maybe better.

> 	service:   "org.bluez.hcid",
> 	path:      "/org/bluez/hcid/keytab
> 	interface: "org.bluez.hcid.keytab
> 
>            // Returns an array with key pairs as a dictionaries.
>            // Example:
>            //    
>            //   [ { "sba" : "00:00:00:00:00:00",
>            //       "dba" : "00:00:00:00:00:00" },
>            //     { "sba" : "00:00:00:00:00:00",
>            //       "dba" : "00:00:00:00:00:00" },
>            //     ... ]
>            method: array(dict(string:string)) list(void|string hci_dev)

I don't wanna use the name "keytab". Maybe "pairing_list".

Something like "is_paired(src, dst)" would also be nice.

>            // Deletes a link pair
>            method: void delete(string sba, string dba)

Yes, but "delete" is too generic.

> 	service:   "org.bluez.hcid",
> 	path:      "/org/bluez/hcid/nametab
> 	interface: "org.bluez.hcid.nametab
> 
>            // Returns a device name or void
>            method: void|string delete(string bdaddr)

As said above. "get_remote_name" and so "del_remote_name".

Now you see that I don't really like the object oriented stuff. I see no
need for "keytab", "nametab" etc. I see this interface more as somekind
of multiplexing for HCI.

> 	path:      "/org/bluez/hcid
> 	interface: "org.bluez.hcid
> 
>            // Notifies applications that device configuration
>            // has changed.
>            signal: void device(void)
> 
>            // Notifies applications that trusted key configuration
>            // has changed.
>            signal: void keytab(void)

Can these signal also give us the new values? Like the HCI events. For
example local_name_changed().

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
