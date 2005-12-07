Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Corrections in hciattach code
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <A35A8D03A748B34A9DA2AB0335A3F93D408958@rfsdmail.internal.rfmd.com>
References: 
	 <A35A8D03A748B34A9DA2AB0335A3F93D408958@rfsdmail.internal.rfmd.com>
Content-Type: text/plain
Message-Id: <1133946291.11247.7.camel@blade>
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
Date: Wed, 07 Dec 2005 10:04:51 +0100

Hi Jatin,

> Here it is...
> 
> --- hciattach_old.c	2005-12-06 13:15:22.000000000 -0800
> +++ hciattach.c	2005-12-06 13:16:15.000000000 -0800
> @@ -688,7 +688,7 @@
>  	}
>  
>  	/* Send initialization command */
> -	if (write(fd, cmd, 9) != 9) {
> +	if (write(fd, cmd, 10) != 10) {
>  		perror("Failed to write init command");
>  		return -1;
>  	}

this part is clear.

> @@ -720,15 +720,15 @@
>  		return -1;
>  	}
>  
> -	// we probably got the reply. Now we must send the "soft reset":
> +	// we probably got the reply. Now we must send the "soft reset":
> which
> +	// is standard HCI RESET.
>  	cmd[0] = HCI_COMMAND_PKT;	// it's a command packet
> -	cmd[1] = 0x0B;			// OCF 0x0B	= param access
> set	
> -	cmd[2] = 0xfc;			// OGF bx111111 = vendor
> specific
> -	cmd[3] = 0x01;			// 1 byte of data following 
> -	cmd[4] = 0x03;			// HCI Reset Subcommand
> +	cmd[1] = 0x03;				
> +	cmd[2] = 0x0c;		
> +	cmd[3] = 0x00;		
>  			
> -	// Send initialization command
> -	if (write(fd, cmd, 5) != 5) {
> +	// Send HCI RESET command
> +	if (write(fd, cmd, 4) != 4) {
>  		perror("Can't write Silicon Wave reset cmd.");
>  		return -1;
>  	}

But with this one I am not sure. Do this chip really uses HCI Reset to
reset the device and bring it up with the new baud rate. Actually my
understanding is that HCI Reset should not reset the transport layer and
this has been clarified in the Bluetooth 1.1 specification.

Regards

Marcel
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
