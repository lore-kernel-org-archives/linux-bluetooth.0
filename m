Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <951351190712200246v72181504u52169ed53a34fcd6@mail.gmail.com>
References: <951351190712200246v72181504u52169ed53a34fcd6@mail.gmail.com>
Date: Thu, 20 Dec 2007 16:13:18 +0100
Message-Id: <1198163598.8050.253.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] link key PIN code authentication
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jason,

> Currently, I am working on a project to handle the pairing procedure.
> The aim is quite simple.  If  the authentication is required by the
> user, the program will detect whether the link key exists. If not, the
> program will print out several lines in the terminal and ask the user
> entering the PIN code.  The authentication will perform based on the
> PIN code which the user provided and finally the new link key for this
> connection will be passed to the host for future connections if the
> authentication is successful. 
> 
> The bluez exploits the D-Bus to manage the pin code and link key.
> Since my application is very simple, I don't think I need the D-Bus
> framework. 

D-Bus is a really simple framework and not using D-Bus means you can
also not use hcid. Which means you have to duplicate all the effort
inside hcid. If you have that much free time, have fun. However you time
could be spent more useful ;)

> HCI can send the command to LM by hci_send_cmd() method, but I cannot
> find the suitable methods which can read back the request from the
> LM.  

You would have to open a raw HCI socket and read the HCI events. See the
Bluetooth specification for details. Please don't expect me to get into
details here. The hcid does all this and with the passkey agent
interface you have a nice framework to solve your problem. Use it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
