Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076267396.2670.58.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076275689.14742.93.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 22:28:09 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Here's an initial draft proposal for hcid DBus interfaces (as 
currently implemented in hcid 2.4-fn8):

	service:   "org.bluez.hcid",
	path:      "/org/bluez/hcid/device
	interface: "org.bluez.hcid.device

           // Returns a dictionary with hci devices
           // as keys. The values are dictionaries with
           // the configuration parameters. Example:
           //    
           //   { "hci0" : { "type"         : "USB",
           //                "addr"         : "00:00:00:00:00:00",
           //                "status"       : "up",
           //                "name"         : "Fuzz",
           //                "manufacturer" : "Company" },
           //     "hci1" : { "type"         : ... } }
           method: dict(string:dict(string:string)) list(void)

           // Returns a specific configuration dict with the
           // parameters as above.
           method: dict(string:string) get_conf(string hci_dev)

           // Activates an hci device.
           method: void up(string hci_dev)
  
           // Deactivates an hci device.
           method: void down(string hci_dev)

           // Deactivates an hci device.
           method: void set_name(string hci_dev, string name)

	service:   "org.bluez.hcid",
	path:      "/org/bluez/hcid/keytab
	interface: "org.bluez.hcid.keytab

           // Returns an array with key pairs as a dictionaries.
           // Example:
           //    
           //   [ { "sba" : "00:00:00:00:00:00",
           //       "dba" : "00:00:00:00:00:00" },
           //     { "sba" : "00:00:00:00:00:00",
           //       "dba" : "00:00:00:00:00:00" },
           //     ... ]
           method: array(dict(string:string)) list(void|string hci_dev)

           // Deletes a link pair
           method: void delete(string sba, string dba)

	service:   "org.bluez.hcid",
	path:      "/org/bluez/hcid/nametab
	interface: "org.bluez.hcid.nametab

           // Returns a device name or void
           method: void|string delete(string bdaddr)

	path:      "/org/bluez/hcid
	interface: "org.bluez.hcid

           // Notifies applications that device configuration
           // has changed.
           signal: void device(void)

           // Notifies applications that trusted key configuration
           // has changed.
           signal: void keytab(void)

Fredrik
