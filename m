Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MX900 sometimes catalepsic
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: puggy@gentoo.org, bryan@reigndropsfall.net, puggy@bobspants.com
In-Reply-To: <1107771690.23897.23.camel@bluez.bueche.ch>
References: <1106681895.20288.0.camel@bluez.bueche.ch>
	 <1106761340.28444.46.camel@pegasus>
	 <1107771690.23897.23.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1107772579.7327.80.camel@pegasus>
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
Date: Mon, 07 Feb 2005 11:36:19 +0100

Hi Charles,

> sorry for the long time before answering, I wanted to be sure the
> problem is really fixed.
> 
> Apart from the good remarks about the MX900 design error (lack of a
> power-switch), the best suggestion came from Marcel :
> 
> Doing this :
> 
> 	/usr/sbin/hciconfig hci0 noscan
> 	/usr/bin/hidd --killall
> 
> at shutdown time avoids the problem, not a single mouse deadlock anymore
> since one week.
> 
> Thanks for you suggestions. I shall update my MX900 web page rsn.

if this works, then this should be inside the Bluetooth init scripts or
inside the hidd with a special option like --shutdown or so.

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
