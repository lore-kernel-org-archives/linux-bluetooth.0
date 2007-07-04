Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1183513706.6351.47.camel@aeonflux.holtmann.net>
References: <1183412947.20815.7.camel@localhost>
	<1183433596.6351.25.camel@aeonflux.holtmann.net>
	<1183462763.4335.17.camel@localhost>
	<1183513706.6351.47.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="=-4PTkwYc52FhQYIiv3g6B"
Date: Wed, 04 Jul 2007 15:43:44 +0200
Message-Id: <1183556624.4951.10.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users]  dbus problem,   Was:  Only one pand-daemon?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-4PTkwYc52FhQYIiv3g6B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dear Marcel,

I did find one solution to this:

ons 2007-07-04 klockan 03:48 +0200 skrev Marcel Holtmann:
> Hi Mats,
> 
> > > > I am facing the problem that I cannot start more than
> > > > one listening pand-daemon, in spite of using two usb-dongles.

> > > > beginning to think that it could be DBUS that haunts me, but I
> > > > have just begun studying the source code of pand to make sure.
> > > 
> > 
> > I need more than one Bluetooth radio, i.e. usb-dongle, each providing
> > a NAP service, since I am not content with only seven clients in one
> > piconet. Hence my belief was that I could simply start one pand-daemon
> > for each dongle and have my system up and running.
> 
> by default pand listens on all attached dongles. So that should work out
> of the box.
> 

I made an addition to the dbus-configuration in bluez-hcid.conf by
inserting paths for hci0 and hci1 for root and console like this:

<policy user="root">
   <allow own="org.bluez"/>
   <allow send_path="/org/bluez/hci0"/>
   <allow send_path="/org/bluez/hci1"/>
</policy>

After that a single listening PAN daemon is receptive on both
usb-dongles. My full configuration is attached here. It was already
previously expanded, but it was the four lines with 'hci#' that brought
the magic. I myself and probably other bluez-users, would improve our
knowledge, could you be so kind as to commenting on what additions
that could/should be eliminated from my configuration file. Please!

Best regards,    Mats E A

--=-4PTkwYc52FhQYIiv3g6B
Content-Disposition: attachment; filename=bluez-hcid.conf.dbus
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=bluez-hcid.conf.dbus; charset=ISO-8859-1

PGJ1c2NvbmZpZz4NCg0KICA8IS0tIC4uL3N5c3RlbS5jb25mIGhhdmUgZGVuaWVkIGV2ZXJ5dGhp
bmcsIHNvIHdlIGp1c3QgcHVuY2ggc29tZSBob2xlcyAtLT4NCg0KIDxwb2xpY3kgdXNlcj0icm9v
dCI+DQogICA8YWxsb3cgb3duPSJvcmcuYmx1ZXoiLz4NCiAgIDxhbGxvdyBzZW5kX3BhdGg9Ii9v
cmcvYmx1ZXovaGNpMCIvPg0KICAgPGFsbG93IHNlbmRfcGF0aD0iL29yZy9ibHVlei9oY2kxIi8+
DQogPC9wb2xpY3k+DQoNCiA8cG9saWN5IGF0X2NvbnNvbGU9InRydWUiPg0KICAgPGFsbG93IHNl
bmRfZGVzdGluYXRpb249Im9yZy5ibHVlei5BZGFwdGVyIi8+DQogICA8YWxsb3cgcmVjZWl2ZV9z
ZW5kZXI9Im9yZy5ibHVlei5BZGFwdGVyIi8+DQoNCiAgIDxhbGxvdyBzZW5kX3BhdGg9Ii9vcmcv
Ymx1ZXovQWRhcHRlciIvPg0KICAgPGFsbG93IHNlbmRfcGF0aD0iL29yZy9ibHVlei9oY2kwIi8+
DQogICA8YWxsb3cgc2VuZF9wYXRoPSIvb3JnL2JsdWV6L2hjaTEiLz4NCg0KICAgPGFsbG93IHNl
bmRfZGVzdGluYXRpb249Im9yZy5ibHVlei5NYW5hZ2VyIi8+DQogICA8YWxsb3cgcmVjZWl2ZV9z
ZW5kZXI9Im9yZy5ibHVlei5NYW5hZ2VyIi8+DQoNCiAgIDxhbGxvdyBzZW5kX3BhdGg9Ii9vcmcv
Ymx1ZXovTWFuYWdlciIvPg0KDQogICA8YWxsb3cgc2VuZF9kZXN0aW5hdGlvbj0ib3JnLmJsdWV6
LlBhc3NrZXlBZ2VudCIvPg0KICAgPGFsbG93IHJlY2VpdmVfc2VuZGVyPSJvcmcuYmx1ZXouUGFz
c2tleUFnZW50Ii8+DQoNCiAgIDxhbGxvdyBzZW5kX3BhdGg9Ii9vcmcvYmx1ZXovUGFzc2tleUFn
ZW50Ii8+DQoNCiAgIDxhbGxvdyBzZW5kX2Rlc3RpbmF0aW9uPSJvcmcuYmx1ZXouU2VjdXJpdHki
Lz4NCiAgIDxhbGxvdyByZWNlaXZlX3NlbmRlcj0ib3JnLmJsdWV6LlNlY3VyaXR5Ii8+DQogPC9w
b2xpY3k+DQoNCjwvYnVzY29uZmlnPg0K


--=-4PTkwYc52FhQYIiv3g6B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-4PTkwYc52FhQYIiv3g6B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-4PTkwYc52FhQYIiv3g6B--
