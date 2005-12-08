Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Corrections in hciattach code
Message-ID: <A35A8D03A748B34A9DA2AB0335A3F93D408B70@rfsdmail.internal.rfmd.com>
From: "Jatin Nahar" <jnahar@rfmd.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Wed, 7 Dec 2005 16:56:22 -0800

Hi Marcel,

> @@ -720,15 +720,15 @@
>  		return -1;
>  	}
> =20
> -	// we probably got the reply. Now we must send the "soft reset":
> +	// we probably got the reply. Now we must send the "soft reset":
> which
> +	// is standard HCI RESET.
>  	cmd[0] =3D HCI_COMMAND_PKT;	// it's a command packet
> -	cmd[1] =3D 0x0B;			// OCF 0x0B	=3D param access
> set=09
> -	cmd[2] =3D 0xfc;			// OGF bx111111 =3D vendor
> specific
> -	cmd[3] =3D 0x01;			// 1 byte of data following=20
> -	cmd[4] =3D 0x03;			// HCI Reset Subcommand
> +	cmd[1] =3D 0x03;			=09
> +	cmd[2] =3D 0x0c;	=09
> +	cmd[3] =3D 0x00;	=09
>  		=09
> -	// Send initialization command
> -	if (write(fd, cmd, 5) !=3D 5) {
> +	// Send HCI RESET command
> +	if (write(fd, cmd, 4) !=3D 4) {
>  		perror("Can't write Silicon Wave reset cmd.");
>  		return -1;
>  	}

But with this one I am not sure. Do this chip really uses HCI Reset to
reset the device and bring it up with the new baud rate. Actually my
understanding is that HCI Reset should not reset the transport layer and
this has been clarified in the Bluetooth 1.1 specification.

You are correct about the specification but HCI reset is needed to have
the UART change working, even though there won't be any data loss.

Thanks,
Jatin=20


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
