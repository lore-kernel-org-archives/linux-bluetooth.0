Return-Path: <Steven.Singer@csr.com>
Message-ID: <3F2E5F7D.50702@csr.com>
Date: Mon, 04 Aug 2003 14:28:29 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: =?ISO-8859-1?Q?Riikka_Jylh=E4?= <jylhar@ac.tut.fi>, BlueZ Mailing List  <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB-drivers
References: <000201c35a85$b18576d0$ae2ae682@ac.tut.fi>
	<1060001774.955.4.camel@pegasus>
In-Reply-To: <1060001774.955.4.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> My CSR dongles only support linear PCM (2's complement) with 8 or 16 bit
> for input. See output of "hciconfig hci0 voice".

That shouldn't be the whole truth. The full list should be:

   Linear:
     16 bit with up to 7 MSBs ignored, or 8 bit
     1's complement, 2's complement or sign-magnitude
   Logarithmic:
     8 bit u-law or A-law

That's the full set of host formats allowed by the BT 1.1 HCI spec.

The sample rate is fixed at 8 kHz (as defined by the Bluetooth spec).

I wouldn't recommend sending mp3s over a SCO link. Wavs should be
fine provided they're resampled at 8 kHz, you set the voice setting
to the appropriate data format, you skip the header and you get the
rate matching right.

(Anyone else reading this thread, particularly in the archive, should
  look at the thread Rikka started called "About Scotest" for several
  important caveats from me about SCO data).

	- Steven
-- 



**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited.  
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************
