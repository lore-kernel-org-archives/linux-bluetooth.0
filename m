Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Cancel pending phonebook request
Date: Tue, 23 Nov 2010 20:11:22 +0200
Message-Id: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In this patch, pending request to backend is calceled when OBEX
object is destroyed. Such prevents situations of response on
query arriving to destroyed object, e.g. OBEX session is closed
in the middle of query to tracker.

Such required some changes in phonebook API. More specifcally,
changes in API affect phonebook_pull, phonebook_get_entry, and 
phonebook_create_cache functions. phonebook_req_cancel is added
to cancel pending request and deallocate resources respective to
it.

Phonebook request structure is specific to each backend and
created dinamically only for tracker. Therefore phonebook-dummy
and phonebook-ebook methods always return NULL instead of pending
request.

For PBAP, the object holds pointer to pending call. In IRMC, it 
is session where the pointer is stored and pending call canceled 
when closing OBEX object, and valid for phonebook_pull only.

BR,
Dmitriy

