Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <6.1.2.0.2.20050124165802.04168330@luna.tlmat.unican.es>
To: bluez-users@lists.sourceforge.net
From: George <george.news@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Bluez-users] Bluez BNEP connection close
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
Date: Mon, 24 Jan 2005 17:06:23 +0100

Hi all.

I'm facing a problem using the Bluez stack for linux and I don't know the 
reason and how to solve it.
I'm using the PAN environment, using the BNEP over L2CAP. I'm using kernel 
2.4.28-mh1 and bluez-libs-2.10 and bluez-utils-2.10.

I manage to get both devices connected and running a ping over it. However 
when I do some web browsing a problem appear (also if doing an FTP or 
whatever thing).
When the amount of traffic through the connection increase, the connection 
shut down without any reason.

Any idea of why when stressing the connection by transferring big amount of 
data it closes.


TA.




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
