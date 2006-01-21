Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060121021216.99807.qmail@web32005.mail.mud.yahoo.com>
From: Dani Camps <danicamps81@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1606280551-1137809536=:98552"
Subject: [Bluez-users] Problems trying to load the snd_bt_sco module
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
Date: Fri, 20 Jan 2006 18:12:16 -0800 (PST)

--0-1606280551-1137809536=:98552
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 Hi all, 
 
 I have a Fedora Core 3 box with kernel 2.6.12-1.1372. I have a Logitech bluetooth headset and for my Linux box a USB dongle with a bluetooth chipset from Broadcom Corp.
 
 The bluetooth dongle is working fine and I can see my Logitech headset with hcitool scan. I have compiled the btsco driver in order to use the headset, but the problem comes when I try to insert the snd_bt_sco in the kernel, by doing:
 -----------------------------------------------------------------------------------------------------------------
 #modprobe snd_bt_sco
 FATAL: Error inserting snd_bt_sco (/lib/modules/2.6.12-1.1372_FC3/extra/snd-bt-sco.ko): Unknown symbol in module, or unknown parameter (see dmesg)
 -----------------------------------------------------------------------------------------------------------------
 This is the output from dmesg:
 -----------------------------------------------------------------------------------------------------------------
 snd_bt_sco: disagrees about version of symbol snd_pcm_new
 snd_bt_sco: Unknown symbol snd_pcm_new
 snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl
 snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl
 snd_bt_sco: disagrees about version of symbol snd_hwdep_new
 snd_bt_sco: Unknown symbol snd_hwdep_new
 snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops
 snd_bt_sco: Unknown symbol snd_pcm_set_ops
 snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed
 snd_bt_sco: Unknown symbol snd_pcm_period_elapsed
 snd_bt_sco: disagrees about version of symbol snd_pcm_new
 snd_bt_sco: Unknown symbol snd_pcm_new
 snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl
 snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl
 snd_bt_sco: disagrees about version of symbol snd_hwdep_new
 snd_bt_sco: Unknown symbol snd_hwdep_new
 snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops
 snd_bt_sco: Unknown symbol snd_pcm_set_ops
 snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed
 snd_bt_sco: Unknown symbol snd_pcm_period_elapsed
 -----------------------------------------------------------------------------------------------------------------
 More output information that can be useful:
 -----------------------------------------------------------------------------------------------------------------
 #hciconfig -a
 hci0:   Type: USB
         BD Address: 00:80:5A:40:9E:72 ACL MTU: 377:10  SCO MTU: 16:0
         UP RUNNING PSCAN ISCAN
         RX bytes:1114 acl:6 sco:0 events:48 errors:0
         TX bytes:485 acl:6 sco:0 commands:23 errors:0
         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'dani-laptop-0'
         Class: 0x000000
         Service Classes: Unspecified
         Device Class: Miscellaneous,
         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
         Manufacturer: Broadcom Corporation (15)
 -------------------------------------------------------------------------------------------------------------
 #hciconfig hci0 revision
 hci0:   Type: USB
         BD Address: 00:80:5A:40:9E:72 ACL MTU: 377:10  SCO MTU: 16:0
         Firmware 0.3.009
 -------------------------------------------------------------------------------------------------------------
 #hcitool info 00:0D:44:0C:11:4A (headset's address)
 Requesting information ...
         BD Address:  00:0D:44:0C:11:4A
         Device Name: Logitech HS01-V16
         LMP Version: 1.2 (0x2) LMP Subversion: 0x611
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                 <paging scheme> <power control> <transparent SCO>
                 <AFH cap. slave> <AFH cap. master>
 -------------------------------------------------------------------------------------------------------------------
 # btsco -v
 btsco v0.4c
 Error: control open (hw:2): No such file or directory
 Error: Can't find device. Bail
 ---------------------------------------------------------------------------------------------------------------------
 
 Any idea about what is wrong ? Maybe my USB dongle does not work with the btsco driver ?
 
 Thanks in advance
 
 Dani Camps
 
 




 
 

		
---------------------------------
 
 What are the most popular cars?  Find out at Yahoo! Autos
--0-1606280551-1137809536=:98552
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">&nbsp;Hi all, <br> <br> I have a Fedora Core 3 box with kernel 2.6.12-1.1372. I have a Logitech bluetooth headset and for my Linux box a USB dongle with a bluetooth chipset from Broadcom Corp.<br> <br> The bluetooth dongle is working fine and I can see my Logitech headset with hcitool scan. I have compiled the btsco driver in order to use the headset, but the problem comes when I try to insert the snd_bt_sco in the kernel, by doing:<br> -----------------------------------------------------------------------------------------------------------------<br> #modprobe snd_bt_sco<span style="font-family: monospace;"><br> </span>FATAL: Error inserting snd_bt_sco (/lib/modules/2.6.12-1.1372_FC3/extra/snd-bt-sco.ko): Unknown symbol in module, or unknown parameter (see dmesg)<br> -----------------------------------------------------------------------------------------------------------------<br> This is the output from dmesg:<br>
 -----------------------------------------------------------------------------------------------------------------<br> snd_bt_sco: disagrees about version of symbol snd_pcm_new<br> snd_bt_sco: Unknown symbol snd_pcm_new<br> snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl<br> snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl<br> snd_bt_sco: disagrees about version of symbol snd_hwdep_new<br> snd_bt_sco: Unknown symbol snd_hwdep_new<br> snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops<br> snd_bt_sco: Unknown symbol snd_pcm_set_ops<br> snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed<br> snd_bt_sco: Unknown symbol snd_pcm_period_elapsed<br> snd_bt_sco: disagrees about version of symbol snd_pcm_new<br> snd_bt_sco: Unknown symbol snd_pcm_new<br> snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl<br> snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl<br> snd_bt_sco: disagrees about version of symbol snd_hwdep_new<br> snd_bt_sco: Un
 known
 symbol snd_hwdep_new<br> snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops<br> snd_bt_sco: Unknown symbol snd_pcm_set_ops<br> snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed<br> snd_bt_sco: Unknown symbol snd_pcm_period_elapsed<br> -----------------------------------------------------------------------------------------------------------------<br> More output information that can be useful:<br> -----------------------------------------------------------------------------------------------------------------<br> #hciconfig -a<br> hci0:&nbsp;&nbsp; Type: USB<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:5A:40:9E:72 ACL MTU: 377:10&nbsp; SCO MTU: 16:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1114 acl:6 sco:0 events:48 errors:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:485 acl:6 sco:0 commands:23 errors:0<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'dani-laptop-0'<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000000<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Miscellaneous,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporation (15)<br> -------------------------------------------------------------------------------------------------------------<br> #hciconfig hci0 revision<br> hci0:&nbsp;
 &nbsp;
 Type: USB<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:5A:40:9E:72 ACL MTU: 377:10&nbsp; SCO MTU: 16:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Firmware 0.3.009<br> -------------------------------------------------------------------------------------------------------------<br> #hcitool info 00:0D:44:0C:11:4A (headset's address)<br> Requesting information ...<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0D:44:0C:11:4A<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: Logitech HS01-V16<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.2 (0x2) LMP Subversion: 0x611<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing accuracy&gt; &lt
 ;role
 switch&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;hold mode&gt; &lt;sniff mode&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV2 packets&gt; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;paging scheme&gt; &lt;power control&gt; &lt;transparent SCO&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. slave&gt; &lt;AFH cap. master&gt;<br> -------------------------------------------------------------------------------------------------------------------<br> # btsco -v<br> btsco v0.4c<br> Error: control open (hw:2): No such file or directory<br> Error: Can't find device. Bail<br>
 ---------------------------------------------------------------------------------------------------------------------<br> <br> Any idea about what is wrong ? Maybe my USB dongle does not work with the btsco driver ?<br> <br> Thanks in advance<br> <br> Dani Camps<br> <br> <pre><br><br><br></pre> <br> </div><p>
		<hr size=1> <BR> 
What are the most popular cars?  Find out at <a href="http://us.rd.yahoo.com/evt=38382/_ylc=X3oDMTEzNWFva2Y2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDMmF1dG9z/*http://autos.yahoo.com/newcars/popular/thisweek.html 
">Yahoo! Autos</a>

--0-1606280551-1137809536=:98552--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
