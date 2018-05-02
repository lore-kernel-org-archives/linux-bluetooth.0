Return-Path: <bp.sharmila@globaledgesoft.com>
Date: Wed, 2 May 2018 08:09:00 +0530 (IST)
From: Sharmila Prabhu Baila <bp.sharmila@globaledgesoft.com>
To: linux-bluetooth-owner@vger.kernel.org
Cc: jwboyer@kernel.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	brian gix <brian.gix@intel.com>
Message-ID: <568444639.5622951.1525228740086.JavaMail.zimbra@globaledgesoft.com>
Subject: Issue with Discovery Start
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5622950_377166448.1525228740085"
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_5622950_377166448.1525228740085
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

I faced issue during discovery start in both bluez-5.41 and 5.49. Please find the attached logs and help me to resolve this issue. 


bluetoothd[846]: src/adapter.c:stop_discovery() sender :1.2 
bluetoothd[846]: src/adapter.c:discovery_destroy() owner :1.2 
bluetoothd[846]: src/device.c:device_set_rssi_with_delta() rssi 0 
bluetoothd[846]: src/device.c:device_set_tx_power() tx_power 127 
bluetoothd[846]: src/device.c:device_set_rssi_with_delta() rssi 0 
bluetoothd[846]: src/adapter.c:stop_discovery_complete() status 0x0a 
bluetoothd[846]: src/adapter.c:remove_temp_devices() /org/bluez/hci0 
bluetoothd[846]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_00_EC_0A_0F_3A_B2 
bluetoothd[846]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_00_EC_0A_0F_3A_B2 
bluetoothd[846]: src/device.c:device_free() 0x17cd570 
bluetoothd[846]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_0C_E0_E4_3F_C4_18 
bluetoothd[846]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_0C_E0_E4_3F_C4_18 
bluetoothd[846]: src/device.c:device_free() 0x17cec18 
bluetoothd[846]: src/adapter.c:start_discovery() sender :1.2 
bluetoothd[846]: src/adapter.c:update_discovery_filter() 
bluetoothd[846]: src/adapter.c:discovery_filter_to_mgmt_cp() 


>>>>>>>>> Scanning failed >>>>>>>>>>>> 


bluetoothd[846]: src/adapter.c:update_discovery_filter() filters were equal, deciding to not restart the scan. 

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 

bluetoothd[846]: src/adapter.c:start_discovery() sender :1.2 
bluetoothd[846]: src/adapter.c:stop_discovery() sender :1.2 
bluetoothd[846]: src/adapter.c:discovery_destroy() owner :1.2 
bluetoothd[846]: src/adapter.c:stop_discovery_complete() status 0x0b 
bluetoothd[846]: src/adapter.c:start_discovery() sender :1.2 
bluetoothd[846]: src/adapter.c:update_discovery_filter() 
bluetoothd[846]: src/adapter.c:discovery_filter_to_mgmt_cp() 
bluetoothd[846]: src/adapter.c:update_discovery_filter() filters were equal, deciding to not restart the scan. 
bluetoothd[846]: src/adapter.c:stop_discovery() sender :1.2 
bluetoothd[846]: src/adapter.c:discovery_destroy() owner :1.2 
bluetoothd[846]: src/adapter.c:stop_discovery_complete() status 0x0b 


Waiting for response. 

-- 
Regards, 
Sharmila Prabhu 

Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.
------=_Part_5622950_377166448.1525228740085
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div style=3D"" data-mce-style=3D""><div style=
=3D"font-family: arial,helvetica,sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" data-mce-style=3D"font-family: arial,helvetica,sans-serif; font-si=
ze: 12pt; color: #000000;"><div style=3D"" data-mce-style=3D""><div style=
=3D"" data-mce-style=3D""><div style=3D"font-family: arial,helvetica,sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);" data-mce-style=3D"font-family:=
 arial,helvetica,sans-serif; font-size: 12pt; color: #000000;"><div style=
=3D"" data-mce-style=3D""><div style=3D"" data-mce-style=3D""><div style=3D=
"" id=3D":25h" class=3D"ii gt " data-mce-style=3D""><div style=3D"" id=3D":=
25g" class=3D"a3s aXjCH m1630fff232629fdd" data-mce-style=3D""><div style=
=3D"" dir=3D"ltr" data-mce-style=3D""><div style=3D"" data-mce-style=3D""><=
div style=3D"" data-mce-style=3D"">Hi,<br style=3D"" data-mce-style=3D""><b=
r style=3D"" data-mce-style=3D""></div><div style=3D"" data-mce-style=3D"">=
I faced issue during discovery start in both bluez-5.41 and 5.49. Please fi=
nd the attached logs and help me to resolve this issue.<br style=3D"" data-=
mce-style=3D""><br style=3D"" data-mce-style=3D""></div><div style=3D"" dat=
a-mce-style=3D""><br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/ad=
apter.c:stop_discovery() sender :1.2<br style=3D"" data-mce-style=3D"">blue=
toothd[846]: src/adapter.c:discovery_destroy() owner :1.2<br style=3D"" dat=
a-mce-style=3D"">bluetoothd[846]: src/device.c:device_set_rssi_with_delta()=
 rssi 0<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/device.c:dev=
ice_set_tx_power() tx_power 127<br style=3D"" data-mce-style=3D"">bluetooth=
d[846]: src/device.c:device_set_rssi_with_delta() rssi 0<br style=3D"" data=
-mce-style=3D"">bluetoothd[846]: src/adapter.c:stop_discovery_complete() st=
atus 0x0a<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter.c:=
remove_temp_devices() /org/bluez/hci0<br style=3D"" data-mce-style=3D"">blu=
etoothd[846]: src/device.c:device_remove() Removing device /org/bluez/hci0/=
dev_00_EC_0A_0F_3A_B2<br style=3D"" data-mce-style=3D"">bluetoothd[846]: sr=
c/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_00_EC_0A_0=
F_3A_B2<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/device.c:dev=
ice_free() 0x17cd570<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src=
/device.c:device_remove() Removing device /org/bluez/hci0/dev_0C_E0_E4_3F_C=
4_18<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/device.c:btd_de=
vice_unref() Freeing device /org/bluez/hci0/dev_0C_E0_E4_3F_C4_18<br style=
=3D"" data-mce-style=3D"">bluetoothd[846]: src/device.c:device_free() 0x17c=
ec18<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter.c:start=
_discovery() sender :1.2<br style=3D"" data-mce-style=3D"">bluetoothd[846]:=
 src/adapter.c:update_discovery_filter() <br style=3D"" data-mce-style=3D""=
>bluetoothd[846]: src/adapter.c:discovery_filter_to_mgmt_cp() <br style=3D"=
" data-mce-style=3D""><br style=3D"" data-mce-style=3D""><br style=3D"" dat=
a-mce-style=3D""></div><div style=3D"" data-mce-style=3D"">&gt;&gt;&gt;&gt;=
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; Scanning failed &gt;&gt;&gt;&gt;&gt;&gt;&g=
t;&gt;&gt;&gt;&gt;&gt;<br style=3D"" data-mce-style=3D""><br style=3D"" dat=
a-mce-style=3D""><br style=3D"" data-mce-style=3D""></div><div style=3D"" d=
ata-mce-style=3D"">bluetoothd[846]: src/adapter.c:update_discovery_filter()=
 filters were equal, deciding to not restart the scan.<br style=3D"" data-m=
ce-style=3D""><br style=3D"" data-mce-style=3D"">&gt;&gt;&gt;&gt;&gt;&gt;&g=
t;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&=
gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br style=3D"" data-mce-style=3D""><=
br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter.c:start_disc=
overy() sender :1.2<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/=
adapter.c:stop_discovery() sender :1.2<br style=3D"" data-mce-style=3D"">bl=
uetoothd[846]: src/adapter.c:discovery_destroy() owner :1.2<br style=3D"" d=
ata-mce-style=3D"">bluetoothd[846]: src/adapter.c:stop_discovery_complete()=
 status 0x0b<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter=
.c:start_discovery() sender :1.2<br style=3D"" data-mce-style=3D"">bluetoot=
hd[846]: src/adapter.c:update_discovery_filter() <br style=3D"" data-mce-st=
yle=3D"">bluetoothd[846]: src/adapter.c:discovery_filter_to_mgmt_cp() <br s=
tyle=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter.c:update_discove=
ry_filter() filters were equal, deciding to not restart the scan.<br style=
=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter.c:stop_discovery() s=
ender :1.2<br style=3D"" data-mce-style=3D"">bluetoothd[846]: src/adapter.c=
:discovery_destroy() owner :1.2<br style=3D"" data-mce-style=3D"">bluetooth=
d[846]: src/adapter.c:stop_discovery_complete() status 0x0b<br style=3D"" d=
ata-mce-style=3D""><br style=3D"" data-mce-style=3D""><br style=3D"" data-m=
ce-style=3D"">Waiting for response.</div></div></div></div></div></div><br =
style=3D"" data-mce-style=3D""><div style=3D"" data-mce-style=3D"">-- <br s=
tyle=3D"" data-mce-style=3D""></div><div style=3D"" data-mce-style=3D"">Reg=
ards,<br style=3D"" data-mce-style=3D"">Sharmila Prabhu</div></div></div></=
div></div></div></div></div>
<br>=
<html><body>Disclaimer:This message is intended only for the designated recipient(s). It may contain confidential or proprietary information and may be subject to other confidentiality protections. If you are not a designated recipient, you may not review, copy or distribute this message. Please notify the sender by e-mail and delete this message. GlobalEdge does not accept any liability for virus infected mails. </body></html>=0A
<br>=
</body></html>
------=_Part_5622950_377166448.1525228740085--
