Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FD9B51.2090306@cloutier-vilhuber.net>
From: Lars Vilhuber <lists.all@cloutier-vilhuber.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] experience with TDK PCMCIA Bluetooth Card (goBlue)?
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
Date: Sun, 30 Jan 2005 21:43:29 -0500

Question:
    after searching the list, I see few comments on the TDK PCMCIA 
Bluetooth card. Currently, mine is *not* working, but before I go 
through (upgrade kernel, patch kernel, etc.) sequence, I would like to 
know if anybody has actually got it working.

Symptoms are a collection of

bcsp_recv: Short BCSP packet
bcsp_recv: Out-of-order packet arrive
bcsp_recv: Error in BCSP hdr checksum

which I have seen reported for some cards before, but for which I 
haven't a solution reported.

The above occurs for any data transfer (OBEX or PPP) of any considerable 
size, and culminates in the driver "resetting" the card, and the 
transfer failing.

This is irrespective of using 'hciattach ttyS14 <speed>' or 'hciattach 
ttyS14 bcsp' or 'hciattach ttyS14 tdk'.

OS/Version:
SuSE 9.2, kernel 2.6.8-24.11-default #1 Fri Jan 14 13:01:26
bluez-utils-2.10-15
bluez-libs-2.10-2


-- 
Lars Vilhuber                    lists.all@cloutier-vilhuber.net


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
