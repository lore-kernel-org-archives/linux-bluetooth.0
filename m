Return-Path: <Steven.Singer@csr.com>
Message-ID: <3FF99466.8080209@csr.com>
Date: Mon, 05 Jan 2004 16:44:22 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Florian Echtler <echtler@fs.tum.de>,
   Olivier Bornet
    <Olivier.Bornet@smartdata.ch>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Bluez-users] bthid cvs question
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
    <1071020597.10655.4.camel@pegasus> <20031210080259.GF26896@smartdata.ch>
    <1071065922.10655.60.camel@pegasus>
    <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
    <1071969925.2684.5.camel@pegasus>
In-Reply-To: <1071969925.2684.5.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
 > [Florian Echtler wrote:]
>>Great work! Right now, I am typing this with my MS Bluetooth keyboard
>>and I haven't noticed any glitches so far (connecting to the devices
>>still is kind of a hassle, but I guess MS is to blame for that).
> 
> this is easy to solve. The problem is that if we don't have the device
> in our inquiry cache we use a pscan_rep_mode with the value 0x01 for
> connection setup, but Microsoft uses 0x02 by default. To solve the
> glitches with the initial connection is to do an inquiry first.

A lot of devices use page scan repetition mode R2 by default as it's the
lowest power mode.

BlueZ's behaviour is wrong. If you do not know the page scan repetition
mode of the device you're going to connect to then you must use R2. The
1.1 spec does not state this explicitly, but it can be implied.

The wording has been tightened in the 1.2 spec, unfortunately, the note
is in the baseband spec so it's not surprising that host stack authors
miss it. Even then it's stated in a slightly unusual way. The BT 1.2
spec states in volume 2, part B, section 8.3.2, page 137:

   If the slave scan interval corresponds to R1, the repetition number is
   at least 128; if the slave scan interval corresponds to R2 or if the
   master has not previously read the slave's SR mode, the repetition
   number is at least 256. If the master has not previously read the
   slave's SR mode it shall use Npage >= 256.

[It looks like an erratum has been applied incorrectly as a point has
  been repeated - or maybe they wanted to stress it :-).]

The spec states that the master must use at least 256 repetitions if it
doesn't know the slave's SR mode and that this is the same as R2 mode.
However, the baseband doesn't know whether the master has read the
slave's SR mode. The baseband is told the slave's SR mode by the PSRM
parameter of the HCI_Create_Connection command and chooses an
appropriate number of repetitions. There isn't a PSRM parameter value
for "unknown SR mode". This implies that the only way to obey this part
of the spec is for the host to specify PSRM = 0x02 if it doesn't know
the SR mode of the slave.

The fastest way (on average) to connect to a device whose Bluetooth
address you know but whose SR mode you don't know is just to page it in
R2 mode. This is much faster than inquiring and then connecting with
the right parameters.

	- Steven
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
