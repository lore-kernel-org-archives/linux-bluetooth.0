Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40C74EDD.6060903@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
CC: Bluez Devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI Event: Connect Complete with Status 09
References: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 09 Jun 2004 18:54:37 +0100

Andreas Gaufer wrote:
> I get into situations where the chip returnes a "Connect Complete" event 
> with status MAX NUMBER OF CONNECTIONS (0X09) without having open handles.

How do you get in to this situation? Are you, for example, connecting
and disconnecting very rapidly (less than 1 second per connection) or
are you resetting the remote end of the link without using a proper
disconnect?

Which CSR firmware version are you using?

You might want to grab an HCI log and move this discussion to the CSR
support newsgroup (access details at http://www.csr.com/forum.htm).
Read the FAQ for a description of suitable log formats.

A summary of the times of the commands and events associated with
creating and disconnecting any previous connections (including the
statuses and connection handles in all the events) might be shorter than
a full log.

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



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
