Return-Path: <cyrus@holtmann.org>
Message-ID: <4B499F5909CB43EAA30894396D6AAD68@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>,
	<linux-bluetooth@vger.kernel.org>
Cc: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
References: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH hcidump] avrcp: fix name of metadata field
Date: Fri, 9 Sep 2011 07:22:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

That's fair.  For what it's worth, would this be better as an enum?

DS

-----Original Message----- 
From: Lucas De Marchi
Sent: Thursday, September 08, 2011 6:32 PM
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi
Subject: [PATCH hcidump] avrcp: fix name of metadata field

Metadata field number 0x7 should be the track duration and not the
progress of the track playback. Thus rename it to a better description.
---
parser/avrcp.c |    6 +++---
1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index f8e4443..0b98a3e 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -166,7 +166,7 @@
#define AVRCP_MEDIA_ATTRIBUTE_TRACK 0x4
#define AVRCP_MEDIA_ATTRIBUTE_TOTAL 0x5
#define AVRCP_MEDIA_ATTRIBUTE_GENRE 0x6
-#define AVRCP_MEDIA_ATTRIBUTE_PROGRESS 0x7
+#define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x7

/* play status */
#define AVRCP_PLAY_STATUS_STOPPED 0x00
@@ -909,8 +909,8 @@ static const char *mediattr2str(uint32_t attr)
  return "Track Total";
  case AVRCP_MEDIA_ATTRIBUTE_GENRE:
  return "Genre";
- case AVRCP_MEDIA_ATTRIBUTE_PROGRESS:
- return "Progress";
+ case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+ return "Track duration";
  default:
  return "Reserved";
  }
-- 
1.7.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

