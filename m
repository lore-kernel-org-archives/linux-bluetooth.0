Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c669a7c70708292333n60a7e87wa20840012cd444c@mail.gmail.com>
Date: Thu, 30 Aug 2007 12:03:35 +0530
From: "Mahin Gupta" <mahingupta@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c669a7c70708290023ia617125rda5bc9e7547fe9f6@mail.gmail.com>
MIME-Version: 1.0
References: <c669a7c70708290023ia617125rda5bc9e7547fe9f6@mail.gmail.com>
Subject: Re: [Bluez-users] hcidump output problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1954120704=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1954120704==
Content-Type: multipart/alternative;
	boundary="----=_Part_4083_18471633.1188455615908"

------=_Part_4083_18471633.1188455615908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Hi Mahin,
>
> > I am using bluez-libs 3.14, bluez-utils 3.14, hcidump 1.40 ..
> > when I am using hcidump -V -X I am continuously getting following
> > output..
> >
> > > SCO data: handle 92 flags 0x00 dlen 48
> >     0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
> > 00  ................
> >     0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
> > 00  ................
> >     0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
> > 00  ................
> >  It gives nothing else ...
> >
> >
> >  below is output of my hciconfig hci0 -a
> >  [root <at> vmware-fc6 bluez-hcidump-1.40]# hciconfig hci0 -a
> > hci0:   Type: USB
> >         BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:387498 acl:0 sco:7357 events:9 errors:0
> >         TX bytes:34 acl:0 sco:0 commands:9 errors:0
> >         Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >         Link policy:
> >         Link mode: SLAVE ACCEPT
> >         Name: ''
> >         Class: 0x000104
> >         Service Classes: Unspecified
> >         Device Class: Computer, Desktop workstation
> >         HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP
> > Subver: 0x1f4
> >         Manufacturer: CONWISE Technology Corporation Ltd (66)
>
> another broken dongle. What brand is it. It seems I need one of these
> for testing at home.
>
> Regards
>
> Marcel

It is of billionton
 On the back side of it : P/N:USBBTC1A-B
                                 S/N:05022500457
 so I think my most of the problems are due to this broken dongle.
 Should I change this ?
 Can u recommend one ?

 Regards,
 Mahin Gupta

------=_Part_4083_18471633.1188455615908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span>&gt; Hi Mahin,<br>&gt; <br>&gt; &gt; I am using bluez-libs 3.14, bluez-utils 3.14, hcidump 1.40 ..<br>&gt; &gt; when I am using hcidump -V -X I am continuously getting following<br>&gt; &gt; output..
<br>&gt; &gt; <br>&gt; &gt; &gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00<br>&gt; &gt; 00&nbsp; ................ <br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00
<br>&gt; &gt; 00&nbsp; ................<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00<br>&gt; &gt; 00&nbsp; ................<br>&gt; &gt;&nbsp; It gives nothing else ...<br>&gt; &gt; <br>&gt; &gt; &nbsp;<br>&gt; &gt;&nbsp; below is output of my hciconfig hci0 -a 
<br>&gt; &gt;&nbsp; [root &lt;at&gt; vmware-fc6 bluez-hcidump-1.40]# hciconfig hci0 -a<br>&gt; &gt; hci0:&nbsp;&nbsp; Type: USB<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:387498 acl:0 sco:7357 events:9 errors:0 <br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:34 acl:0 sco:0 commands:9 errors:0<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT <br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: &#39;&#39;<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000104<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Desktop workstation
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP<br>&gt; &gt; Subver: 0x1f4 <br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: CONWISE Technology Corporation Ltd (66)<br>&gt; <br>&gt; another broken dongle. What brand is it. It seems I need one of these
<br>&gt; for testing at home.<br>&gt; <br>&gt; Regards<br>&gt; <br>&gt; Marcel<br>&nbsp;<br>It is of billionton<br>&nbsp;On the back side of it : P/N:USBBTC1A-B<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S/N:05022500457<br>&nbsp;so I think my most of the problems are due to this broken dongle.
<br>&nbsp;Should I change this ?<br>&nbsp;Can u recommend one ?<br>&nbsp;<br>&nbsp;Regards,<br>&nbsp;Mahin Gupta<br><br><br>&nbsp;

------=_Part_4083_18471633.1188455615908--


--===============1954120704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1954120704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1954120704==--
