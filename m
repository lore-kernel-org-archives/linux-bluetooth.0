Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 28 Nov 2010 09:12:10 -0700
Message-ID: <AANLkTi=k=Dvsm6fySREejtP3sf7Cch3G2KYr4sYpg2Q4@mail.gmail.com>
Subject: wi2wi bluecore4
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

The gumstix overo comes with a wi2wi chip with a bluecore4-rom. I have
been unable to switch it to a baud rate other than 115k or to change
its SCO mapping. Any ideas?

I tried using bccmd before hciattaching the device but I can't find
any settings that get past a timeout. Once a timeout is reported, I
have to reset the board to try anything else.

# bccmd -t BCSP -d /dev/ttyS1 psset -r baudrate 0xEBF
Initialization timed out

I can hciattach it first, then use bccmd over hci, but as soon as I
try to change the baud then the chip won't talk to me any more.

# hciattach ttyS1 csr 115200
CSR build ID 0x0C-0x5C
Device setup complete
# bccmd psget baudrate
UART Baud rate: 0x01d8 (472)
# bccmd psset -r baudrate 0xEBF
# killall hciattach
# hciattach ttyS1 csr 921600 # also tried with "-s 115200"
Initialization timed out.

and fwiw, checking the SCO mapping gives me a strange result.

# bccmd psget mapsco
Can't execute command: No such device or address (6)

I tried changing the hardcoded 38k baud to 115k in csr_bsp.c just in
case that was why it won't talk directly to the chip, no luck.

fwiw, the chip reports

# hciconfig hci0 revision
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 00:19:88:0A:77:65  ACL MTU: 310:10  SCO MTU: 64:8
        Unified 21e
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  PCM

Is there anything else I could try here?

-- 
Brad Midgley
