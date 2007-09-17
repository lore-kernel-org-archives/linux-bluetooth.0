Return-Path: <fchevalier@silicom.fr>
Message-ID: <46EEBC41.80401@silicom.fr>
Date: Mon, 17 Sep 2007 19:41:21 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@nokia.com>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [PATCH] Fix bogus avdtp error codes management
Content-Type: multipart/mixed;
 boundary="------------000706010305040305030605"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000706010305040305030605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johan & Marcel,

While trying to fix this cross case issue, i came with an issue with the 
way error codes are handled
in avdtp.c.
The issue is basically that the part of the code that retrieves the 
exact error value is never executed
due to premature return.

Please have a look at the current patch.

Fabien

--------------000706010305040305030605
Content-Type: text/x-patch;
 name="avdtp-bogus-error-checking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="avdtp-bogus-error-checking.patch"

diff -u -1 -0 -r1.49 avdtp.c
--- avdtp.c     2 Sep 2007 16:52:50 -0000       1.49
+++ avdtp.c     17 Sep 2007 17:33:24 -0000
@@ -1501,38 +1501,38 @@
        if (cond & G_IO_NVAL)
                return FALSE;
 
        if (!g_slist_find(sessions, session)) {
                debug("l2cap_connect_cb: session got removed");
                return FALSE;
        }
 
        sk = g_io_channel_unix_get_fd(chan);
 
-       if (cond & (G_IO_ERR | G_IO_HUP)) {
-               err = EIO;
-               goto failed;
-       }
-
        len = sizeof(ret);
        if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &ret, &len) < 0) {
                err = errno;
                error("getsockopt(SO_ERROR): %s (%d)", strerror(err), err);
                goto failed;
        }
 
        if (ret != 0) {
                err = ret;
                error("connect(): %s (%d)", strerror(err), err);
                goto failed;
        }
 
+       if (cond & G_IO_HUP) {
+               err = EIO;
+               goto failed;
+       }
+
        ba2str(&session->dst, address);
        debug("AVDTP: connected %s channel to %s",
                        session->pending_open ? "transport" : "signaling",
                        address);
 
        memset(&l2o, 0, sizeof(l2o));
        len = sizeof(l2o);
        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
                                &len) < 0) {
                err = errno;
f
--------------000706010305040305030605
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fchevalier.vcf"

YmVnaW46dmNhcmQNCmZuOkZhYmllbiBDSEVWQUxJRVINCm46Q0hFVkFMSUVSO0ZhYmllbg0K
b3JnOlNJTElDT00NCmFkcjo7OzQgcnVlIGRlIEpvdWFuZXQ7IFJFTk5FUyBBVEFMQU5URTs7
MzU3MDA7RlJBTkNFDQplbWFpbDtpbnRlcm5ldDpmY2hldmFsaWVyQHNpbGljb20uZnINCnRp
dGxlOlNvZnR3YXJlICYgU3R1ZGllcyBFbmdpbmVlcg0KdGVsO3dvcms6KzMzICgwKSAyIDk5
IDg0IDE3IDE3DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------000706010305040305030605--
