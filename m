Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Help - power control
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be0502010808e419a69@mail.gmail.com>
References: <de33c8be0502010808e419a69@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1107274559.9652.55.camel@pegasus>
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
Date: Tue, 01 Feb 2005 17:15:59 +0100

Hi Flavio,

>         I=B4m trying to make a program with the library BlueZ but
> without detailed information about the functions is very dificult
> (even reading the bluetooth specifications)! where i could find that
> information? BlueZ don=B4t have manual :( :(

but you can use the source, Luke ;)

> The tutorials indicated in www.bluez.org don=B4t give me any help since
> the program need to work in a low level (example, power control)!

If you talk about transmit power then this is not controllable from your
application, because it is the job of the link manager.

> Second:
>         How can i make a dongle bluetooth comunicate always with the sa=
me power?
>         The functions related with the power are:
> _read_rssi -> the power received;
> _transmit_power-> the power in transmition.

Again, this is job of the link manager.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
