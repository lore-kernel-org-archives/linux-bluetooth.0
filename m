Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI Events and errors
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <37D1FAB2FA7B7E4993785B956F853C73181467@ednex506.dsto.defence.gov.au>
References: 
	 <37D1FAB2FA7B7E4993785B956F853C73181467@ednex506.dsto.defence.gov.au>
Content-Type: text/plain
Message-Id: <1107325085.9276.15.camel@pegasus>
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
Date: Wed, 02 Feb 2005 07:18:05 +0100

Hi Victor,

> > the "hci_num_comp_pkts_evt: hci0 num_hndl 1" is missing here and this
> > means that the flow is suspended and we can't send HCI commands or
> > data anymore. You may run into an memory problem if you keep 
> > sending and the hardware never wakes up again,
> 
> The user-space app doesn't see any problem at the point where the
> hardware error is raised, so it keeps calling send() until eventually
> send() fails with a 'resource unavailable' error status, presumably
> because of the lack of sk_buf's.

maybe it is a good idea to forward the hardware error up to the L2CAP
layer so that you will see the error there.

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
