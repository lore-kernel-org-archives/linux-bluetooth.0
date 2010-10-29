Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 Oct 2010 22:23:29 -0700
Message-ID: <AANLkTinmPatg5pX1Du2xWArWfrONr8XgX8+J=fap3Gzs@mail.gmail.com>
Subject: AVRCP 1.4 Patch
From: John Crosbie <john@excelfore.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

João Paulo,

I have been working with your AVRCP 1.4 patches that are posted on
GSOC.  I found a problem in one of your patch files that I thought I
would relate:

in [PATCH 03/10] AVRCP: Handle GetCapabilities PDU

at line 48
+    metadata = (struct metadata_header *) avrcp + AVRCP_HEADER_LENGTH + 3;

the pointer arithmetic is broken and should be something like:
+    metadata = (struct metadata_header *)((uint8_t*)avrcp +
AVRCP_HEADER_LENGTH + 3);

Now the device (CT) Requests CAP_COMPANY_ID and CAP_EVENTS_SUPPORTED
as expected but doesn't do anything more so I will continue digging.

I am working with a Sony Ericsson MW600 device.  It claims to have
AVRCP 1.4 support but I have not confirmed that it works as yet.

If I am working with old code please let me know.

Regards,

John Crosbie
Excelfore
