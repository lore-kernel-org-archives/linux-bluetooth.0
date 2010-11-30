Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=VPn1k=kLdo7QbM4epc88fdcW2XsbLyFeYt9y4@mail.gmail.com>
References: <AANLkTi=k=Dvsm6fySREejtP3sf7Cch3G2KYr4sYpg2Q4@mail.gmail.com>
	<AANLkTi=VPn1k=kLdo7QbM4epc88fdcW2XsbLyFeYt9y4@mail.gmail.com>
Date: Mon, 29 Nov 2010 22:24:12 -0700
Message-ID: <AANLkTim5Rnu1Jkh9BOq5oGL6mvFJcHydNDMJZDZD9hP_@mail.gmail.com>
Subject: Re: wi2wi bluecore4
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

I think I am a little closer, just wanted to see if anyone has any ideas.

I rebuilt bccmd so it would connect at 115k instead of 38k. Not sure
why it's hardcoded if the chip cares (this chip refuses to respond at
38k). In any case, now bccmd can set and reset the chip apparently:

# cat pskey.psr
// PSKEY_UART_BAUDRATE
&01be = 0ebf
// PSKEY_SCO_MAPPING
&01ab = 0
# bccmd.115 -t H4 -d /dev/ttyS1 psload -r pskey.psr
Loading PSKEY_UART_BAUDRATE ... done
Loading PSKEY_HOSTIO_MAP_SCO_PCM ... done
#

But the hciattach still fails with "Initialization timed out.". The
chip returns a single byte...

# strace -s 64 hciattach ttyS1 csr 921600 noflow
...
open("/dev/ttyS1", O_RDWR|O_NOCTTY)     = 3
ioctl(3, TCFLSH, 0x2)                   = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon
-echo ...}) = 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {B115200 -opost -isig -icanon
-echo ...}) = 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {B115200 -opost -isig -icanon
-echo ...}) = 0
ioctl(3, TCFLSH, 0x2)                   = 0
write(3, "\1\0\374\27\302\0\0\t\0\0\0\31(\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 27) = 27
read(3, "\374", 1)                      = 1
read(3, 0xbed819dc, 1)                  = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---

What is the chip saying to us when we read \374? Why is hciattach
initializing at 115k when i told it to use 921k? So I tried setting
the init speed too:

# strace -s 64 hciattach -s 921600 ttyS1 csr 921600 noflow
...
open("/dev/ttyS1", O_RDWR|O_NOCTTY)     = 3
ioctl(3, TCFLSH, 0x2)                   = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon
-echo ...}) = 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {B115200 -opost -isig -icanon
-echo ...}) = 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {B921600 -opost -isig -icanon
-echo ...}) = 0
ioctl(3, TCFLSH, 0x2)                   = 0
write(3, "\1\0\374\27\302\0\0\t\0\0\0\31(\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 27) = 27
read(3, 0xbeebf9cc, 1)                  = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---

this time it didn't even get one junk byte. Is there anything else I can check?

Brad
