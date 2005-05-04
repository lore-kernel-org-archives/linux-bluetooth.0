Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: pratik parekh <pparekh@usc.edu>
To: bluez-devel@lists.sourceforge.net
Message-id: <4cfdd218c4c.4277fec2@usc.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Bluez-devel] How to run Local SDP Server?!!
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
Date: Tue, 03 May 2005 22:44:18 -0700

Hello,
    I am stdent working on a project on Bluetooth. I am usind Rococo on Bluez and using JSR-82. I am trying to set up RFCOMM communication between 2 USB dongles attached to PCs.
    I cant seem to get the SDP server running. On running sdptool browse local i get the following message --

[root@localhost root]# sdptool browse local
Failed to connect to SDP server on FF:FF:FF:00:00:00: No such file or directory

    I have installed the files hcidump, lib and utils.
    Do I have to run any command to get SDP running? 
    Thank-you for your help.
Regards,
Pratik Parekh.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
