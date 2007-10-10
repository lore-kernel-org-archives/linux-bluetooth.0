Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0710101022s48d2b87rd42e1ab5520b9ddb@mail.gmail.com>
Date: Wed, 10 Oct 2007 14:22:01 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY122-W50DCD42B80D0F4AF45DCA88A60@phx.gbl>
MIME-Version: 1.0
References: <BAY122-W50DCD42B80D0F4AF45DCA88A60@phx.gbl>
Subject: Re: [Bluez-users] Can't connect OpenSuse 10.3 apple bluetooth
	keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 10/10/07, Jacob Miner <jacob_miner@hotmail.com> wrote:
>
> Hi All,
>
>    I installed OpenSuse 10.3 on my HP zd8000 laptop.  My bluetooth device is
> discovered as
>  "HP Integrated Bluetooth module" and the driver is hci_usb.  *Note I also
> tried a Dlink BT-120 revision 4, and got the exact same behavior.
>
>  I did the following:
>
>  put apple keyboard into discovery mode
>
>  1. ran in one terminal /usr/bin/passkey-agent 1234 00:0A:95:4A:FC:D0
>  2. then in another terminal ran hcitool cc 00:0A:95:4a:FC:D0
>  3. typed 1234 <enter> on apple keyboard
>
>  the following is the output from hcidump -X -V.  So what is the deal?  the
> keyboard disconnects immediately...
>
>  < HCI Command: Create Connection (0x01|0x0005) plen 13
>  bdaddr 00:0A:95:4A:FC:D0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>  Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>  Create Connection (0x01|0x0005) status 0x00 ncmd 1
>  > HCI Event: PIN Code Request (0x16) plen 6
>  bdaddr 00:0A:95:4A:FC:D0
>  < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>  bdaddr 00:0A:95:4A:FC:D0 len 4 pin '1234'
>  > HCI Event: Command Complete (0x0e) plen 10
>  PIN Code Request Reply (0x01|0x000d) ncmd 1
>  status 0x00 bdaddr 00:0A:95:4A:FC:D0
>  > HCI Event: Link Key Notification (0x18) plen 23
>  bdaddr 00:0A:95:4A:FC:D0 key
> 8C2741B6F8635F8D0AD9CA43CD1A7EF8 type 0
>  Type: Combination Key
>  > HCI Event: Connect Complete (0x03) plen 11
>  status 0x00 handle 6 bdaddr 00:0A:95:4A:FC:D0 type ACL encrypt 0x00
>  < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>  handle 6
>  > HCI Event: Command Status (0x0f) plen 4
>  Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>  < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>  handle 6 policy 0x0f
>  Link policy: RSWITCH HOLD SNIFF PARK
>  > HCI Event: Command Complete (0x0e) plen 6
>  Write Link Policy Settings (0x02|0x000d) ncmd 1
>  status 0x00 handle 6
>  > HCI Event: Read Remote Supported Features (0x0b) plen 11
>  status 0x00 handle 6
>  Features: 0xbc 0x02 0x04 0x00 0x08 0x00 0x00 0x00
>  < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>  bdaddr 00:0A:95:4A:FC:D0 mode 2 clkoffset 0x0000
>  > HCI Event: Command Status (0x0f) plen 4
>  Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>  > HCI Event: Remote Name Req Complete (0x07) plen 255
>  status 0x00 bdaddr 00:0A:95:4A:FC:D0 name 'jkbd'
>  < HCI Command: Disconnect (0x01|0x0006) plen 3
>  handle 6 reason 0x13
>  Reason: Remote User Terminated Connection
>  > HCI Event: Command Status (0x0f) plen 4
>  Disconnect (0x01|0x0006) status 0x00 ncmd 1
>  > HCI Event: Disconn Complete (0x05) plen 4
>  status 0x00 handle 6 reason 0x16
>  Reason: Connection Terminated by Local Host
>
>  Any Ideas, any help greatly appreciated!
>
>
>
>
> -=[ Jake ]=-
>

Hi Jacob,

Your steps to connect to the keyboard are wrong. Read the following
link to understand the device creation process using the new input
service:
http://wiki.bluez.org/wiki/HOWTO/InputDevices

The python script is a temporary solution while there isn't wizard
apps to setup HID devices.

BR,
Claudio.
-
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
