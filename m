Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net, pws@csr.com
Subject: Re: [Bluez-users] Test Mode 
In-Reply-To: Message from Manjunath Prabhu <manjunath.mp@gmail.com>
   of "Mon, 06 Dec 2004 20:06:31 +0530." <2de4657604120606361751793a@mail.gmail.com>
References: <2de4657604113010234e4e3a3f@mail.gmail.com> <1101882666.18840.23.camel@pegasus> <200412011028.iB1ASZIk030820@news01.csr.com>  <2de4657604120606361751793a@mail.gmail.com> 
Message-ID: <25262.1102344714@csr.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Mon, 06 Dec 2004 14:51:54 +0000

Manjunath Prabhu wrote:
> Can you tell me how this can be done??? I am trying to set the device
> for loopback but not able to get through......How do I set the
> loopback without entering the Test mode.

Use HCI_write_loopback_mode.  For local this is trivial; either it
works straight away or something is wrong.  For remote, you may need
to have a connection already set up and I believe there may be
restrictions as to whether you are master or slave on the link; try
both.

Since these are test modes, not designed for normal use, keep it as
simple as possible.  Start from scratch for local loopback, start with
just a single remote connection for remote loopback.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
