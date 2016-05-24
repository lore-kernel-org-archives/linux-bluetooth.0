Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Miao-chen Chou <mcchou@chromium.org>
Date: Tue, 24 May 2016 19:12:59 +0800
Message-ID: <CAHgsZ+gPXmc=NtA3rrjQEn9ztN+Xd8v_9Yu0M63_iiEHCND9Fg@mail.gmail.com>
Subject: Query SDP records by UUID in BlueZ.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear community,

I am wondering if there is an existing D-Bus interface which provide a
way to query the SDP record by service UUID and the remote device
address? After going through sdptool and sdp-client, I notice that
there are functions, sdp_service_search_XXX, defined in lib/sdp.c, but
I didn't find any D-Bus interface function or property which allows
querying SDP records of a connected/paired remote device. If there is
a way to query SDP record though D-Bus interface, can you give me a
pointer to the material? If not, what is your suggestion on this?
Thanks in advance. :)

Regards,
Miao
