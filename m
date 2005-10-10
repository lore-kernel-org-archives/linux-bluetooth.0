Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: david <gangchen@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1128920934.2417.21.camel@localhost.localdomain>
References: <1128920934.2417.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=GB2312
Message-Id: <1128925625.2417.38.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: ttyS0 problem
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
Date: Mon, 10 Oct 2005 14:27:05 +0800

Hi marcel,

=D4=DA 2005-10-10=D2=BB=B5=C4 13:08 +0800=A3=ACdavid=D0=B4=B5=C0=A3=BA
>  Hi David,
> =20
>  > > What commands do you wanna send?
>  > The command is HCI_GO_TO_SLEEP_IND(0x30) which is only one byte. It is=
 a
>  > vendor specific command used to ask the BT device to go to sleep. If B=
T
>  > device receives the command, maybe it would response
>  > HCILL_GO_TO_SLEEP_ACK(0x31) command to the host.
> =20
>  do you have the specification of these vendor commands? Is this command
>  according to the HCI specification or is it an extension of the H:4
>  transport protocol?
> =20
>  > > after step 1, you  must use the HCI raw socket to send commands
>  >=20
>  > Is this means we cannot write command to ttyS0 directly through write(=
)
>  > function?
> =20
>  After calling hciattach the kernel takes over the serial port via the
>  line discipline and the reads and writes are useless.
> =20
>  Regards
> =20
>  Marcel

The HCILL is a proprietary protocal, providng BRF6100 and the HOST with
the deterministic way to independently  go into their standby mode.
These commands are provided by BRF6100 Fireware Release, Vendor specific
Command, HCI document of TI.=20

Regards,

David



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
