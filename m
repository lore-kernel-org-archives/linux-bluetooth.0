Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 16 Feb 2011 14:12:59 +0100
Message-ID: <AANLkTimfR_dhOE-k5c3zJ1+dwMwOCBqq-Y6Df-=rp8FP@mail.gmail.com>
Subject: PATCH [2/2] batostr(): Replace batostr() where possible with ba2str
 to avoid memleaks
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0015175cdda842f7a5049c660a7d
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0015175cdda842f7a5049c660a7d
Content-Type: text/plain; charset=ISO-8859-1

batostr() returns a dynamically allocated string which must be freed
later, although, the function looks like the standard berkeley socket
functions that work on static buffers. Two functions inside bluez
incorrectly use batostr() and do not free the returned pointer. I
replaced the occurrence of batostr() with a ba2str().

This makes batostr() unused throughout whole bluez so it may be
removed. However, I don't know whether we should keep it to keep
backwards compatibility.

Patch is against most recent git plus PATCH [1/2]. Patch file is also
attached as x-patch file.

David

diff --git a/compat/bnep.c b/compat/bnep.c
index 9b0d8b8..3617e0e 100644
--- a/compat/bnep.c
+++ b/compat/bnep.c
@@ -128,6 +128,7 @@ int bnep_show_connections(void)
 	struct bnep_connlist_req req;
 	struct bnep_conninfo ci[48];
 	unsigned int i;
+	char buf[18];

 	req.cnum = 48;
 	req.ci   = ci;
@@ -137,9 +138,9 @@ int bnep_show_connections(void)
 	}

 	for (i = 0; i < req.cnum; i++) {
+		ba2str((bdaddr_t*)ci[i].dst, buf);
 		printf("%s %s %s\n", ci[i].device,
-			batostr((bdaddr_t *) ci[i].dst),
-			bnep_svc2str(ci[i].role));
+			buf, bnep_svc2str(ci[i].role));
 	}
 	return 0;
 }
diff --git a/test/hciemu.c b/test/hciemu.c
index ba9b89d..db7c613 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -499,8 +499,10 @@ static void accept_connection(uint8_t *data)

 static void close_connection(struct vhci_conn *conn)
 {
+	char buf[18];
+	ba2str(&conn->dest, buf);
 	syslog(LOG_INFO, "Closing connection %s handle %d",
-					batostr(&conn->dest), conn->handle);
+					buf, conn->handle);

 	g_io_channel_shutdown(conn->chan, TRUE, NULL);
 	g_io_channel_unref(conn->chan);

--0015175cdda842f7a5049c660a7d
Content-Type: text/x-patch; charset=US-ASCII; name="bluez2.diff"
Content-Disposition: attachment; filename="bluez2.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gk89kz8v0

ZGlmZiAtLWdpdCBhL2NvbXBhdC9ibmVwLmMgYi9jb21wYXQvYm5lcC5jCmluZGV4IDliMGQ4Yjgu
LjM2MTdlMGUgMTAwNjQ0Ci0tLSBhL2NvbXBhdC9ibmVwLmMKKysrIGIvY29tcGF0L2JuZXAuYwpA
QCAtMTI4LDYgKzEyOCw3IEBAIGludCBibmVwX3Nob3dfY29ubmVjdGlvbnModm9pZCkKIAlzdHJ1
Y3QgYm5lcF9jb25ubGlzdF9yZXEgcmVxOwogCXN0cnVjdCBibmVwX2Nvbm5pbmZvIGNpWzQ4XTsK
IAl1bnNpZ25lZCBpbnQgaTsKKwljaGFyIGJ1ZlsxOF07CiAKIAlyZXEuY251bSA9IDQ4OwogCXJl
cS5jaSAgID0gY2k7CkBAIC0xMzcsOSArMTM4LDkgQEAgaW50IGJuZXBfc2hvd19jb25uZWN0aW9u
cyh2b2lkKQogCX0KIAogCWZvciAoaSA9IDA7IGkgPCByZXEuY251bTsgaSsrKSB7CisJCWJhMnN0
cigoYmRhZGRyX3QqKWNpW2ldLmRzdCwgYnVmKTsKIAkJcHJpbnRmKCIlcyAlcyAlc1xuIiwgY2lb
aV0uZGV2aWNlLAotCQkJYmF0b3N0cigoYmRhZGRyX3QgKikgY2lbaV0uZHN0KSwKLQkJCWJuZXBf
c3ZjMnN0cihjaVtpXS5yb2xlKSk7CisJCQlidWYsIGJuZXBfc3ZjMnN0cihjaVtpXS5yb2xlKSk7
CiAJfQogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvdGVzdC9oY2llbXUuYyBiL3Rlc3QvaGNp
ZW11LmMKaW5kZXggYmE5Yjg5ZC4uZGI3YzYxMyAxMDA2NDQKLS0tIGEvdGVzdC9oY2llbXUuYwor
KysgYi90ZXN0L2hjaWVtdS5jCkBAIC00OTksOCArNDk5LDEwIEBAIHN0YXRpYyB2b2lkIGFjY2Vw
dF9jb25uZWN0aW9uKHVpbnQ4X3QgKmRhdGEpCiAKIHN0YXRpYyB2b2lkIGNsb3NlX2Nvbm5lY3Rp
b24oc3RydWN0IHZoY2lfY29ubiAqY29ubikKIHsKKwljaGFyIGJ1ZlsxOF07CisJYmEyc3RyKCZj
b25uLT5kZXN0LCBidWYpOwogCXN5c2xvZyhMT0dfSU5GTywgIkNsb3NpbmcgY29ubmVjdGlvbiAl
cyBoYW5kbGUgJWQiLAotCQkJCQliYXRvc3RyKCZjb25uLT5kZXN0KSwgY29ubi0+aGFuZGxlKTsK
KwkJCQkJYnVmLCBjb25uLT5oYW5kbGUpOwogCiAJZ19pb19jaGFubmVsX3NodXRkb3duKGNvbm4t
PmNoYW4sIFRSVUUsIE5VTEwpOwogCWdfaW9fY2hhbm5lbF91bnJlZihjb25uLT5jaGFuKTsK
--0015175cdda842f7a5049c660a7d--
