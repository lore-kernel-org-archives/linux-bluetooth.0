Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8c7950360709190845i547b4adat7744e83e062aeb14@mail.gmail.com>
Date: Wed, 19 Sep 2007 11:45:39 -0400
From: shanevolpe@gmail.com
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <10405.65486.qm@web51406.mail.re2.yahoo.com>
MIME-Version: 1.0
References: <10405.65486.qm@web51406.mail.re2.yahoo.com>
Subject: Re: [Bluez-users] serial bluetooth adapter............
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

M.suman,
If it is a HCI Serial Bluetooth IC then bluez will work just fine.
You will need to use hciattach to connect the serial port bluetooth.
You can read the MAN on hciattach but here is an example of using it:
hciattach /dev/ttyS1 csr 921600 CRTSCTS

ttyS1 is were my serial bluetooth is at and csr is the chip set.

Just make sure hciattach supports the chipset of the serial Bluetooth
you want to use.
FYI:
I'm using a BlueRadios serial bluetooth.

Regards,
Shane

On 9/17/07, suman <sundew_suman@yahoo.com> wrote:
>
> hi all
>        I have some confusion in using bluez. I am trying to communicate my
> pc(Linux) with an arm board (LPC2129-ARM7). this board doesn't support usb.
> i want to use a serial bluetooth adapter.
>          Now i want to know that can i use the BlueZ protocol i.e
> RFCOMM/L2CAP/SDP to communicate with the board with bluetooth serial
> adapter. or will it support only SPP(Serial Port Protocol). i need to know
> before i buy the serial blouetooth adapter as it costs $100 .
>        so can any body tell me what services i can use with a serial
> bluetooth adapter under BlueZ enviroment. or any suggestions are most
> welcome.
>        Thanks in advance
>
>
> Details:-
> Linux:-2.6.21 kernel
> Bluez:-latest
> Serial Adapter(Plug and Play)
> Model # GBS301
> Manufacture :-IOGEAR
> -------------------------------------
> M.suman
> IIIT pune ,hinjawadi
>
>
>  ________________________________
> Catch up on fall's hot new shows on Yahoo! TV. Watch previews, get listings,
> and more!
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>


-- 
Registered Linux User: #293401

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
