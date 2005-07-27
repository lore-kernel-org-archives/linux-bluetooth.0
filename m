Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: andy thomas <andy@time-domain.co.uk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050727122832.1DE4D33222@sc8-sf-spam1.sourceforge.net>
Message-ID: <Pine.LNX.4.60.0507271515220.12469@purdy.demon.co.uk>
References: <20050727122832.1DE4D33222@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] Kernel module for PCMCIA/CF Bluetooth cards with CSR chipset
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 27 Jul 2005 15:37:44 +0100 (BST)

I'm having a problem finding support in BlueZ for a Socket Communications 
CF+ Bluetooth card, which is a later version using the CSR chipset and not
the Nokia DTL-1 chipset as used in earlier versions of the same card. The 
Nokia-based card is supported in BlueZ using the dtl1_cs.o module but the 
CSR-based card is not. Does anyone know if there are any plans to support 
CSR-based PCMCIA/CF cards?

If not, I will go and buy a USB Bluetooth dongle instead as these seem to
better supported, and the external antenna possibly works better too. The 
only reason I would like to use the Socket CF card is because I already have
one in my Jornada PDA (runs Windows CE) and sharing the Bluetooth device
between PDA and Linux laptop means less to carry around.

One thing puzzles me - back in March this year, Erwin Authried wrote in 
this mailing list that PCMCIA/CF UARTs are register-compatible emulations 
of a standard UART (see original mail below). Does this mean that I could 
be using just the serial_cs.o kernel module for the Socket CF+ card? All I
want to use Bluetooth for at this stage is to interface my laptop to a 
Bluetooth phone so I can connect to the 'Net via GPRS or PPP/dial-up while
I'm away from base (mainly to ssh into remote servers, etc). I do this 
already from my PDA but a laptop would be nicer.

Thanks in advance for any suggestions,

Andy

Original archive posting follows:

On Sat, 2005-03-05 at 06:37, Mathias Adam wrote:
  > Hi,
  >
  > I just got it working by doing a little change in the serial driver
  > (8250.c). I tested it with 2.6.11 but I think it could work for any 2.6
  > kernel.
  >
  > Marcel Holtmann schrieb:
  > > I am not an serial card expert. This is a problem in the serial
  > > subsystem and a BlueZ problem.
  >
  > That proved to be true.
  >
  > Marcel: One thing I discovered while debugging this: the hci_uart 
driver
  > seems to initialize the actual UART with only 230400 baud. Is this
  > really the case or are those UARTs clocked at nonstandard (higher)
  > frequencies so that this setting does result in a higher real baud 
rate?

  I can"t say for sure if that applies to your specific CF card, but
  usually PCMCIA/CF uarts are just register-compatible emulations of a
  standard uart, and the clockrate doesn"t matter at all. The actual data
  rate can be very high.

  Regards,
  Erwin


-------------------------------------------
Andy Thomas,
Time Domain Systems

Tel: +44 (0)7866 556626
Fax: +44 (0)20 8372 2582
http://www.time-domain.co.uk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
