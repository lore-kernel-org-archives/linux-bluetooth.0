Return-Path: <cyrus@holtmann.org>
Message-ID: <4BB4B789.7070409@hschmitt.de>
Date: Thu, 01 Apr 2010 17:11:05 +0200
From: "commerce@hschmitt.de" <commerce@hschmitt.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: obexd and phonebook-ebook.c (PBAP support)
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Is it possible that obexd has to call g_type_init() if phonebook-ebook 
is used?
I think when you call e_book_new_default_addressbook() somewhere down 
gconf_client_get_default() is called and it insists that g_type_init() 
is called prior to its use.

I tried to make obexd work on my N900, but I did not get there.
My car kit does not use PBAP because it finds the Nokia SyncML profile 
and uses it, but the N900 does not communicate with bluetooth devices 
other than PC or Mobiles via SyncML.
Is there a way to unregister a service from SDP?

Regards,

--
Harald
