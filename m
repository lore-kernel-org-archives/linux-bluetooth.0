Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Anthony Bourguignon <contact@toniob.net>,
        linux-bluetooth@vger.kernel.org
Subject: Re: Can't connect a Xbox one controller
In-Reply-To: <1471697662.3650.1.camel@toniob.net>
References: <1471515072.4976.10.camel@toniob.net> <8760qwy6vv.fsf@intel.com> <1471642506.3626.5.camel@toniob.net> <87zio8wcya.fsf@intel.com> <1471697662.3650.1.camel@toniob.net>
Date: Wed, 24 Aug 2016 11:02:59 -0300
Message-ID: <87inuqw9gs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Hi,

Anthony Bourguignon <contact@toniob.net> writes:
>>
>> No. It could be a bug in the xbox controller. But I need to take a
>> closer look at the specification to be really sure.
>
> Can I be of any help ?

Attached is a patch that disables negotiating Flow Control and
Retransmission parameters for the SDP channel only. This is a shot in
the dark, as I could find nothing in the specification that advises
against the current BlueZ behaviour.

Could you give it a try? (but I don't have high hopes for it)

This is looking more like a bug in the controller.

>
> Thanks a lot again
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
--
Vinicius


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=l2cap_ertm_xbox.patch
Content-Description: disable ertm for SDP

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 54ceb1f..aa078b9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3216,6 +3216,9 @@ done:
 		if (disable_ertm)
 			break;
 
+		if (chan->psm == cpu_to_le16(L2CAP_PSM_SDP))
+			break;
+
 		if (!(chan->conn->feat_mask & L2CAP_FEAT_ERTM) &&
 		    !(chan->conn->feat_mask & L2CAP_FEAT_STREAMING))
 			break;

--=-=-=--
