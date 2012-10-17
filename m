Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 17 Oct 2012 16:13:55 -0500
Message-ID: <CAB7rCTibYJp9ibcG1+O929C-Xf3GRPgVRJS4HRoDgvro2RLt6g@mail.gmail.com>
Subject: obex-client: support authentication response?
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to pass TP/SSM/BV-6-C (respond to authentication requests)
for PBAP.  As far as I can see, there is code in the obex server to
respond to challenge requests, but I don't think I see any for the
client.  As for when it runs against PTS, obex-client initiates a
disconnect when it gets the unauthorized response code.  Am I missing
something?

Thanks,
Mike
