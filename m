Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2015 14:14:31 -0700
Message-ID: <CABOZqnjSPbO-cNkSryq5GXBKTqtE-1TPMKMgTAwtd9YoO4i-4A@mail.gmail.com>
Subject: SDP query via D-Bus?
From: Mark Spruiell <mes@zeroc.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We currently use sdp_connect and sdp_service_search_attr_req to
determine the RFCOMM channel associated with a service on a remote
device.

Does the D-Bus API provide an equivalent way to discover this information?

Thanks,
Mark
