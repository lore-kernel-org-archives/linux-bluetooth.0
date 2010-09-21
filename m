Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=gRJgyFD2uC-UsjzjQCU11326SSsN4+nsTxk9-@mail.gmail.com>
References: <7866937.1285030222002.JavaMail.root@elwamui-darkeyed.atl.sa.earthlink.net>
	<AANLkTi=hD_U-19oPnQzQemt5wBgAqip3h7esJZpgkr4e@mail.gmail.com>
	<AANLkTi=gRJgyFD2uC-UsjzjQCU11326SSsN4+nsTxk9-@mail.gmail.com>
Date: Tue, 21 Sep 2010 14:06:18 +0300
Message-ID: <AANLkTikwvCiCLj4Hvr=zSQHOm33e059z2W6MA0T5C2ZO@mail.gmail.com>
Subject: Re: Need complete docs on PAN and DUN with bluez 4.66
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arun Kumar <arunkat@gmail.com>
Cc: Mumia W <mumia.w.18.spam@earthlink.net>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 21, 2010 at 6:56 AM, Arun Kumar <arunkat@gmail.com> wrote:
> Depends on what role you want to use pand for ...pand is launched as a
> daemon via command line with set of options you may want to use it for
> your requirements ...

I wouldn't suggest using pand nor dund because they are deprecated.

PAN is really dead simple, Network.Connect() returns the network
interface in case of success and both NetworkManager and connman
should be able to use them, in fact I think both already have specif
PAN support to connect from their ui.

DUN is a bit more complicated, it rely on Serial.Connect("dun") which
creates a RFCOMM port to talk to the modem, but there need to be some
process that has an AT command engine to handle all the configuration,
in NetworkManager case there is ModemManager that is supposed to do
that but I have tried not long ago and it failed for me, I think we
might want to have ofono to handle this in connman case but so far
there the support for this is not complete (Gustavo Padovan has been
working on it).

Both Network and Serial interface are documented in doc/ diretory,
there is also test-network and test-serial under test/ that can be
used to manually connect to those profiles.

-- 
Luiz Augusto von Dentz
Computer Engineer
