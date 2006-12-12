Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <24a5055d0612120229g466dfce0rd280111ef8bbfa1c@mail.gmail.com>
Date: Tue, 12 Dec 2006 15:59:50 +0530
From: "Rahul Tank" <tank.rahul@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <457E5CB7.9030000@xmission.com>
MIME-Version: 1.0
References: <20061212040544.28695.qmail@webmail55.rediffmail.com>
	<457E5CB7.9030000@xmission.com>
Subject: Re: [Bluez-devel] No sound in bluetooth headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0336313169=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0336313169==
Content-Type: multipart/alternative;
	boundary="----=_Part_102920_19770830.1165919390210"

------=_Part_102920_19770830.1165919390210
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/12/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Nel
>
> > Hello all,
> >     I am trying the new bluetooth-alsa plugin as mentioned
> > https://help.ubuntu.com/community/BluetoothAudio.
> >
> >   All goes fine but while playing a file via "aplay" i get absolutely no
> > sound output.The previous way of a btsco kernel module worked out of the
> > box.
> > any pointers ???. ..
>
> it may be a limit of your adapter. I improved the docs above with the
> long troubleshooting list.
>
> Brad
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


 I had gone through the troubleshooting list and this is my finding . Plz
help me if i am missing something obvious.

 1. output of hciconfig -a
     hci0:   Type: USB
        BD Address: 00:08:1B:87:DC:CD ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:1076266 acl:110 sco:21037 events:163 errors:0
        TX bytes:51014 acl:75 sco:961 commands:48 errors:0
        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'Mylinux'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver:
0x512
        Manufacturer: Cambridge Silicon Radio (10)

 2.  output of hciconfig hci0 revision
            hci0:   Type: USB
        BD Address: 00:08:1B:87:DC:CD ACL MTU: 192:8 SCO MTU: 64:8
        HCI 18.2
        Chip version: BlueCore3-ROM
        Max key size: 128 bit
        SCO mapping:  HCI

3. output of hcitool info 00:07:a4:5c:64:f0
  Requesting information ...
        BD Address:  00:07:a4:5c:64:f0
        Device Name: Motorola HS850
        LMP Version: 1.2 (0x2) LMP Subversion: 0x5dd
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x8b 0xf8 0x18 0x18 0x00 0x80
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law
log>
                <CVSD> <paging scheme> <transparent SCO> <broadcast encrypt>

                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <extended SCO> <AFH cap. slave>
                <AFH class. slave> <AFH cap. master> <AFH class. master>
                <extended features>

4. kernel version ; 2.6.17
    bluez-utils and bluez-libs:  3.7


The fact that the btsco kernel module worked perfectly well is confusing me
more..

Any pointers ??

thanks in advance

 cheers,
   Nel.

------=_Part_102920_19770830.1165919390210
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 12/12/06, <b class="gmail_sendername">Brad Midgley</b> &lt;<a href="mailto:bmidgley@xmission.com">bmidgley@xmission.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Nel<br><br>&gt; Hello all,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I am trying the new bluetooth-alsa plugin as mentioned<br>&gt; <a href="https://help.ubuntu.com/community/BluetoothAudio">https://help.ubuntu.com/community/BluetoothAudio</a>.<br>&gt;
<br>&gt;&nbsp;&nbsp; All goes fine but while playing a file via &quot;aplay&quot; i get absolutely no<br>&gt; sound output.The previous way of a btsco kernel module worked out of the<br>&gt; box.<br>&gt; any pointers ???. ..<br><br>
it may be a limit of your adapter. I improved the docs above with the<br>long troubleshooting list.<br><br>Brad<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT
<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br>&nbsp;I had gone through the troubleshooting list and this is my finding . Plz help me if i am missing something obvious.
<br><br>&nbsp;1. output of hciconfig -a<br>&nbsp;&nbsp;&nbsp;&nbsp; hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:08:1B:87:DC:CD ACL MTU: 192:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN AUTH ENCRYPT <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1076266 acl:110 sco:21037 events:163 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:51014 acl:75 sco:961 commands:48 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: ACCEPT MASTER <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Mylinux'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver: 0x512<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br><br>&nbsp;2.&nbsp; output of hciconfig hci0 revision<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:08:1B:87:DC:CD ACL MTU: 192:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI 18.2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore3-ROM<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 128 bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br><br>3. output of hcitool info 00:07:a4:5c:64:f0<br>&nbsp; Requesting information ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:07:a4:5c:64:f0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: Motorola HS850<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.2 (0x2) LMP Subversion: 0x5dd<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xfc 0xff 0x8b 0xf8 0x18 0x18 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing accuracy&gt; &lt;role switch&gt; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;hold mode&gt; &lt;sniff mode&gt; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;SCO link&gt; &lt;HV2 packets&gt; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CVSD&gt; &lt;paging scheme&gt; &lt;transparent SCO&gt; &lt;broadcast encrypt&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt; &lt;interlaced pscan&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;inquiry with RSSI&gt; &lt;extended SCO&gt; &lt;AFH cap. slave&gt; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH class. slave&gt; &lt;AFH cap. master&gt; &lt;AFH class. master&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;extended features&gt; <br><br>4. kernel version ; 2.6.17<br>&nbsp;&nbsp;&nbsp; bluez-utils and bluez-libs:&nbsp; 3.7 <br><br>
<br>The fact that the btsco kernel module worked perfectly well is confusing me more..<br><br>Any pointers ??<br><br>thanks in advance<br>&nbsp;<br>&nbsp;cheers,<br>&nbsp;&nbsp; Nel.<br><br><br>

------=_Part_102920_19770830.1165919390210--


--===============0336313169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0336313169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0336313169==--
