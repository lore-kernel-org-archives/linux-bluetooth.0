Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050316135754.58091.qmail@web60909.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] adding sdp service record attributes
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1125507497-1110981474=:58029"
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
Date: Wed, 16 Mar 2005 21:57:54 +0800 (CST)

--0-1125507497-1110981474=:58029
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel!
    Thanks for your reply. But I wish to know that from the result I've put in the last email, which belong to attrib_id and attrib_value respectively? I just want to know about this and then I'll put the correspnding values in my program to add it.  You can find the result of "sdptool get --tree " from last email. Thank you very much.
Michael
Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Michael,

> Sorry for that. Maybe I rephrase the question like this.
> Now, I'm still struggling about how to add sdp service profiles in
> my Linux PC. And the most important thing is to let my computer to act
> as headset so that T610 can connect to it. I know that to add the
> service, using add_headset function is the way. But I find that only
> using this function is not enough, and I also find that there is a
> command called "setattr" that sets or adds the attributes to SDP
> record. Then I wish to know that if the setattr command, or set_attrib
> function in sdptool.c is necessary. If so, in the setattr command,
> there are two parameters that I've to enter, attrib_id and
> attrib_value. I wish to know what are the corresponding values of
> these two parameters from the following after I've typed "sdptool get
> --tree "?
> Attribute Identifier : 0x0 - ServiceRecordHandle
> Integer : 0x10002
> Attribute Identifier : 0x1 - ServiceClassIDList
> Data Sequence
> UUID16 : 0x1108 - Headset
> UUID16 : 0x1203 - GenericAudio
> Attribute Identifier : 0x4 - ProtocolDescriptorList
> Data Sequence
> Data Sequence
> UUID16 : 0x0100 - L2CAP
> Data Sequence
> UUID16 : 0x0003 - RFCOMM
> Channel/Port (Integer) : 0x5
> Attribute Identifier : 0x5 - BrowseGroupList
> Data Sequence
> UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
> Data Sequence
> Data Sequence
> UUID16 : 0x1108 - Headset
> Version (Integer) : 0x100
> Attribute Identifier : 0x100
> Lastly, I wish to konw that if I can let my PC to act as headset
> for T610, after I've added the profile in it, is there any program
> needed to install in T610 so that it can connect to the PC?
> Hope that this can be clearer to you. Thank you very much.

now I get what you want. In general adding SDP records with sdptool is
only for testing purpose. You should include you own code for it, like
we do for pand or dund. However if you think that the add_headset() in
sdptool misses an attribute then fix this and send in a patch for it.

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

--0-1125507497-1110981474=:58029
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Thanks for your reply. But I wish to know that from the result I've put in the last email, which belong to attrib_id and attrib_value respectively? I just want to know about this and then I'll put the correspnding values in my program to add it.&nbsp; You can find the result of "sdptool get --tree <RECORDHANDLE>" from last email. Thank you very much.</DIV>
<DIV>Michael<BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>&gt; Sorry for that. Maybe I rephrase the question like this.<BR>&gt; Now, I'm still struggling about how to add sdp service profiles in<BR>&gt; my Linux PC. And the most important thing is to let my computer to act<BR>&gt; as headset so that T610 can connect to it. I know that to add the<BR>&gt; service, using add_headset function is the way. But I find that only<BR>&gt; using this function is not enough, and I also find that there is a<BR>&gt; command called "setattr" that sets or adds the attributes to SDP<BR>&gt; record. Then I wish to know that if the setattr command, or set_attrib<BR>&gt; function in sdptool.c is necessary. If so, in the setattr command,<BR>&gt; there are two parameters that I've to enter, attrib_id and<BR>&gt; attrib_value. I wish to know what are the corresponding values of<BR>&gt; these two parameters from the following after I've t
 yped
 "sdptool get<BR>&gt; --tree <RECORDHANDLE>"?<BR>&gt; Attribute Identifier : 0x0 - ServiceRecordHandle<BR>&gt; Integer : 0x10002<BR>&gt; Attribute Identifier : 0x1 - ServiceClassIDList<BR>&gt; Data Sequence<BR>&gt; UUID16 : 0x1108 - Headset<BR>&gt; UUID16 : 0x1203 - GenericAudio<BR>&gt; Attribute Identifier : 0x4 - ProtocolDescriptorList<BR>&gt; Data Sequence<BR>&gt; Data Sequence<BR>&gt; UUID16 : 0x0100 - L2CAP<BR>&gt; Data Sequence<BR>&gt; UUID16 : 0x0003 - RFCOMM<BR>&gt; Channel/Port (Integer) : 0x5<BR>&gt; Attribute Identifier : 0x5 - BrowseGroupList<BR>&gt; Data Sequence<BR>&gt; UUID16 : 0x1002 - PublicBrowseGroup (SDP)<BR>&gt; Attribute Identifier : 0x9 - BluetoothProfileDescriptorList<BR>&gt; Data Sequence<BR>&gt; Data Sequence<BR>&gt; UUID16 : 0x1108 - Headset<BR>&gt; Version (Integer) : 0x100<BR>&gt; Attribute Identifier : 0x100<BR>&gt; Lastly, I wish to konw that if I can let my PC to act as headset<BR>&gt; for T610, after I've added the profile in it, is there any
 program<BR>&gt; needed to install in T610 so that it can connect to the PC?<BR>&gt; Hope that this can be clearer to you. Thank you very much.<BR><BR>now I get what you want. In general adding SDP records with sdptool is<BR>only for testing purpose. You should include you own code for it, like<BR>we do for pand or dund. However if you think that the add_headset() in<BR>sdptool misses an attribute then fix this and send in a patch for it.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing
 list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1125507497-1110981474=:58029--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
