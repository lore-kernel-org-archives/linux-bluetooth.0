Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] psm-need help!
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0502041822260.30199-100000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0502041822260.30199-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1107538471.6921.55.camel@pegasus>
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
Date: Fri, 04 Feb 2005 18:34:31 +0100

Hi Peter,

> PSM (protocol service multiplexer) is defined in RFCOMM. Basically it is
> the channel two RFCOMM devices use to communicate. You may have more then
> one RFCOMM channel on different PSMs between two Bluetooth devices.
> Normaly the PSM needed to connect to a remote RFCOMM channel is found by
> an SDP search (it is part of the service record).

let me correct this. The PSM is part of the L2CAP and not RFCOMM. The
ports (if you wanna name it so) of L2CAP are called PSM. All of them are
odd and they exists reserved ones. Details are in the specification. In
RFCOMM it is called DLCI (with direction bit) or channels for short.

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
