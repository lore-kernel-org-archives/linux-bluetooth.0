Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1507733091.5470.5.camel@ewol.com>
Subject: Re: meshctl: set-pub fails
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 11 Oct 2017 08:44:51 -0600
In-Reply-To: <1507674601.5470.3.camel@ewol.com>
References: <1507651475.5470.1.camel@ewol.com>
         <1507674601.5470.3.camel@ewol.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-10-10 at 16:30 -0600, Steve Brown wrote:
> On Tue, 2017-10-10 at 10:04 -0600, Steve Brown wrote:
> > discover-unprovisioned, provision, add-appkey & bind work as
> > expected.
> > The meshctl's onoff client evokes expected behavior in zephyr's
> > onoff
> > server.
> > 
> > The command being passed
> > 
> > set-pub 0100 c000 1 5 1000
> > 
> > The length of the set-pub packet exceeded the size of the data
> > array
> > in
> > struct mesh_pkt in net.c by 1. This stepped on the length field
> > which
> > followed. The transmit mostly failed. The zephyr server received
> > nothing.
> > 
> > I extended the data array to 35. I now get consistent output.
> > However,
> > the zephyr server is unable to decrypt with devkey. Net decrypt
> > works,
> > but app decrypt fails. 
> > 
> > I looked at how config-client.c:cmd_set_pub handled the app key
> > index.
> > According to 4.3.2.16 (pg 158) of the Mesh Profile Spec, the app
> > key
> > index should be in the top 12 bits of octet 4 & 5. I shifted it up
> > by
> > 4, but get the same results.
> > 
> > I'm pretty sure the problem is on the meshctl side. I've used the
> > Silabs Android app to successfully configure the zephyr server. It
> > successfully sends a set-pub which the zephyr server correctly
> > handles.
> > 
> > Maybe this is a regression. Has set-pub worked in the past?
> > 
> 
> There is no problem with the placement of the app key index. The
> figures in the spec are variously big and little endian. I misread
> the
> figure. 
> 
> Steve

Sorry to be continually replying to my own posts.

There were 2 problems:

1. mesh_pkt's data area was too small. The final message was 31 bytes.
I added 5 bytes and an assert. I'm not sure what the max might be.

2. The SEG_MAX test was on the wrong length. It should have been on
sar->len, not len. The message should have been segmented, but was not.

With this patch, the set-pub below returns success. 

set-pub 0100 c000 1 0 1000

Could somebody familiar with the code comment?

diff --git a/mesh/net.c b/mesh/net.c
index 2d75c4f7d..89d22c99b 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -110,7 +110,7 @@ struct mesh_virt_addr {
 };
 
 struct mesh_pkt {
-	uint8_t		data[30];
+	uint8_t		data[35];
 	uint8_t		len;
 };
 
@@ -1308,6 +1308,9 @@ static void send_seg(struct mesh_sar_msg *sar, uint8_t seg)
 	}
 
 	pkt->len += (sar->ctl ? 8 : 4);
+
+	g_assert(!(pkt->len > sizeof(pkt->data)));
+
 	mesh_crypto_packet_encode(data, pkt->len,
 			part->enc_key,
 			sar->iv_index,
@@ -2098,7 +2101,7 @@ bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
 	if (!result)
 		return false;
 
-	segN = SEG_MAX(len);
+	segN = SEG_MAX(len + sizeof(uint32_t));
 
 	/* Only one ACK required SAR message per destination at a time */
 	if (segN && IS_UNICAST(dst)) {

