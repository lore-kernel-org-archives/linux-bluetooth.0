Return-Path: <Steven.Singer@csr.com>
Message-ID: <3FF9D546.9040005@csr.com>
Date: Mon, 05 Jan 2004 21:21:10 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Florian Echtler <echtler@fs.tum.de>,
   Olivier Bornet
    <olivier.bornet@smartdata.ch>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bthid cvs question
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
    <1071020597.10655.4.camel@pegasus> <20031210080259.GF26896@smartdata.ch>
    <1071065922.10655.60.camel@pegasus>
    <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
    <1071969925.2684.5.camel@pegasus> <3FF99466.8080209@csr.com>
    <1073329354.2508.26.camel@pegasus>
In-Reply-To: <1073329354.2508.26.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
>>A lot of devices use page scan repetition mode R2 by default as it's the
>>lowest power mode.
> 
> the most device I have seen are using R1 by default and the only R2 are
> my HID devices.

Headsets can use R2. Basically any battery powered device that needs to
be connectable for long periods of time will be a candidate for using R2.

> I am no baseband expert, so let me see if I understand you right. In the
> case we don't know the page scan repetition mode we should use R2 in
> prefer of R1 or even R0? 

Correct.

 >                          Does this have disadvantages if the devices is
> in R1 or R0 mode? I ask because we found that connecting with R1 by
> default gives us a significant page time improvement.

The disadvantage of always using R2 is that you connect more slowly to
unknown devices than you might do if you used R1.

The advantage of using R2 is that you can connect to all devices. If you
use R1 then there may be many devices out there that you cannot connect
to (or that you connect to unreliably).

The worst case baseband connection times for different scenarios are:

slave sr \ master psrm  R0        R1        R2
R0                      0.20s     1.28s     2.56s
R1                      infinity  2.56s     3.84s
R2                      infinity  infinity  5.12s

> If only R2 makes sense in case that we don't the exact value, somebody
> should bring up an errata to the HCI working group ;)

The note from the baseband needs to be moved up to the HCI spec.

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
