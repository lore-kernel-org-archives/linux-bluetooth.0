Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Chen Bin <binch@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1102340081.653.6.camel@debian>
Mime-Version: 1.0
Subject: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
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
Date: Mon, 06 Dec 2004 21:34:41 +0800

Hi Marcel,

Do you remember that I have asked a CoD question in this list and you
ask me to do a patch to let the CoD value in hci_conn? Now I have time
to do this work and I have something to clarify for I am not a bluez
member before and I am not very fimiliar with BlueZ.

This time I just want to keep the remote CoD value in hci_conn when a
connection is done. But as you know, sometimes it is impossible for us
to get the CoD of the remote class without a prestage inquiry. So, not
every CoD value in hci_conn is valid. I will check the BT spec to find a
right way to tell the user whether the CoD is valid.

Is it enough that I add a field to hci_conn and when the connection is
done I update the field?

Chen



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
