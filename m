Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Bluethooth "Elite" Keyboard & Mouse -
	UPDATE:  works with stock 2.6.10
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050120191228.GA1662@virgilio.it>
References: <20050116174616.GA2201@virgilio.it>
	 <200501161851.01291.cijoml@volny.cz> <1105898506.8080.20.camel@pegasus>
	 <20050116193732.GA2326@virgilio.it>  <20050120191228.GA1662@virgilio.it>
Content-Type: text/plain
Message-Id: <1106248719.13562.22.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 20 Jan 2005 20:18:39 +0100

Hi Francesco,

> I tried with plain 2.6.10 (from debian kernel-source package, without any
> patch other than Debian's) and it seems to work fine with my BT keyboard & mouse. Only
> needed an "hidd --connect" after inserting the dongle (the one coming with
> the keyboard).
> It might be that in the future I will experience the problems hinted by
> Marcel, but for now I am happy :-).
> 
> I'm trying now to make the dongle work with my SonyEricsson T610; for now the
> phone it is discovered (and is capable to discover the PC), but I'm not
> yet succeeded to use OpenObex tools with the bluetooth connection.
> But that is another story.
> 
> Question: what would be the advantage now of applying the 2.6.10-mh1 patch
> to sthe standard kernel sources?

you will get the latest Bluetooth subsystem that also includes some
changes to the hidp kernel module.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
