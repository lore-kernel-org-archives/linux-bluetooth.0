Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Aug 2010 13:34:32 +0100
Message-ID: <AANLkTin+CRVwKgC+UaDK6q4PRrw9eGi3c7++PSxWODcu@mail.gmail.com>
Subject: [PATCH] Remove dup VCard2.1 SDP format for OPP
From: Tom Counihan <tomcounihan@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

OPP SDP record appears to have a duplicate
entry for Supported Formats List.

---
 plugins/opp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index cd46464..05f944f 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -83,7 +83,6 @@
   <attribute id=\"0x0303\">                                    \
     <sequence>                                                 \
       <uint8 value=\"0x01\"/>                                  \
-      <uint8 value=\"0x01\"/>                                  \
       <uint8 value=\"0x02\"/>                                  \
       <uint8 value=\"0x03\"/>                                  \
       <uint8 value=\"0x04\"/>                                  \
-- 
1.7.1.1
