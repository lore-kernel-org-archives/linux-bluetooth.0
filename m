Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 25 Nov 2011 15:49:53 +0100
Message-ID: <CA+HdrtciUmmqYi5MVyzEnu16z3i2BzOK83zkdh8zbmwkPBeyCA@mail.gmail.com>
Subject: PBAP: Generate cache using absolute path instead of relative path.
From: Anders Widen <mail@anderswiden.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Possible error?

Looking at the PBAP Specification P.27

"5.3.3 Name
This header specifies the name of the folder to be retrieved. The
value shall not include
any path information, since the PullvCardListing function uses
relative paths. An empty
name header may be sent to retrieve the folder that is the current directory."

and then in the backend implementations:
/plugins/phonebook-tracker.c
/plugins/phonebook-ebook.c

both use absolute paths in the implementation of:

phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
      phonebook_cache_ready_cb ready_cb, void *user_data, int *err)


Is there something in PBAP Core I've missed?
I looked for concats of the current_folder but it seems to pass the
information to the implementation raw.

//Anders Widén
