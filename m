Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT not responding
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: devel Bluetooth <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001c01c41380$83c390b0$fcca010a@lysydziadek>
References: <001c01c41380$83c390b0$fcca010a@lysydziadek>
Content-Type: text/plain
Message-Id: <1080390043.2281.49.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 27 Mar 2004 13:20:44 +0100

Hi Maciej,

there is no need to post this on both mailing lists.

> Why my BT device isn't responding when I'm sending any commands for
> example to read BT_ADDR like this: 0x01 0x00 0x09.
> It doesn't respond to me, even with an error code - nothing.
> But when I use first code from blueZ hciconfig like this
>  
>  int  clen = 0, i;                /* Command len */
>  static int csr_seq = 0;     /* Sequence number of command */
>  int  divisor;
> 
>          /* Try to read the build ID of the CSR chip */
>  clen = 5 + (5 + 6) * 2;
>          /* HCI header */
>  cmd[0] = HCI_COMMAND_PKT;
>  cmd[1] = 0x09;  /* CSR command */
>  cmd[2] = 0xfc;  /* MANUFACTURER_SPEC */
>  cmd[3] = 1 + (5 + 6) * 2; /* len */
>          /* CSR MSG header */
>  cmd[4] = 0xC2;  /* first+last+channel=BCC */
>          /* CSR BCC header */
>  cmd[5] = 0x00;  /* type = GET-REQ */
>  cmd[6] = 0x00;  /* - msB */
>  cmd[7] = 5 + 4;  /* len */
>  cmd[8] = 0x00;  /* - msB */
>  cmd[9] = csr_seq & 0xFF;/* seq num */
>  cmd[10] = (csr_seq >> 8) & 0xFF; /* - msB */
>  csr_seq++;
>  cmd[11] = 0x19;  /* var_id = CSR_CMD_BUILD_ID */
>  cmd[12] = 0x28;  /* - msB */
>  cmd[13] = 0x00;  /* status = STATUS_OK */
>  cmd[14] = 0x00;  /* - msB */
>          /* CSR BCC payload */
>  memset(cmd + 15, 0, 6 * 2);
>  
>   do{
>     for (i=0; i < clen+1; i++) PutByteU0 (cmd[i]);
>  
>     read_hci_event(resp,100);
>  
>   }while (resp[1] != 0xff);
>  
>  
>          /* Try to read the current speed of the CSR chip */
>  clen = 5 + (5 + 4)*2;
>          /* -- HCI header */
>  cmd[0] = HCI_COMMAND_PKT;
>  cmd[1] = 0x09;  /* CSR command */
>  cmd[2] = 0xfc;  /* MANUFACTURER_SPEC */
>  cmd[3] = 1 + (5 + 4)*2; /* len */
>          /* -- CSR BCC header -- */
>  cmd[9] = csr_seq & 0xFF; /* seq num */
>  cmd[10] = (csr_seq >> 8) & 0xFF; /* - msB */
>  csr_seq++;
>  cmd[11] = 0x02;  /* var_id = CONFIG_UART */
>  cmd[12] = 0x68;  /* - msB */
>  
>          /* Now, create the command that will set the UART speed */
>          /* CSR BCC header */
>  cmd[5] = 0x02;   /* type = SET-REQ */
>  cmd[6] = 0x00;   /* - msB */
>  cmd[9] = csr_seq & 0xFF; /* seq num */
>  cmd[10] = (csr_seq >> 8) & 0xFF;/* - msB */
>  csr_seq++;
>  
>  divisor = (921600*64+7812)/15625;
>  
>         /* No parity, one stop bit -> divisor |= 0x0000; */
>  cmd[15] = (divisor) & 0xFF;  /* divider */
>  cmd[16] = (divisor >> 8) & 0xFF; /* - msB */
>              /* The rest of the payload will be 0x00 */
> 
>     for (i=0; i < clen; i++) PutByteU0 (cmd[i]);
>  
> It answers like this: 04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E
> 00 00 00 00 
> What is it? Is it kind of special bits of csr chip or what?
> I know it is event but after this BT responds only for bad commands
> like this 04 10 01 fe  but when I try read BT_ADDR it's quiet.
> What this code is up to? 

This is CSR specific and you must ask your module manufacturer for more
details.

> Please send me UART specification or sth where it's written how to set
> this up and howto communicate with csr chip. It's very important for
> me !

The H:4 UART specification is part of the Bluetooth 1.1 specification.

> I spent almost 2 weeks to find out how to communicate whit it and
> nothing works good. I don't know where to find some info. I looked
> almost everywhere?

Start using BlueZ and don't worry about it or this is the wrong mailing
list for you ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
