Return-Path: <Steven.Singer@csr.com>
Message-ID: <40486C25.2030100@csr.com>
Date: Fri, 05 Mar 2004 12:01:41 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Thor Egil Skaug <paxtonrd@hotmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List
    <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI_switch_role
References: <000b01c4023c$a57de0c0$9349edc7@thores>
    <1078447750.2762.45.camel@pegasus>
In-Reply-To: <1078447750.2762.45.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> Thor Egil Skaug wrote:
>> Is a slave allowed to switch role to master?
> 
> every side can switch the role.

Strictly, both sides can attempt to initiate a switch. Both sides are
also allowed to refuse.

Provided the baseband supports it (check the features) and the link
manager has been told to allow it (check the link policy) then it
should be OK (barring a burst of radio noise that knocks out critical
radio packets - in which case, just try again).

Note that although you can read the features for both sides, you can
check only the local link policy. However, instead of all that, you may
as well just go ahead and try to switch.

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
