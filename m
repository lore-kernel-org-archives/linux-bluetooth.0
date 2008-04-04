Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2008 00:47:04 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <878714.13630.qm@web50507.mail.re2.yahoo.com>
Subject: [Bluez-users] BlueZ and Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0539277976=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0539277976==
Content-Type: multipart/alternative; boundary="0-1274830340-1207295224=:13630"
Content-Transfer-Encoding: 8bit

--0-1274830340-1207295224=:13630
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I have a Nokia HDW-3 which has been used with btsco successfully before in Fedora 4. Now, it seems I can't somehow pair it.

Here is my hcid.conf file look like:
options {
        # Automatically initialize new devices
        autoinit yes;

        security user;

        pairing multi;

        # Default PIN code for incoming connections
        passkey "BlueZ";
}

hcitool scan or inq can find the headset. And I also have successfully paired with my Motorola Mobile Phone (entering PIN at both Phone and Laptop side) - so I think pairing can be done with the current state of my bluez stack.

The hcidump -X -V always gives me the following results whenever I try to connect with my headset or run some command like, hcitool info <bt-addr of headset> or send direct command like CreateBonding through dbus or even when I switch-on my headset (I wonder why my dongle wants to connect with the headset since I have not saved any information of my headset in the Laptop).

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:03:89:B0:58:91 class 0x200404 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:03:89:B0:58:91 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:B0:58:91
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:03:89:B0:58:91
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:03:89:B0:58:91
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 42 bdaddr 00:03:89:B0:58:91 type ACL encrypt 0x00
    Error: PIN or Key Missing

These are my current bluetooth packages:

rpm -qa | grep bluez*

bluez-utils-3.20-6.fc8
gnome-bluetooth-0.10.0-1.fc8
bluez-libs-3.20-1.fc8
bluez-hcidump-1.40-1.fc8
bluez-utils-cups-3.20-6.fc8
bluez-gnome-0.14-8.fc8
bluez-gnome-analyzer-0.14-8.fc8
pybluez-0.9.2-1.fc7
bluez-utils-alsa-3.20-6.fc8
gnome-bluetooth-libs-0.10.0-1.fc8
bluez-libs-devel-3.20-1.fc8

It would be really helpful if somebody can point me somewhere why the pairing isn't happening.

Thanks
Mahtab

       
---------------------------------
You rock. That's why Blockbuster's offering you one month of Blockbuster Total Access, No Cost.
--0-1274830340-1207295224=:13630
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I have a Nokia HDW-3 which has been used with btsco successfully before in Fedora 4. Now, it seems I can't somehow pair it.<br><br>Here is my hcid.conf file look like:<br>options {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Automatically initialize new devices<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autoinit yes;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security user;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing multi;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default PIN code for incoming connections<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; passkey "BlueZ";<br>}<br><br>hcitool scan or inq can find the headset. And I also have successfully paired with my Motorola Mobile Phone (entering PIN at both Phone and Laptop side) - so I think pairing can be done with the current state of my bluez stack.<br><br>The hcidump -X -V always gives me the following results whenever I try to connect with my headset or run some command
 like, hcitool info &lt;bt-addr of headset&gt; or send direct command like CreateBonding through dbus or even when I switch-on my headset (I wonder why my dongle wants to connect with the headset since I have not saved any information of my headset in the Laptop).<br><br>HCI sniffer - Bluetooth packet analyzer ver 1.40<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:03:89:B0:58:91 class 0x200404 type ACL<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>&nbsp;&nbsp;&nbsp; bdaddr 00:03:89:B0:58:91 role 0x01<br>&nbsp;&nbsp;&nbsp; Role: Slave<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:03:89:B0:58:91<br>&lt; HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr
 00:03:89:B0:58:91<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; Link Key Request Negative Reply (0x01|0x000c) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:03:89:B0:58:91<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x06 handle 42 bdaddr 00:03:89:B0:58:91 type ACL encrypt 0x00<br>&nbsp;&nbsp;&nbsp; Error: PIN or Key Missing<br><br>These are my current bluetooth packages:<br><br>rpm -qa | grep bluez*<br><br>bluez-utils-3.20-6.fc8<br>gnome-bluetooth-0.10.0-1.fc8<br>bluez-libs-3.20-1.fc8<br>bluez-hcidump-1.40-1.fc8<br>bluez-utils-cups-3.20-6.fc8<br>bluez-gnome-0.14-8.fc8<br>bluez-gnome-analyzer-0.14-8.fc8<br>pybluez-0.9.2-1.fc7<br>bluez-utils-alsa-3.20-6.fc8<br>gnome-bluetooth-libs-0.10.0-1.fc8<br>bluez-libs-devel-3.20-1.fc8<br><br>It would be really helpful if somebody can point me somewhere why the pairing isn't happening.<br><br>Thanks<br>Mahtab<br><p>&#32;



      <hr size=1>You rock. That's why Blockbuster's offering you <a href="http://us.rd.yahoo.com/evt=47523/*http://tc.deals.yahoo.com/tc/blockbuster/text5.com">one month of Blockbuster Total Access</a>, No Cost.
--0-1274830340-1207295224=:13630--


--===============0539277976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0539277976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0539277976==--
