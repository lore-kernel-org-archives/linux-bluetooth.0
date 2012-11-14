Return-Path: <cyrus@holtmann.org>
Message-id: <50A3B0D5.9030107@samsung.com>
Date: Wed, 14 Nov 2012 15:55:17 +0100
From: Michael Knudsen <m.knudsen@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: CSA2:  User space aspect
References: <509BB56A.80609@samsung.com>
In-reply-to: <509BB56A.80609@samsung.com>
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2012-11-08 14:36, Michael Knudsen wrote:
> If anyone else has an ideas or opinions about this, please speak up,
> otherwise I'll try coming up with an interface specification with
> more details.

This diff shows the direction I'm heading:

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..a565a4d 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -51,6 +51,42 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
+/* Audio format setting */
+#define SCO_HOST_FORMAT	0x04
+#define SCO_AIR_FORMAT	0x05
+
+#define SCO_FORMAT_ULAW		0x00
+#define SCO_FORMAT_ALAW		0x01
+#define SCO_FORMAT_CVSD		0x02
+#define SCO_FORMAT_TRANSPARENT	0x03 
+#define SCO_FORMAT_PCM		0x05 
+#define SCO_FORMAT_MSBC		0x05 
+#define SCO_FORMAT_VENDOR	0xff
+struct sco_format_vendor {
+	__u16 vendor;
+	__u16 codec;
+};
+
+struct sco_format {
+	__u8                     in_format;
+	struct sco_format_vendor in_vendor;
+
+	__u8                     out_format;
+	struct sco_format_vendor out_vendor;
+};
+
+#define SCO_CODECS		0x06
+struct sco_codecs {
+	__u8  count;
+	__u8 *codec;
+};
+
+#define SCO_CODECS_VENDOR	0x07
+struct sco_codecs_vendor {
+	__u8                      count;
+	struct sco_format_vendor *format;
+};
+
 /* ---- SCO connections ---- */
 struct sco_conn {
 	struct hci_conn	*hcon;
@@ -74,6 +110,8 @@ struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
 	struct sco_conn	*conn;
+	struct sco_format host_format;
+	struct sco_format air_format;
 };
 
 #endif /* __SCO_H */

Basically, this adds four socket options (I'll do the audio path
stuff as well once this is done):

	SCO_AIR_FORMAT
	SCO_HOST_FORMAT
	SCO_CODECS (ro)
	SCO_CODECS_VENDOR (ro)

The SCO_CODECS ones provide the application with a list of codecs
supported by the hdev as indicated in the HCI_Read_Local_Supported_Codecs
command response, and if the hdev does not support this command a
default of linear PCM, CVSD, and transparent will be provided.

Because the result length is variable, the idea is that the application-
provided structure is modified by the kernel to hold the actual number
of results so the application can allocate a buffer accordingly, e.g.:

	struct sco_codecs sc;
	
	memset(&sc, 0, sizeof(sc));
	getsockopt(sk, SOL_SCO, SCO_CODECS, &sk);

	sk.codecs = malloc(sk.count);
	getsockopt(sk, SOL_SCO, SCO_CODECS, &sk);

The SCO_*_FORMAT ones allows the application to set the parameters that
are to be used on host-controller and controller-controller paths.  While
the spec requires the pairs (host input/output, air input/output) to be
identical, I don't see a reason to enforce this in the API, thus all are
set independently.

So, before I spend any more time on this.. comments?

-m.
