Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Information on Scatternet
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <006a01c509f5$3bd6d660$1102a8c0@TIN.IT>
References: <006a01c509f5$3bd6d660$1102a8c0@TIN.IT>
Content-Type: text/plain
Message-Id: <1107439743.11944.68.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 03 Feb 2005 15:09:03 +0100

Hi Elisabetta,

> I would like to know if it's possible to realize a BT scatternet made
> by some hundreds (300 for example) of piconets. Each node of the
> piconet (max 5) has to connect only with the master of the piconet
> itself, and each piconet has to send and receive data, via BT, with a
> PC that has to  collect and manage the data of all the piconets. The
> distance between the majority of the piconets and the PC is greater
> than the max possible for a BT class 1 device, so it's necessary that
> the master of each piconet work as a gateway for the other piconets. 

this is possible, but you need at scatternet capable Bluetooth chip (for
example a CSR BlueCore with HCI 16.4 firmware or newer). What you really
need to make sure is that the roles are switched correctly. Remember
that the device that initiates a connection is the master of a piconet
in the first place.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
