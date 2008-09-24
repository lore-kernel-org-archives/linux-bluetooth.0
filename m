Return-Path: <cyrus@holtmann.org>
Subject: hci_read_remote_name_with_clock_offset vs hci_read_remote_name
From: "Christian O. Andersson" <christian.o.andersson@gmail.com>
Reply-To: christian.o.andersson@gmail.com
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Wed, 24 Sep 2008 11:55:00 +0200
Message-Id: <1222250100.13534.10.camel@ludwig-van>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey guys,

Please bare with me as I'm just starting to learn the concepts of
hci-traffic. I hope this is the right place to ask.

I was wondering - is there any performance gain in preferring
'hci_read_remote_name_with_clock_offset' to 'hci_read_remote_name' if
you already know the clock offset (from a previous inquiry).

Looking at the source code it seems as though the latter only calls the
former with the clock offset set to 0?

/Christian

