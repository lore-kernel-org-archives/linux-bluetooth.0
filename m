Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050315152257.8200.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
To: bluez-user list <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1334197732-1110900177=:7365"
Subject: [Bluez-users] adding sdp service record attributes
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
Date: Tue, 15 Mar 2005 23:22:57 +0800 (CST)

--0-1334197732-1110900177=:7365
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi all!
    I'm trying to add sdp service profile using sdptool, and I found one that is to add attribute to a SDP record. I wish to know that is that true? If so, I wish to know what the values should be put according to this command "sdptool get record_handle attrib_id attrib_value"? Here is the result when I typed "sdptool get --tree record_handle". I wish to know that what corresponds attrib_id and attrib_value?
    Thank you very much.
Michael
 
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10002
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1108 - Headset
    UUID16 : 0x1203 - GenericAudio
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x5
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1108 - Headset
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "Headset"




---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-1334197732-1110900177=:7365
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>Hi all!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I'm trying to add sdp service profile using sdptool, and I found one that is to add attribute to a SDP record. I wish to know that is that true? If so, I wish to know what the values should be put according to this command "sdptool&nbsp;get record_handle attrib_id attrib_value"? Here is the result when I typed "sdptool get --tree record_handle". I wish to know that what corresponds attrib_id and attrib_value?</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Thank you very much.</DIV>
<DIV>Michael</DIV>
<DIV>&nbsp;</DIV>
<DIV>Attribute Identifier : 0x0 - ServiceRecordHandle<BR>&nbsp; Integer : 0x10002<BR>Attribute Identifier : 0x1 - ServiceClassIDList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1108 - Headset<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1203 - GenericAudio<BR>Attribute Identifier : 0x4 - ProtocolDescriptorList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 : 0x0100 - L2CAP<BR>&nbsp;&nbsp;&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 : 0x0003 - RFCOMM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Channel/Port (Integer) : 0x5<BR>Attribute Identifier : 0x5 - BrowseGroupList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1002 - PublicBrowseGroup (SDP)<BR>Attribute Identifier : 0x9 - BluetoothProfileDescriptorList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 : 0x1108 - Headset<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version (Integer) : 0x100<BR>Attribute Identifie
 r :
 0x100<BR>&nbsp; Text : "Headset"</DIV></DIV><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1334197732-1110900177=:7365--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
