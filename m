Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "João Santos" <jsantos_pt@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F42DCZx4FR0rmT00041536@hotmail.com>
Subject: [Bluez-users] sdptool setattr
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 28 Jan 2004 18:07:41 +0000

Hi all,

Anyone can tell me how i add a attribute in my sdp record with a boolean 
value.
i'm trying to add the 0x0302 attr_id(Remote audio volume control) with the 
attr_value set as boolean True.
I have done:

[root@olivia libs]# sdptool setattr 0x804f778 0x0302 True
Adding attrib 0x302 string "True" to record 0x804F778

[root@olivia libs]# sdptool get --tree 0x804f778
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x804f778
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
      Channel/Port (Integer) : 0xc
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
Attribute Identifier : 0x302 - Remote audio volume control
  Text : "True"


but as you can see the attr_value is set in the test format.

Thanks in advance,

João Santos

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
