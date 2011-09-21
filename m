Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1E0C6F4C3D9940BA8E8D3BA2FC16B573@alexm>
References: <E1R47Z5-0000QH-00.alexvm12e-mail-ru@f167.mail.ru>
	<CABBYNZJzJPf1KYVpDJvr_UO722DTYzRV0vG6X7OnUHZVK8aq_A@mail.gmail.com>
	<1E0C6F4C3D9940BA8E8D3BA2FC16B573@alexm>
Date: Wed, 21 Sep 2011 15:33:45 +0300
Message-ID: <CABBYNZ+hXiRQv7KesdgX790wWPabYXvUecq0D=2PjgmVEWTL2A@mail.gmail.com>
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Mach <alexvm12e@mail.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Sep 21, 2011 at 3:13 PM, Alex Mach <alexvm12e@mail.ru> wrote:
> Hi Luiz,
>
> the string in the header seems ok (file name is 1087.mid):
>
>> ACL data: handle 42 flags 0x02 dlen 70
>
>   L2CAP(d): cid 0x0040 len 66 [psm 3]
>     RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 61 fcs 0xd2 credits 1
>       OBEX: Put cmd(c): len 61
>       Name (0x01) = Unicode length 18
>       0000: 00 31 00 30 00 38 00 37  00 2e 00 6d 00 69 00 64
> .1.0.8.7...m.i.d
>       0010: 00 00 ..
>       Length (0xc3) = 6718
>       Type (0x42) = Sequence length 11
>       0000: 61 75 64 69 6f 2f 6d 69  64 69 00 audio/midi.
>       Time (0x44) = Sequence length 15
>       0000: 32 30 31 31 30 39 30 33  54 31 33 32 36 34 38 20110903T132648

No top posting please, please use inline posting.

Can you try the following:

diff --git a/src/obex.c b/src/obex.c
index d8f4648..7b68814 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -985,6 +985,7 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
        unsigned int hlen;
        uint8_t hi;
        int ret;
+       GError *err = NULL;

        os = OBEX_GetUserData(obex);

@@ -1010,7 +1011,12 @@ static gboolean check_put(obex_t *obex,
obex_object_t *obj)
                                continue;

                        os->name = g_convert((const char *) hd.bs, hlen,
-                                       "UTF8", "UTF16BE", NULL, NULL, NULL);
+                                       "UTF8", "UTF16BE", NULL, NULL, &err);
+                       if (err) {
+                               error("%s", err->message);
+                               g_error_free(err);
+                       }
+
                        DBG("OBEX_HDR_NAME: %s", os->name);
                        break;

-- 
Luiz Augusto von Dentz
