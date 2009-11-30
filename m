Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Nov 2009 19:42:55 +0000 (GMT)
To: linux-bluetooth@vger.kernel.org
Subject: [patch] bluez-hcidump fix SDP universal attributes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1259610176.010210.13279.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

hcidump shows SDP universal attribute 0x000d as IconURL but in fact it is
defined as "Additional Protocol Descriptor Lists". IconURL is 0x000c and I
don't know what Icon_10 was, perhaps an older name?

Eg, from an SDP probe of a mouse:

      aid 0x000d (IconURL)
         < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >

Anyway, patch below fixes it up. Sorry, I don't have a git here can't
provide a gitpatch atm

regards,
iain


--- parser/sdp.h.orig	2009-11-30 19:29:35.000000000 +0000
+++ parser/sdp.h
@@ -129,8 +129,8 @@
 #define SDP_ATTR_ID_BLUETOOTH_PROFILE_DESCRIPTOR_LIST  0x0009
 #define SDP_ATTR_ID_DOCUMENTATION_URL                  0x000A
 #define SDP_ATTR_ID_CLIENT_EXECUTABLE_URL              0x000B
-#define SDP_ATTR_ID_ICON_10                            0x000C
-#define SDP_ATTR_ID_ICON_URL                           0x000D
+#define SDP_ATTR_ID_ICON_URL                           0x000C
+#define SDP_ATTR_ID_ADDITIONAL_PROTOCOL_DESC_LISTS     0x000D
 #define SDP_ATTR_ID_SERVICE_NAME                       0x0100
 #define SDP_ATTR_ID_SERVICE_DESCRIPTION                0x0101
 #define SDP_ATTR_ID_PROVIDER_NAME                      0x0102
--- parser/sdp.c.orig	2009-11-30 19:29:31.000000000 +0000
+++ parser/sdp.c
@@ -194,8 +194,8 @@ static sdp_attr_id_nam_lookup_table_t sd
 	{ SDP_ATTR_ID_BLUETOOTH_PROFILE_DESCRIPTOR_LIST, "BTProfileDescList"  },
 	{ SDP_ATTR_ID_DOCUMENTATION_URL,                 "DocURL"             },
 	{ SDP_ATTR_ID_CLIENT_EXECUTABLE_URL,             "ClientExeURL"       },
-	{ SDP_ATTR_ID_ICON_10,                           "Icon10"             },
 	{ SDP_ATTR_ID_ICON_URL,                          "IconURL"            },
+	{ SDP_ATTR_ID_ADDITIONAL_PROTOCOL_DESC_LISTS,    "AdditionalProtocolDescLists" },
 	{ SDP_ATTR_ID_SERVICE_NAME,                      "SrvName"            },
 	{ SDP_ATTR_ID_SERVICE_DESCRIPTION,               "SrvDesc"            },
 	{ SDP_ATTR_ID_PROVIDER_NAME,                     "ProviderName"       },


