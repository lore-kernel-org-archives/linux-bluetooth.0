Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101031120429.1ca38140@pyx>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com>
	<AANLkTinh3D8V8UaN8FyCouwUQ98A4RRWEHXU7Tr9XMbs@mail.gmail.com>
	<20101029172214.25b14c2a@pyx>
	<201010300201.01940.arnd@arndb.de>
	<20101031120429.1ca38140@pyx>
Date: Fri, 5 Nov 2010 18:02:46 +0100
Message-ID: <AANLkTimEYAmocFh_c-KftpL2zRm+LaHzgJOBX31iicLj@mail.gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
From: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linus.walleij@stericsson.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukasz.Rymanowski@tieto.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/10/31, Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> It's about the ldisc number. Both bluetooth and cg2900 register themselves
>> to ldisc 15 (N_HCI). A user doing TIOCSETD can only get one of the two.
>
> Ah I see - I had assumed any actual final merge would be assigning it a
> new LDISC code as is required.
>

Hi,

Sorry for not answering quicker. We in my department have been
discussing new design as well as trying out some solutions.

As an answer to previous comments, both from Arnd and Alan, we would
like to do the following:
 - Introduce a new ldisc called N_H4_COMBO with a ldisc driver
accordingly that will be placed under drivers/char
 - Keep CG2900 driver as an MFD. We will however register the MFD
cells in each driver and remove the function API. The functions
(write, reset, etc) will instead be placed in each MFD cell using
function pointers. This way we can use different functions for
different channels as needed. By placing the MFD cell registration in
each chip driver we will also only expose the channels that are
actually supported by each chip. This way we can also remove the
pretty ugly matching between the devices and respective H4 channel as
well as the add_h4_user function and the similar other functions.

We were thinking about if we could re-use the existing hci_ldisc
driver. As stated before the big problem here is however that
hci_ldisc directly registers to the Bluetooth stack. We could separate
the data for FM and GPS in the protocol driver, but it is pretty ugly
to have two separate data paths within the same driver.
As I've state earlier this would also not work with other transports
such as SPI.I appreciate Arnd's suggestion to create a TTY for SPI,
but I think that would overcomplicate the situation and create a
solution more complex than actually needed. We think that creating a
new ldisc creates a cleaner solution. It will to some extent remind of
hci_ldisc, but it will not register to any framework except tty.

We've thought about if we should switch cg2900 to a bus, but after
discussing this we feel that CG2900 has such individual
characteristics that it could be hard to create a bus that would suite
it. We therefore will keep the MFD type. We might in the future add
new chips to the driver, but they will most likely not require so much
rework of the driver that we will have to create something completely
new. We will rather create a lib file that contains common code to
reduce total code size of the driver.

Do you see any problems with our suggestions?

/P-G
