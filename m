Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN and DUN
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA938705EE4718@scsmsx401.amr.corp.intel.com>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA938705EE4718@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1106225706.8190.182.camel@pegasus>
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
Date: Thu, 20 Jan 2005 13:55:06 +0100

Hi Trevor,

> I'm confused by the how-to at
> http://www.cs.ucla.edu/~cclljj/interest/notes/bluez/pand_dund.html --
> which is linked from the BlueZ how-to page.
>  
> It does a fair bit of setup, and then has the instructions:
> 
> 13. on master side: 
> sdpd
> pand --listen --master --service --sdp --role NAP
> dund --listen --sdp
> 
> 14. on slave side 
> sdpd
> pand --connect <bt_addr> --sdp
> dund --connect <bt_addr> --sdp
> 
> Which, is far as I can tell, is setting up both a dun and pan connection
> between the two devices -- which seems very redundant to me. The DUN
> link will set up an IP link over RFCOMM using PPP, while PAN will set up
> a direct IP link.
> 
> Is this correct?  Wouldn't it be sufficient to either dun or pan, but
> not both?

this depends on your setup. For the master it makes sense to have both
daemons running (like some access points), but for the slave side you
should choose one and you should prefer pand. However it seems that this
howto is also a little bit out of date, because the --sdp doesn't exists
anymore.

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
