Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question about dev/bluetooth/rfcomm/0
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000a01c502eb$5e72f750$798815ac@stu.nus.edu.sg>
References: <001601c50210$feedd960$2bc212ac@stu.nus.edu.sg>
	 <1106570617.9269.81.camel@pegasus>
	 <000a01c502eb$5e72f750$798815ac@stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1106664988.8242.20.camel@pegasus>
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
Date: Tue, 25 Jan 2005 15:56:28 +0100

Hi Teck,

> Thank you for your help. I have a few more related questions:
> 
> 1. I issue the following commands with a Sony Ericsson 
> T630(a1:b2:c3:d4:e5:f6) nearby
> # rfcomm bind rfcomm0 a1:b2:c3:d4:e5:f6
> # rfcomm connect rfcomm0 a1:b2:c3:d4:e5:f6

you need only one of these commands. When using bind you must open the
terminal device to initiate the connection.

> The T630 asked for a pin. I have previously editted the pin file in 
> /etc/bluetooth/pin to be 0000. I entered 0000 into the T630 and it rejected 
> it with error passkey mismatch. May I know how to resolve this?

This PIN file is only for incoming connection. You PIN helper program is
not working in your case. Check the mailing list archive.

> However, when I issued the following command
> # hcitool cc a1:b2:c3:d4:e5:f6
> The connection proceeded successfully immediately, without the phone asking 
> for a pin.

This is a low level connection and as long as none of the device is in
security mode 3 you won't be asked for a PIN.

> 2. I desire to use AT commands on my Fedora, via cu (call up). May I know 
> how I can get cu installed? Can minicom be used for similar purpose?

Ask the Fedora guys ;)

However you can use any program to issue the AT commands. If you only
wanna dial in then you should use a dialer program like wvdial.

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
