Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2009 06:16:44 +0300
Message-ID: <5078d8af0909092016g7ba97265yc725537e04a709d5@mail.gmail.com>
Subject: Source device selection for org.bluez.client.SendFiles
From: Timothy Madden <terminatorul@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I noticed method SendFiles in org.bluez.client was ignoring the given
source in the device dictionary passed as argument.

I had to modify the send_files() function in obexd-0.17/client/main.c
and replace the NULL parameter it was passing on to session_create
with the given source from the dictionary. Than I could select the
source device when calling SendFiles from python. Should I send in a
patch ?


Thank you,
Timothy Madden
