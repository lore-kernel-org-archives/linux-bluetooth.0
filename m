Return-Path: <Steven.Singer@csr.com>
Message-ID: <40435D9D.5020509@csr.com>
Date: Mon, 01 Mar 2004 15:58:21 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Thor Egil Skaug <paxtonrd@hotmail.com>
CC: "'Marcel Holtmann'" <marcel@holtmann.org>,
   "'BlueZ Mailing List'"
    <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AUX1 packets
References: <000001c3ffa4$181dee40$46a57e40@thores>
In-Reply-To: <000001c3ffa4$181dee40$46a57e40@thores>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-users.lists.sourceforge.net>

Thor Egil Skaug wrote:
> I am trying to have my application select different packet types based
> on the current BER.

If both ends of the link support CQDDR then the Link Managers will do
this automatically.

If you try to do this yourself, you'll just end up with the host and the
controller fighting each other.

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
