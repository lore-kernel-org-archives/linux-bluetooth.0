Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200501301948.ALU26389@ms12.netsolmail.com>
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
Date: Sun, 30 Jan 2005 11:48:29 -0800

>
>> Hmm, when I did a 'configure' in bluez-utils-2.14, I used the "--
enable-
>> bcm203x" option before I did a "make install". Where does the utility 
get 
>> installed?
>
>it will be installed into /etc/hotplug/usb/ and you need a working and
>up-to-date hotplug to make this working.

When I did a 'make install', it completed with no errors but I don't see 
anything installed in /etc/hotplug/usb at all. How do I check if the install 
failed?


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
