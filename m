Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Again: Problems with Dongle, Headset or btsco
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41F4DA44.6070608@dark-reality.de>
References: <41F0EB0A.1020302@webstuhl.net>
	 <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net>
	 <41F13638.1080207@dark-reality.de> <41F25C4B.6040709@webstuhl.net>
	 <csts46$p5n$1@sea.gmane.org> <41F29274.3020909@webstuhl.net>
	 <41F3E469.3020306@dark-reality.de> <41F4D1ED.6070502@webstuhl.net>
	 <41F4DA44.6070608@dark-reality.de>
Content-Type: text/plain
Message-Id: <1106569225.9269.64.camel@pegasus>
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
Date: Mon, 24 Jan 2005 13:20:25 +0100

Hi Lars,

> as it seems that those dongles seem not to work with the currect sco
> implementation, what would you propose to debug this misfunction?
> 
> Maybe the hci_usb driver can be fixed or a workaround added for this
> chipsets (I think they are buggy, not our implementation, but if there's
> a simple workaround...)

the Silicon Wave chips are not the best ones. They have problems and it
seems that they are not going to fix them. Mostly because they sell ROM
chips are these ones can't be updated by a newer firmware. However if
this is the problem with SCO packets and handle 0 then the hci_usb
driver should simply drop these frames, because they are not valid SCO
payload.

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
