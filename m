Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41FF97A2.7080002@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Hardware error
References: <41FF6E2C.7040908@avantwave.com>
In-Reply-To: <41FF6E2C.7040908@avantwave.com>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 01 Feb 2005 14:52:18 +0000

mike wrote:
>  > HCI Event: Hardware Error(0x10) plen 1

If you find out what the parameter was to the hardware error event, you
might get a clue as to what was going on.

You can look up the hardware error codes for CSR chips in the document
HQ Commands (bcore-sp-003Pc) on the CSR support web site if you have
access (www.csrsupport.com).

The most common hardware error emitted by CSR devices running the H4
UART host transport is 0xfe. This indicates that the chip has lost HCI
synchronisation with the host. This is caused either by the host sending
invalid data or because of corruption of the UART traffic on the wire.

Unfortunately, the H4 UART protocol does not support a proper error
recovery procedure. The only option, once this error has occurred, is
to issue an HCI_Reset which will, of course, tear down all existing
links.

	- Steven


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
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
