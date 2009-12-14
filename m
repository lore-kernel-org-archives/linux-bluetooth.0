Return-Path: <cyrus@holtmann.org>
Subject: No way to cancel SendFiles() in obexd
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 14 Dec 2009 17:01:33 +0000
Message-ID: <1260810093.3311.5884.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I have a slight problem with SendFiles().

When sending multiple files, and refusing one of them on the phone, the
subsequent files are still sent.

Is there a way to avoid that? Or should I rework the UI slightly to
mention that some files were not sent?

For a single file, you'll get a nice "retry" button if the phone refused
the connection. I'd prefer it if the agent could ask me whether to carry
on sending files, or cancel all the sending.

Cheers

