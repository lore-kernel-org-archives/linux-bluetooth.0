Return-Path: <Steven.Singer@csr.com>
Message-ID: <3FF99BA8.7040806@csr.com>
Date: Mon, 05 Jan 2004 17:15:20 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Chris Hubball <chris.hubball@csr.com>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Apple mouse and disconnect problem
References: <7D3093619D15A841A322413C3F138E0855C2F9@exchange02.csr.com>
    <1073320020.2508.17.camel@pegasus>
In-Reply-To: <1073320020.2508.17.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

> So the question is if it is ok if both ends call hci_disconnect? Do you
> have seen any problems both ends are trying to terminate the ACL link?
> How do the link manager handles this? I can't find any valuable comment
> in the specification or the profiles which end should terminate the ACL
> link.

In theory link managers should handle this fine. If they don't then it's
a bug in the link manager and not the host's fault. Just be aware of the
race hazard. You may get two disconnection_complete events one with an
error code.

Note that when I say that a disconnection_complete event is flagged with
an error, I mean that the status field is non-zero, not that the reason
field is non-zero.

So I'd expect something like (local side wins the race):

   v Disconnect hnd:h
   ^ Command_Status Pending
   ^ Disconnect_Complete Success hnd:h Connection_Terminated_By_Local_Host

or (local side loses the race):

   v Disconnect hnd:h
   ^ Disconnect_Complete Success hnd:h Other_End_Terminated_Connection:...
   ^ Command_Status No_Connection

or (if the race is a little closer and the link manager is not taking
special care to avoid this situation):

   v Disconnect hnd:h
   ^ Command_Status Pending
   ^ Disconnect_Complete Success hnd:h Other_End_Terminated_Connection:...
   ^ Disconnect_Complete No_Connection hnd:h

Note, however, that these are no worse than the races you get if you try
to disconnect a link just as the supervision timeout fires.

I'm straining my memory here, but I vaguely recall having seen bugs with
this race in some link managers in the distant past so you should be
robust against suprious errors. One likely error is to get two successful
disconnection_complete events for the same handle (you should either get
just one or the second should be flagged with an error). A second
possible error is that you get two disconnection_complete events and one
is marked with an invalid connection handle (such as 0x0000).

My memory is a little hazy - I may be confusing this scenario with other
problems I've seen in the past (they all blur into one after a while).

Basically, every level in the stack should be able to cope with abrupt
and unexpected disconnections as they have to be able to cope with
supervision timeouts. Once you get above HCI, apart from the reason code
in the disconnection_complete event, there's no difference between a
supervision timeout and the remote end cleanly terminating the link.

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
