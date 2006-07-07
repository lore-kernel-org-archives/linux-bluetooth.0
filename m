Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060707144540.6774.qmail@web25110.mail.ukl.yahoo.com>
Date: Fri, 7 Jul 2006 16:45:40 +0200 (CEST)
From: Salvatore Lionetti <salvatorelionetti@yahoo.it>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <mailman.1221.1152213177.20239.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 3, Issue 6
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1400218301=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1400218301==
Content-Type: multipart/alternative; boundary="0-1257268267-1152283540=:6762"

--0-1257268267-1152283540=:6762
Content-Type: text/plain; charset=iso-8859-1

Hi,
  hoping that this 0<->1 monologue will soon become a N<->1 dialogue (N>0):
  1) Little info2Mark (read only if have !other source where2read)
  2) More detail who want give response to my question (creating a sco connection)
  
  Detail:
  1) ToMark: i know a little about hci protocol: here what i know:
        there are 2 type of data link:  ACL(async,withErrorControl) and SCO(sync,withNoErrorControl). To create  a SCO connection, used also4audio, you need  an existing ACL conn:  in your log the ACL connection is created ok; the problem is when  transforming it ( Change Connection Packet Type (0x01|0x000f)) to a SCO  connection. I don't use bluez because to many problem i had so !know  what configuration change. It seem that in this command there is too  many packet type: i espect only the sco based ones={DH3, DH5}.
      
  This is where i learned something about hci:
    - homes.dico.unimi.it/~gfp/FiMo/2002-03/Slides/Bia/HCI2.ppt
    - hci.h in linux kernel (http://lxr.linux.no/source/include/net/bluetooth/hci.h)
    - http://www.holtmann.org/papers/bluetooth/portoroz2004_security.pdf
    - http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf
  
  
  2) More detail about my preceding answer:
  
  Inquiry (Ok, found my headset.)
  ====================
  <= <cmd=1 4 5 33 8b 9e 5 3>
  => <Evt= f 4 0 1 1 4>
  => <Evt= 02 0f 01 44 f0 01 5b 02 00 01 02 00 04 04 20 01 71>
  => <Evt= 1 1 0>
  
  Create ACL connection
  ====================
  <= <cmd=5 4 d 44 f0 1 5b 2 0 8 0 1 0 0 0 0>
  => <Evt= f 4 0 1 5 4>
  => <Evt=17 06 44 f0 01 5b 02 00>
  
  LinkKeyReply
  ====================
  <= <cmd=b 4 16 44 f0 1 5b 2 0 9f 56 fd ca cf d6 c f4 f0 2 c8 f7 35 43 76 58>
  => <Evt= e a 1 b 4 044f0 15b 2 0>
  => <Evt= 3 b 028 044f0 15b 2 0 1 0>
  
  AddSco
  ====================
  <= <cmd=7 4 3 28 0 20>
  => <Evt= f 412 1 7 4>
  ====================
  So status=0x12 (EINVAL?)
  There is something to add?Something wrong?
  
  Many thanks for your attention
  Bye
  Salvatore
  
bluez-users-request@lists.sourceforge.net ha scritto:   Send Bluez-users mailing list submissions to
 bluez-users@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
 https://lists.sourceforge.net/lists/listinfo/bluez-users
or, via email, send a message with subject or body 'help' to
 bluez-users-request@lists.sourceforge.net

You can reach the person managing the list at
 bluez-users-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-users digest..."


Today's Topics:

   1. hcidump of an ok sco connection with a hs? (Salvatore Lionetti)
   2. hcidump output (Mark S. Townsley)


----------------------------------------------------------------------

Message: 1
Date: Thu, 6 Jul 2006 12:09:12 +0200 (CEST)
From: Salvatore Lionetti 
Subject: [Bluez-users] hcidump of an ok sco connection with a hs?
To: bluez-users@lists.sourceforge.net
Message-ID: <20060706100912.95773.qmail@web25107.mail.ukl.yahoo.com>
Content-Type: text/plain; charset="iso-8859-1"

Hi,
  i 'm trying to establish a connection with a headset from a usb/dongle  using a my custom usb driver: the acl connection is created, the sco  one's is refused. 
  1) I'm looking for an output of hcidump related to the creation from scratch of a sco connection, eventually whit sco data,
  2) is necessary l2cap packet to start sco transfer?
  
  Thank you for your attention.
  
 Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060706/059fc445/attachment.html 

------------------------------

Message: 2
Date: Thu, 6 Jul 2006 10:16:37 -0700
From: "Mark S. Townsley" 
Subject: [Bluez-users] hcidump output
To: bluez-users 
Message-ID:
 
Content-Type: text/plain; charset="iso-8859-1"

Dear All:

When connecting to my device, I got a "Connection timeout" from sdpd.  I did
an hcidump but I have no idea how to interpret the output.
Specifically, there is a "Command Disallowed" but I don't see what the
command is.  Is there a guide online explaining how to interpret hcidump
results?

Thanks

--------------------------------------------------------
hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:1C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:0D:3B:1C
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:A0:96:0D:3B:1C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x08
    Reason: Connection Timeout
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:1C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:0D:3B:1C
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:A0:96:0D:3B:1C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x08
    Reason: Connection Timeout
^
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060706/75afd491/attachment.html 

------------------------------

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

------------------------------

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


End of Bluez-users Digest, Vol 3, Issue 6
*****************************************


 Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
--0-1257268267-1152283540=:6762
Content-Type: text/html; charset=iso-8859-1

Hi,<br>  hoping that this 0&lt;-&gt;1 monologue will soon become a N&lt;-&gt;1 dialogue (N&gt;0):<br>  1) Little info2Mark (read only if have !other source where2read)<br>  2) More detail who want give response to my question (creating a sco connection)<br>  <br>  Detail:<br>  1) ToMark: i know a little about hci protocol: here what i know:<br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; there are 2 type of data link:  ACL(async,withErrorControl) and SCO(sync,withNoErrorControl). To create  a SCO connection, used also4audio, you need&nbsp; an existing ACL conn:  in your log the ACL connection is created ok; the problem is when  transforming it ( Change Connection Packet Type (0x01|0x000f)) to a SCO  connection. I don't use bluez because to many problem i had so !know  what configuration change. It seem that in this command there is too  many packet type: i espect only the sco based ones={DH3, DH5}.<br>  &nbsp;&nbsp;&nbsp; <br>  This is where i learned something about hci:<br>  &nbsp; -
 <font size="-1"><font color="#008000">homes.dico.unimi.it/~gfp/<wbr>FiMo/2002-03/Slides/Bia/HCI2.ppt<br>  </font></font>&nbsp; - hci.h in linux kernel (http://lxr.linux.no/source/include/net/bluetooth/hci.h)<br>  &nbsp; - http://www.holtmann.org/papers/bluetooth/portoroz2004_security.pdf<br>  &nbsp; - http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf<br>  <br>  <br>  2) More detail about my preceding answer:<br>  <br>  Inquiry (Ok, found my headset.)<br>  ====================<br>  &lt;= &lt;cmd=1 4 5 33 8b 9e 5 3&gt;<br>  =&gt; &lt;Evt= f 4 0 1 1 4&gt;<br>  =&gt; &lt;Evt= 02 0f 01 44 f0 01 5b 02 00 01 02 00 04 04 20 01 71&gt;<br>  =&gt; &lt;Evt= 1 1 0&gt;<br>  <br>  Create ACL connection<br>  ====================<br>  &lt;= &lt;cmd=5 4 d 44 f0 1 5b 2 0 8 0 1 0 0 0 0&gt;<br>  =&gt; &lt;Evt= f 4 0 1 5 4&gt;<br>  =&gt; &lt;Evt=17 06 44 f0 01 5b 02 00&gt;<br>  <br>  LinkKeyReply<br>  ====================<br>  &lt;= &lt;cmd=b 4 16 44 f0 1 5b 2 0 9f 56 fd ca cf d6 c f4
 f0 2 c8 f7 35 43 76 58&gt;<br>  =&gt; &lt;Evt= e a 1 b 4 044f0 15b 2 0&gt;<br>  =&gt; &lt;Evt= 3 b 028 044f0 15b 2 0 1 0&gt;<br>  <br>  AddSco<br>  ====================<br>  &lt;= &lt;cmd=7 4 3 28 0 20&gt;<br>  =&gt; &lt;Evt= f 412 1 7 4&gt;<br>  ====================<br>  So status=0x12 (EINVAL?)<br>  There is something to add?Something wrong?<br>  <br>  Many thanks for your attention<br>  Bye<br>  Salvatore<br>  <br><b><i>bluez-users-request@lists.sourceforge.net</i></b> ha scritto: <blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">  Send Bluez-users mailing list submissions to<br> bluez-users@lists.sourceforge.net<br><br>To subscribe or unsubscribe via the World Wide Web, visit<br> https://lists.sourceforge.net/lists/listinfo/bluez-users<br>or, via email, send a message with subject or body 'help' to<br> bluez-users-request@lists.sourceforge.net<br><br>You can reach the person managing the list at<br>
 bluez-users-owner@lists.sourceforge.net<br><br>When replying, please edit your Subject line so it is more specific<br>than "Re: Contents of Bluez-users digest..."<br><br><br>Today's Topics:<br><br>   1. hcidump of an ok sco connection with a hs? (Salvatore Lionetti)<br>   2. hcidump output (Mark S. Townsley)<br><br><br>----------------------------------------------------------------------<br><br>Message: 1<br>Date: Thu, 6 Jul 2006 12:09:12 +0200 (CEST)<br>From: Salvatore Lionetti <salvatorelionetti @yahoo.it=""><br>Subject: [Bluez-users] hcidump of an ok sco connection with a hs?<br>To: bluez-users@lists.sourceforge.net<br>Message-ID: &lt;20060706100912.95773.qmail@web25107.mail.ukl.yahoo.com&gt;<br>Content-Type: text/plain; charset="iso-8859-1"<br><br>Hi,<br>  i 'm trying to establish a connection with a headset from a usb/dongle  using a my custom usb driver: the acl connection is created, the sco  one's is refused. <br>  1) I'm looking for an output of hcidump related
 to the creation from scratch of a sco connection, eventually whit sco data,<br>  2) is necessary l2cap packet to start sco transfer?<br>  <br>  Thank you for your attention.<br>  <br> Chiacchiera con i tuoi amici in tempo reale! <br> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com <br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br>URL: http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060706/059fc445/attachment.html <br><br>------------------------------<br><br>Message: 2<br>Date: Thu, 6 Jul 2006 10:16:37 -0700<br>From: "Mark S. Townsley" <mstownsley @gmail.com=""><br>Subject: [Bluez-users] hcidump output<br>To: bluez-users <bluez-users @lists.sourceforge.net=""><br>Message-ID:<br> <be976db60607061016yf4cebb1mda306e5c3912b2bc @mail.gmail.com=""><br>Content-Type: text/plain; charset="iso-8859-1"<br><br>Dear All:<br><br>When connecting to my device, I got a "Connection timeout" from sdpd.  I
 did<br>an hcidump but I have no idea how to interpret the output.<br>Specifically, there is a "Command Disallowed" but I don't see what the<br>command is.  Is there a guide online explaining how to interpret hcidump<br>results?<br><br>Thanks<br><br>--------------------------------------------------------<br>hcidump -X -V<br>HCI sniffer - Bluetooth packet analyzer ver 1.30<br>device: hci0 snap_len: 1028 filter: 0xffffffffffffffff<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>    bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>    bdaddr 00:A0:96:0D:3B:1C role 0x01<br>    Role: Slave<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>&gt; HCI Event: Link Key Request (0x17) plen 6<br>    bdaddr 00:A0:96:0D:3B:1C<br>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>    bdaddr 00:A0:96:0D:3B:1C key
 DA9C58280F96613899D9B1E7EDF75884<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>    Link Key Request Reply (0x01|0x000b) ncmd 1<br>    status 0x00 bdaddr 00:A0:96:0D:3B:1C<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>    status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>    handle 6 policy 0x0f<br>    Link policy: RSWITCH HOLD SNIFF PARK<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>    Write Link Policy Settings (0x02|0x000d) ncmd 1<br>    status 0x00 handle 6<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>    handle 6 ptype 0xcc18<br>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1<br>    Error: Command Disallowed<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>    handle 6 slots 5<br>&gt; ACL data: handle 6 flags 0x02
 dlen 12<br>    L2CAP(s): Connect req: psm 1 scid 0x0040<br>&lt; ACL data: handle 6 flags 0x02 dlen 16<br>    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>      Connection successful<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 1<br>&gt; ACL data: handle 6 flags 0x02 dlen 16<br>    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>      MTU 48<br>&lt; ACL data: handle 6 flags 0x02 dlen 14<br>    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>      Success<br>&lt; ACL data: handle 6 flags 0x02 dlen 12<br>    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 2<br>&gt; ACL data: handle 6 flags 0x02 dlen 14<br>    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>      Success<br>&gt; ACL data: handle 6 flags 0x02 dlen 17<br>&gt; ACL data: handle 6 flags 0x01 dlen 2<br>    L2CAP(d): cid 0x0040
 len 15 [psm 1]<br>        SDP SS Req: tid 0x1 len 0xa<br>          pat uuid-32 0x1101 (SP)<br>          max 40<br>          cont 00<br>&lt; ACL data: handle 6 flags 0x02 dlen 14<br>    L2CAP(d): cid 0x0040 len 10 [psm 1]<br>        SDP SS Rsp: tid 0x1 len 0x5<br>          count 0<br>          cont 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 1<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br>    status 0x00 handle 6 reason 0x08<br>    Reason: Connection Timeout<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>    bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>    bdaddr 00:A0:96:0D:3B:1C role 0x01<br>    Role: Slave<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>&gt; HCI Event: Link Key Request (0x17) plen 6<br>    bdaddr 00:A0:96:0D:3B:1C<br>&lt; HCI Command: Link Key Request Reply
 (0x01|0x000b) plen 22<br>    bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>    Link Key Request Reply (0x01|0x000b) ncmd 1<br>    status 0x00 bdaddr 00:A0:96:0D:3B:1C<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>    status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>    handle 6 policy 0x0f<br>    Link policy: RSWITCH HOLD SNIFF PARK<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>    Write Link Policy Settings (0x02|0x000d) ncmd 1<br>    status 0x00 handle 6<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>    handle 6 ptype 0xcc18<br>    Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1<br>    Error: Command Disallowed<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br> 
   handle 6 slots 5<br>&gt; ACL data: handle 6 flags 0x02 dlen 12<br>    L2CAP(s): Connect req: psm 1 scid 0x0040<br>&lt; ACL data: handle 6 flags 0x02 dlen 16<br>    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>      Connection successful<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 1<br>&gt; ACL data: handle 6 flags 0x02 dlen 16<br>    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>      MTU 48<br>&lt; ACL data: handle 6 flags 0x02 dlen 14<br>    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>      Success<br>&lt; ACL data: handle 6 flags 0x02 dlen 12<br>    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 1<br>&gt; ACL data: handle 6 flags 0x02 dlen 14<br>    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0
 clen 0<br>      Success<br>&gt; ACL data: handle 6 flags 0x02 dlen 17<br>&gt; ACL data: handle 6 flags 0x01 dlen 2<br>    L2CAP(d): cid 0x0040 len 15 [psm 1]<br>        SDP SS Req: tid 0x1 len 0xa<br>          pat uuid-32 0x1101 (SP)<br>          max 40<br>          cont 00<br>&lt; ACL data: handle 6 flags 0x02 dlen 14<br>    L2CAP(d): cid 0x0040 len 10 [psm 1]<br>        SDP SS Rsp: tid 0x1 len 0x5<br>          count 0<br>          cont 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>    handle 6 packets 1<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br>    status 0x00 handle 6 reason 0x08<br>    Reason: Connection Timeout<br>^<br>-------------- next part --------------<br>An HTML attachment was scrubbed...<br>URL: http://sourceforge.net/mailarchive/forum.php?forum=bluez-users/attachments/20060706/75afd491/attachment.html <br><br>------------------------------<br><br>Using Tomcat but need to do more? Need to support web services, security?<br>Get
 stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<br><br>------------------------------<br><br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br><br><br>End of Bluez-users Digest, Vol 3, Issue 6<br>*****************************************<br></be976db60607061016yf4cebb1mda306e5c3912b2bc></bluez-users></mstownsley></salvatorelionetti></blockquote><br><p>&#32;Chiacchiera con i tuoi amici in tempo reale! <br> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
--0-1257268267-1152283540=:6762--


--===============1400218301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1400218301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1400218301==--
