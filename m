Return-Path: <Steven.Singer@csr.com>
Message-ID: <406ADF3E.4020502@csr.com>
Date: Wed, 31 Mar 2004 16:09:50 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
References: <406A9E23.9000406@soft.uni-linz.ac.at>
    <1080730774.2674.6.camel@pegasus> <406AAFFF.6040504@soft.uni-linz.ac.at>
In-Reply-To: <406AAFFF.6040504@soft.uni-linz.ac.at>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Simon Vogl wrote:
> oh, sorry: well, after trying for weeks, I see always the same behavior of
> the sco data: after a connect of the sco channel, the data is either byte-swapped
> or offset by one byte, but no indication in any header etc. can be found why
> this is the case.

Is the problem that the link spontaneously changes from correct to noisy
in the middle of a link, or is it that when you start up a link it's
either OK for the durection of the link, or noisy for the duration of
the link and then when you tear it down and start a fresh link, the next
one is, independently, correct our noisy?

If it's the latter case, is the first link after a full reset (BCCMD
reset or power cycle - not merely an HCI reset) ever noisy?

> Marcel, do you I can bug with this at csr?

You should use the CSR public newsgroups (follow the links from the CSR
web site), though, in practice, making enough noise on this mailing list
will eventually attract the attention from someone at CSR (there are
several people here who subscribe).

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
