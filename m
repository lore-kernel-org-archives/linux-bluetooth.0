Return-Path: <cyrus@holtmann.org>
Subject: Re: Broken SDP parsing?
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
	 <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
	 <1236608040.16880.1580.camel@cookie.hadess.net>
	 <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-x1fnRFd/RQThqHkZwjyc"
Date: Mon, 09 Mar 2009 15:25:18 +0000
Message-Id: <1236612318.16880.1656.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-x1fnRFd/RQThqHkZwjyc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2009-03-09 at 11:32 -0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Mon, Mar 9, 2009 at 11:14 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > Both use the code in common/sdp-xml.[ch] and convert_sdp_record_to_xml()
> > in particular, which is why it makes no sense to me...
> >
> > I double-checked by adding some debug to convert_raw_data_to_xml() and
> > the string for the attribute I'm interested in is empty, so it must be a
> > problem parsing the raw data from the device, or there's something that
> > strips this value somewhere in bluetoothd...
> 
> Then I fear that my code of dumping an sdp record (sdp_copy_record) is
> probably not copying the string correctly.

Problem was sdp_data_alloc() falling back to doing an strlen() on the
string, instead of taking its existing length into account. That would
break any strings with NULLs embedded.

The attached patch fixes this. I'm not certain that making this public
is useful, but feel free to make it so if you feel it's needed.

Cheers

--=-x1fnRFd/RQThqHkZwjyc
Content-Disposition: attachment; filename="bluez-fix-sdp-copy-for-strings-with-nulls.patch"
Content-Type: text/x-patch; name="bluez-fix-sdp-copy-for-strings-with-nulls.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/lib/sdp.c b/lib/sdp.c
index 896c5eb..66e65ca 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -97,6 +97,7 @@ static uint128_t bluetooth_base_uuid = {
 #define SDP_MAX_ATTR_LEN 65535
 
 static sdp_data_t *sdp_copy_seq(sdp_data_t *data);
+static int sdp_attr_add_new_with_length(sdp_record_t *rec, uint16_t attr, uint8_t dtd, const void *value, uint32_t len);
 
 /* Message structure. */
 struct tupla {
@@ -1381,7 +1382,7 @@ static void sdp_copy_pattern(void *value, void *udata)
 	sdp_pattern_add_uuid(rec, uuid);
 }
 
-static void *sdp_data_value(sdp_data_t *data)
+static void *sdp_data_value(sdp_data_t *data, uint32_t *len)
 {
 	void *val = NULL;
 
@@ -1435,6 +1436,8 @@ static void *sdp_data_value(sdp_data_t *data)
 	case SDP_URL_STR32:
 	case SDP_TEXT_STR32:
 		val = data->val.str;
+		if (len)
+			*len = data->unitSize - 1;
 		break;
 	case SDP_ALT8:
 	case SDP_ALT16:
@@ -1457,7 +1460,7 @@ static sdp_data_t *sdp_copy_seq(sdp_data_t *data)
 		sdp_data_t *datatmp;
 		void *value;
 
-		value = sdp_data_value(tmp);
+		value = sdp_data_value(tmp, NULL);
 		datatmp = sdp_data_alloc_with_length(tmp->dtd, value,
 					tmp->unitSize);
 
@@ -1477,10 +1480,14 @@ static void sdp_copy_attrlist(void *value, void *udata)
 	sdp_data_t *data = value;
 	sdp_record_t *rec = udata;
 	void *val;
+	uint32_t len = 0;
 
-	val = sdp_data_value(data);
+	val = sdp_data_value(data, &len);
 
-	sdp_attr_add_new(rec, data->attrId, data->dtd, val);
+	if (!len)
+		sdp_attr_add_new(rec, data->attrId, data->dtd, val);
+	else
+		sdp_attr_add_new_with_length(rec, data->attrId, data->dtd, val, len);
 }
 
 sdp_record_t *sdp_copy_record(sdp_record_t *rec)
@@ -2068,6 +2075,17 @@ int sdp_attr_add_new(sdp_record_t *rec, uint16_t attr, uint8_t dtd,
 	return -1;
 }
 
+static int sdp_attr_add_new_with_length(sdp_record_t *rec, uint16_t attr, uint8_t dtd,
+							const void *value, uint32_t len)
+{
+	sdp_data_t *d = sdp_data_alloc_with_length(dtd, value, len);
+	if (d) {
+		sdp_attr_replace(rec, attr, d);
+		return 0;
+	}
+	return -1;
+}
+
 /*
  * Set the information attributes of the service
  * pointed to by rec. The attributes are

--=-x1fnRFd/RQThqHkZwjyc--

