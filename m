Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <D452D7C969F4374EBD302882A8EDF0C958696E@ednex505.dsto.defence.gov.au>
From: "Roszkowski, Michal" <Michal.Roszkowski@dsto.defence.gov.au>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] BlueZ on embedded systems?
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
Date: Thu, 20 Jan 2005 10:32:39 +1030


Apologies if this email is a duplicate, but the previous attempt didn't seem to show up in the archive; so I'm not sure if it arrived sussessfully.

I would like to know how easy it would be to port the bluez stack to run self-contained (ie. without an OS) on an embedded ARM7 platform (Atmel AT91M40400)?

There would be a simple (non-preemptive) scheduler running, but other OS services required by bluez would have to be written. A quick look at the source suggests to me a heavy dependency on kernel sockets. Could this dependency be simplified (ie. replaced with a simple mechanism?).

There would also be basic dynamic memory support via malloc() and free(), but that's about it.

thanks,
michal.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
