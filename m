Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <419784ED.8080800@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
References: <20041110041405.3CC331D4758@sc8-sf-uberspam1.sourceforge.net>	 <003101c4ca02$b9f20d90$6f04a8c0@ZBOX> <1100446527.21403.23.camel@pegasus>
In-Reply-To: <1100446527.21403.23.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Nov 2004 17:16:45 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:

|>This cause I must do the second step,
|>
|>2. bypass checking (skb->len > hdev->sco_mtu) in function
|>    hci_send_sco(...) [hci_core.c] and (len > conn->mtu) in
|>    function sco_send_frame(...) [sco.c]
|>    *** I just think, this step maybe change by hciconfig tool. ***
|
|
| This is wrong. If the MTU increases with a different voice setting then
| you have to change the check to depend on the voice setting value.
|
|
|>Next step, I would like to fixed to dynamicaly change the alternate
setting
|>by looking for previous thread "question about hci_usb endpoint
|>selection..." as you known in notify() cannot call usb_set_interface()
|>since always in_interrupt() so that I would like to purpose to add ioctl()
|>into hci_usb driver to do this or do you have others better approach?
|
|
| The ioctl() way is a no go. You have everything you must know inside the
| kernel. You know the number of SCO connections and the voice setting and
| the driver must be able to deal with this by itself.

Question is, how can we handle the endpoint selection when we can't use
usb_set_interface() in the notify function? Or to be more precisly, when.

Next question is what happens to not-yet-send packages, I think we must
empty all queues before we can use usb_set_interface.

What function in the kernel driver would you use to add this? maybe the
send functions? We could set a flag "change endpoint to..." in notify
and apply the change when queues are empty - and reject/hold new send
urbs until we were able to change the endpoint setting.

Maybe?

CU,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBl4TtQWC6DTWkDAoRAjGfAJ9M/d+eILKDbDOouVVBmIHu5HxtwACglGY2
RQOhETxlea2hR0mqL0Du7qw=
=Z5px
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
