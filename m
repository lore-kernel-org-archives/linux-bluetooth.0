Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 7 Aug 2007 17:07:40 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.63.0708071702431.8578@pcgl.dsa-ac.de>
MIME-Version: 1.0
Subject: [Bluez-users] [REGRESSION] last working kernel 2.6.18
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

Doing "hcitool cc" under 2.6.18 establishes a connection and keeps it 
open, which can be confirmed per "hcitool cc". Under 2.6.20 and 2.6.22 a 
connection gets established, but is immediately (within 1-2 seconds) 
broken. Is it a change in interfaces, is one supposed to connect 
differently now, or is there a bug somewhere? It is hard to believe, that 
such a bug could stay unnoticed and unfixed for at least 2 kernel 
releases, so, has anything been changed in the API? As a partner a Linux 
system with a 2.4.21 kernel is used. We have only tried thee three (.18, 
.20, and .22) kernel versions so far.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
