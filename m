Return-Path: <cyrus@holtmann.org>
Subject: Broken SDP parsing?
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-PpTfYHKP7ItvGLsw8VFi"
Date: Fri, 06 Mar 2009 01:00:26 +0000
Message-Id: <1236301226.3602.2314.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-PpTfYHKP7ItvGLsw8VFi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

In bluez 3.x, I used to get something like that:
	<attribute id="0x0300">
 		<text value="MFG:HP;MDL:Photosmart 380
series_BT;CMD:PCL,DW-PCL,DESKJET,DYN;CLS:PRINTER;DES:385;" />
	</attribute>

Now I get:
<attribute id="0x0300">
      <text value="" />
</attribute>

$ sdptool search --raw --bdaddr 00:0C:55:5E:07:E1 HCRP
	Attribute 0x0300
		Data 00 55 4d 46 47 3a 48 50 3b 4d 44 4c 3a 50 68 6f 74 6f 73 6d 61 72
74 20 33 38 30 20 73 65 72 69 65 73 5f 42 54 3b 43 4d 44 3a 50 43 4c 2c
44 57 2d 50 43 4c 2c 44 45 53 4b 4a 45 54 2c 44 59 4e 3b 43 4c 53 3a 50
52 49 4e 54 45 52 3b 44 45 53 3a 33 38 35 3b 00

With the attached patch:
	<attribute id="0x0300">
		<text value="&#00;UMFG:HP;MDL:Photosmart 380
series_BT;CMD:PCL,DW-PCL,DESKJET,DYN;CLS:PRINTER;DES:385;" />
	</attribute>

The first 2 chars in the IEEE1284 ID are supposed to be the length of
the string. This should enable me to make the CUPS backend's discovery
work again.

Cheers

--=-PpTfYHKP7ItvGLsw8VFi
Content-Disposition: attachment; filename="bluez-sdp-xml-with-nulls.patch"
Content-Type: text/x-patch; name="bluez-sdp-xml-with-nulls.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/common/sdp-xml.c b/common/sdp-xml.c
index 0403dcd..5f314b7 100644
--- a/common/sdp-xml.c
+++ b/common/sdp-xml.c
@@ -239,9 +239,7 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		hex = 0;
 
 		for (i = 0; i < length; i++) {
-			if (value->val.str[i] == '\0')
-				break;
-			if (!isprint(value->val.str[i])) {
+			if (!isprint(value->val.str[i]) && value->val.str[i] != '\0') {
 				hex = 1;
 				break;
 			}
@@ -250,7 +248,8 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 			if ((value->val.str[i] == '<') ||
 					(value->val.str[i] == '>') ||
 					(value->val.str[i] == '"') ||
-					(value->val.str[i] == '&'))
+					(value->val.str[i] == '&') ||
+					(value->val.str[i] == '\0'))
 				num_chars_to_escape++;
 		}
 
@@ -304,7 +303,13 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 					strBuf[j++] = 'o';
 					strBuf[j++] = 't';
 				}
-				else {
+				else if (value->val.str[i] == '\0') {
+					strBuf[j++] = '&';
+					strBuf[j++] = '#';
+					strBuf[j++] = '0';
+					strBuf[j++] = '0';
+					strBuf[j++] = ';';
+				} else {
 					strBuf[j++] = value->val.str[i];
 				}
 			}

--=-PpTfYHKP7ItvGLsw8VFi--

