Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] TPL is not changing
Message-ID: <20050131015929.GC30604@snoopy.src.ricoh.co.jp>
References: <20050130174730.3a78367f.j0006@stu.matsue-ct.jp> <1107095863.24890.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1107095863.24890.0.camel@pegasus>
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
Date: Mon, 31 Jan 2005 10:59:29 +0900

Hi All,

the HAGIWARE SYS-COM card is a pretty old Ericsson based card and it
doesn't support TPL. See the output of hciconfig:

hci0:   Type: PCCARD
        BD Address: 00:90:02:05:1D:56 ACL MTU: 672:8 SCO MTU: 64:0
        Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD>

Alain

* Marcel Holtmann [Sun, 30 Jan 2005 at 15:37 +0100]
<quote>
> Hi Kazuhiro,
> 
> > I've installed bluez-libs-2.8-1 and bluez-utils-2.8-1 on our linux 2.4.27 systems with 
> > HAGIWARA SYS-COM HNT-CFBT Bluetooth cards.
> > 
> > I measured TPL on one computer and found that it was always 0 independently of the  
> > distance between devices.
> > 
> > The following is the result of actual measurement.
> > 
> > [root@localhost root]# hcitool cc 00:90:02:XX:XX:XX
> > [root@localhost root]# hcitool tpl 00:90:02:XX:XX:XX
> > Current transmit power level: 0
> > [root@localhost root]# hcitool rssi 00:90:02:XX:XX:XX
> > RSSI return value: -3
> > [root@localhost root]# hcitool tpl 00:90:02:XX:XX:XX
> > Current transmit power level: 0
> > [root@localhost root]# hcitool rssi 00:90:02:XX:XX:XX
> > RSSI return value: -13
> > [root@localhost root]# hcitool dc 00:90:02:XX:XX:XX
> > 
> > As you can see, RSSI is changing according to the distance between devices, but 
> > TPL is not.
> > 
> > I would like to know the reason of this phenomenon.
> 
> this is maybe, because your card doesn't support it. What does
> "hciconfig -a" say?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
</quote>


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
