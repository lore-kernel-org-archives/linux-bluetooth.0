Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050316012142.60063.qmail@web60906.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] adding sdp service record attributes
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1163214549-1110936102=:59898"
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
Date: Wed, 16 Mar 2005 09:21:42 +0800 (CST)

--0-1163214549-1110936102=:59898
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel!
    Sorry for that. Maybe I rephrase the question like this.
    Now, I'm still struggling about how to add sdp service profiles in my Linux PC. And the most important thing is to let my computer to act as headset so that T610 can connect to it. I know that to add the service, using add_headset function is the way. But I find that only using this function is not enough, and I also find that there is a command called "setattr" that sets or adds the attributes to SDP record. Then I wish to know that if the setattr command, or set_attrib function in sdptool.c is necessary. If so, in the setattr command, there are two parameters that I've to enter, attrib_id and attrib_value. I wish to know what are the corresponding values of these two parameters from the following after I've typed "sdptool get --tree <recordhandle>"?
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
     Lastly, I wish to konw that if I can let my PC to act as headset for T610, after I've added the profile in it, is there any program needed to install in T610 so that it can connect to the PC?
     Hope that this can be clearer to you. Thank you very much.
Michael
Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Michael,

> I'm trying to add sdp service profile using sdptool, and I found
> one that is to add attribute to a SDP record. I wish to know that is
> that true? If so, I wish to know what the values should be put
> according to this command "sdptool get record_handle attrib_id
> attrib_value"? Here is the result when I typed "sdptool get --tree
> record_handle". I wish to know that what corresponds attrib_id and
> attrib_value?

I have no idea what you really wanna know. Try to rephrase your
question.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-1163214549-1110936102=:59898
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Sorry for that. Maybe I rephrase the question like this.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Now, I'm still struggling about how to add sdp service profiles in my Linux PC. And the most important thing is to let my computer to act as headset so that T610 can connect to it. I know that to add the service, using add_headset function is the way. But I find that only using this function is not enough, and I also find that there is a command called "setattr" that sets or adds the attributes to SDP record. Then I wish to know that if the setattr command, or set_attrib function in sdptool.c is necessary. If so, in the setattr command, there are two parameters that I've to enter, attrib_id and attrib_value. I wish to know what are the corresponding values of these two parameters from the following after I've typed "sdptool get --tree &lt;recordhandle&gt;"?<BR>Attribute Identifier : 0x0 - ServiceRecordHandle<BR>&nbsp; Integer : 0x10002<BR>Attribute Identifier : 0x1 - ServiceClassIDList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1108 -
 Headset<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1203 - GenericAudio<BR>Attribute Identifier : 0x4 - ProtocolDescriptorList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 : 0x0100 - L2CAP<BR>&nbsp;&nbsp;&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 : 0x0003 - RFCOMM<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Channel/Port (Integer) : 0x5<BR>Attribute Identifier : 0x5 - BrowseGroupList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1002 - PublicBrowseGroup (SDP)<BR>Attribute Identifier : 0x9 - BluetoothProfileDescriptorList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 : 0x1108 - Headset<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version (Integer) : 0x100<BR>Attribute Identifier : 0x100</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; Lastly, I wish to konw that if I can let my PC to act as headset for T610, after I've added the profile in it, is there any program needed to install in T610 so that it can connect to the PC?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; Hope that this can be clearer to you. Thank you very much.</DIV>
<DIV>Michael<BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>&gt; I'm trying to add sdp service profile using sdptool, and I found<BR>&gt; one that is to add attribute to a SDP record. I wish to know that is<BR>&gt; that true? If so, I wish to know what the values should be put<BR>&gt; according to this command "sdptool get record_handle attrib_id<BR>&gt; attrib_value"? Here is the result when I typed "sdptool get --tree<BR>&gt; record_handle". I wish to know that what corresponds attrib_id and<BR>&gt; attrib_value?<BR><BR>I have no idea what you really wanna know. Try to rephrase your<BR>question.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading
 now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1163214549-1110936102=:59898--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
