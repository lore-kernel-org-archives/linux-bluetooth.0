Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] Performance optimizations for sbcenc utility
Date: Mon, 19 Jan 2009 13:05:36 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901161812.45754.siarhei.siamashka@nokia.com> <1232291744.5095.14.camel@californication>
In-Reply-To: <1232291744.5095.14.camel@californication>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A6FdJDf8l9D/fX0"
Message-Id: <200901191305.36942.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_A6FdJDf8l9D/fX0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 18 January 2009 17:15:44 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > The attached patch improves performance of sbcenc utility. This is not
> > very useful in general and does not improve the SBC codec itself. But
> > when using sbcenc utility for benchmarking, an extra unneeded overhead
> > skews the results a bit and this might be worth fixing.
> >
> > Before patch:
> >
> > real    0m14.984s
> > user    0m12.981s
> > sys     0m1.924s
> >
> > After patch:
> >
> > real    0m12.279s
> > user    0m11.865s
> > sys     0m0.360s
> >
> >
> > Christian, you fixed some bugs in sbcenc a bit earlier. Could you please
> > also check if all your testcases also work fine with this new patch
> > applied and it does not break anything?
>
> patch has been applied to make testing easier. Send fixes if it breaks
> something.

Well, appears that it really broke something. I forgot to update the part of
code which handled non 24 byte headers. A fix is attached. Now it should
work fine in all cases.


Best regards,
Siarhei Siamashka

--Boundary-00=_A6FdJDf8l9D/fX0
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-Fix-for-sbcenc-breakage-when-au-file-header-size-is.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Fix-for-sbcenc-breakage-when-au-file-header-size-is.patch"

>From 3ad8e7024ad599572673ba0aee883cab12c0262c Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Date: Sun, 18 Jan 2009 23:10:00 +0200
Subject: [PATCH] Fix for sbcenc breakage when au file header size is larger than 24 bytes

---
 sbc/sbcenc.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index 388be2a..fba9be3 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -48,7 +48,13 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 {
 	struct au_header au_hdr;
 	sbc_t sbc;
-	int fd, len, size, count, encoded, srate, codesize, nframes;
+	int fd, len, size, encoded, srate, codesize, nframes;
+
+	if (sizeof(au_hdr) != 24) {
+		/* Sanity check just in case */
+		fprintf(stderr, "FIXME: sizeof(au_hdr) != 24\n");
+		return;
+	}
 
 	if (strcmp(filename, "-")) {
 		fd = open(filename, O_RDONLY);
@@ -72,7 +78,7 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 
 	if (au_hdr.magic != AU_MAGIC ||
 			BE_INT(au_hdr.hdr_size) > 128 ||
-			BE_INT(au_hdr.hdr_size) < 24 ||
+			BE_INT(au_hdr.hdr_size) < sizeof(au_hdr) ||
 			BE_INT(au_hdr.encoding) != AU_FMT_LIN16) {
 		fprintf(stderr, "Not in Sun/NeXT audio S16_BE format\n");
 		goto done;
@@ -119,9 +125,9 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 	}
 
 	sbc.endian = SBC_BE;
-	count = BE_INT(au_hdr.data_size);
-	size = len - BE_INT(au_hdr.hdr_size);
-	memmove(input, input + BE_INT(au_hdr.hdr_size), size);
+	/* Skip extra bytes of the header if any */
+	if (read(fd, input, BE_INT(au_hdr.hdr_size) - len) < 0)
+		goto done;
 
 	sbc.bitpool = bitpool;
 	sbc.allocation = snr ? SBC_AM_SNR : SBC_AM_LOUDNESS;
@@ -177,8 +183,12 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 			perror("Can't write SBC output");
 			break;
 		}
-		if (size >= codesize) {
-			/* sbc_encode failure has been detected earlier */
+		if (size != 0) {
+			/*
+			 * sbc_encode failure has been detected earlier or end
+			 * of file reached (have trailing partial data which is
+			 * insufficient to encode SBC frame)
+			 */
 			break;
 		}
 	}
-- 
1.5.6.5


--Boundary-00=_A6FdJDf8l9D/fX0--
