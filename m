Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS] remote name patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0601230833t25905a64he7ca62c7d1ab48cf@mail.gmail.com>
References: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
	 <1137808123.20856.122.camel@localhost>
	 <e1effdeb0601230833t25905a64he7ca62c7d1ab48cf@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1138036115.7327.14.camel@localhost>
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
Date: Mon, 23 Jan 2006 18:08:35 +0100

Hi Claudio,

> I has just read some parts of "Specification Change Request". What is
> the current status of the BlueZ Kernel? I figure out that there is a
> function to parse the extended inquiry result event, however in the
> code I have the 240 bytes are being ignored.

the code inside the kernel only keeps the inquiry cache up-to-date,
because you need this for the connection establishment.

> I prefer use just one signal instead of add a new signal to represent
> the extended inquiry response. My suggestion is unify the standard and
> the extended inquiry. If the user wants to know some response
> properties, we can add an extra signal field to indicate the
> type(Standard, with RSSI or EIR) and the remote name property(shorted,
> full, cached).
> 
> Regarding the shorted/full name, in my opinion applications generally
> will not want to distinguish the name type. The others UUIDs(service,
> manufacturer, ...) included in the EIR packet can be ignore for now.
> If required, we add extra fields in the inquiry cache to store these
> UUIDs and add an D-Bus services to retrieve these data later.
> 
> Inquiry Result signal format proposal:
> 
> /* type flags */
> #define STD_INQUIRY_RESPONSE   0x00010000
> #define RSSI_INQUIRY_RESPONSE  0x00010000  /* RSSI included*/
> #define EIR_INQUIRY_RESPONSE   0x01000000  /* */
> 
> /* name flags */
> #define SHORTED_NAME           0x00000001
> #define FULL_NAME              0x00000010
> #define CACHED_NAME            0x00000100
> 
> Signal arguments:
> UINT32: type (STD_INQUIRY_RESPONSE/RSSI_INQUIRY_RESPONSE/EIR_INQUIRY_RESPONSE
> | FLAGS
> String: BDADDR
> String: name /* "n/a", cached value, shorted or full name */
> UINT32: Device class
> INT32: RSSI
> 
> "n/a" in the name field will be applied to standard inquiry, where the
> remote name should be retrieved later or for EIR, when the local name
> length is zero.
> 
> What do you think?  Do you have another suggestion or comments?

Don't try to distinguish the different inquiry modes on the D-Bus
interface. All of them are only an implementation detail.

Regarding the name, we might simply say the hcid/bluetoothd always sends
a remote name signal if something changes. So it might get the short
name from the extended inquiry first and after that it receives the full
remote name. We can also always send the cached name and we update that
name on every service discovery, because then it is at zero cost.

So we have one device name. This maybe a cached, a remote or a shortened
name. The application doesn't really have to care and it gets updates as
soon as hcid/bluetoothd knows them.

Besides the device name, we should implement an alias name. This name is
associated with the BD_ADDR and can be changed by the user if he/she
doesn't like the device name. Implementing this alias through the D-Bus
interface makes it available for all applications and we can store the
aliases in /var/lib/bluetooth/<bdaddr>/aliases.

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
