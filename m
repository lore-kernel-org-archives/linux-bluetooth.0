Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42DC9FBE.2050406@isofttech.com>
From: Durai <durai@isofttech.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] tty->flip.count  >= TTY_FLIPBUF_SIZE
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
Date: Tue, 19 Jul 2005 12:07:50 +0530

Hi all
    Platform - linux-2.4.18 , big endian Mips CPU running on 100MHz
    Bluetooth dongle - UART based CSR device

We are using a non-standard UART device, which receives the bytes and 
put it in a buffer. We are using a timer interrupt
to periodically poll the for the received data. When data is received, 
it will be passed to the TTY layer using the following code.

 /*
     * Make sure that we do not overflow the buffer
     */
    if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
        printk
            ("\n tty->flip.count %d  >= TTY_FLIPBUF_SIZE %d and dataLen %d",
             tty->flip.count, TTY_FLIPBUF_SIZE, dataLen);

        queue_task(&tty->flip.tqueue, &tq_timer);
       //the incoming bytes are dropped :(
        return;
    }

 while (i < dataLen) {
        tty->flip.count++;
        *tty->flip.char_buf_ptr++ = pClusPtr[i++];
        //printk("< %c  >", pClusPtr[i-1]);
    }
    queue_task(&tty->flip.tqueue, &tq_timer);

Everything goes fine and we are able to setup a PAN network and we are 
able to transmit & receive files over FTP.
But when we increase the UART baud rate to 115200 or beyond that, the 
tty->flip.count exceeds to  TTY_FLIPBUF_SIZE.
and  we are getting errors in the console (I have changed the 
TTY_FLIPBUF_SIZE from 512 to 1024, but it doesnt help)

tty->flip.count 1030  >= TTY_FLIPBUF_SIZE 1024 and dataLen 77
h4_check_data_len: Data length is too large
h4_recv: Unknown HCI packet type 75
h4_recv: Unknown HCI packet type a2
h4_recv: Unknown HCI packet type 22

This is because, the TTY layer is unable to process the received data 
before the next chunk of data arrives.
So my question is, how to speed up the botton half processing in the TTY 
layer. I know that this has got nothing
to do with the bluez layer, but i dont know where to find more 
information about debugging this issue. Anyone had
faced such issues?

regards
durai


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
