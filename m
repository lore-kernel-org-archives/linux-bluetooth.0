Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TZdYIJ7t"
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 07:51:50 PST
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB3BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 07:51:50 -0800 (PST)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward206c.mail.yandex.net (Yandex) with ESMTP id C972966BAA
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 18:44:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:73a3:0:640:6804:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTP id 177FB608ED;
	Wed, 13 Dec 2023 18:44:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AilRk427W8c0-BY56GguT;
	Wed, 13 Dec 2023 18:44:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702482250; bh=46pELxcl3h+ZZCUid6qf+O0+xAaOxFBvxW8XKl5Ws/I=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=TZdYIJ7tKFyworef4ghdhyYzS7mh2vvlDGvuPRCN+Ge8zv5aycCS4leWdB7lQ/LQe
	 ZGRiFqzLA+Wa2SPTS5/itSRSNujSteWgxcxTeYVKVGjydp60O1MNkKTODN1c9d2keJ
	 FTqdmZaQCLX90D9lmfnRRg/oWnQ8G955vPlK7Y4c=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] bluetooth: bnep: fix fortify warning
Date: Wed, 13 Dec 2023 18:42:57 +0300
Message-ID: <20231213154303.159184-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231206 (experimental)
and CONFIG_FORTIFY_SOURCE=y, I've noticed the following warning:

In function 'fortify_memcpy_chk',
    inlined from '__skb_put_data' at ./include/linux/skbuff.h:2599:2,
    inlined from 'bnep_rx_frame.isra' at net/bluetooth/bnep/core.c:388:3:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is a 'memcpy()' call underneath '__skb_put_data()', and the former
is interpreted as an attempt to copy ETH_ALEN + 2 (which is 8) bytes from
the 6-byte 'h_source' field of 'struct ethhdr', which causes an overread
warning. The convenient way to avoid it is to use 'struct_group()', i.e.:

struct ethhdr {
	unsigned char	h_dest[ETH_ALEN];
	struct_group(xxx,
	        unsigned char	h_source[ETH_ALEN];
	        __be16		h_proto;
        );
} __attribute__((packed));

But since 'struct ethhdr' is a fundamental type and most likely it would be
a bad idea to mess it up that way just for the sake of a few bluetooth bits,
I would suggest an ad-hoc quirk instead.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/bnep/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5a6a49885ab6..8edceb4d2a4f 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -385,7 +385,8 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	case BNEP_COMPRESSED_DST_ONLY:
 		__skb_put_data(nskb, skb_mac_header(skb), ETH_ALEN);
-		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN + 2);
+		__skb_put_data(nskb, (unsigned char *)&s->eh + ETH_ALEN,
+			       ETH_ALEN + 2);
 		break;
 
 	case BNEP_GENERAL:
-- 
2.43.0

