Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200501290231.ALR00339@ms12.netsolmail.com>
From: Chris Taylor <cht@imipolex-g.com>
Subject: Re: [Bluez-users] D-Link DWB-120M and BlueZ 2.14
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 28 Jan 2005 18:31:58 -0800

>
>it will be installed into /etc/hotplug/usb/ and you need a working and
>up-to-date hotplug to make this working.

Thanks for your help. Nothing got installed into /etc/hotplug/usb. Can I 
just manually copy somethng from bluez-utils-2.14/extra into there, like 
bcm203x.usermap? I can't figure out where it should go.

My /etc/rc.d/rc.hotplug says this at the top:
# $Id: hotplug,v 1.3 2002/12/03 02:01:48 dbrownell Exp $

Is that too old?

------------------
Chris Taylor
cht@imipolex-g.com
Los Angeles


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
