Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3 v4] Cancel pending phonebook request
Date: Thu,  9 Dec 2010 12:05:16 +0200
Message-Id: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Structure context_query changed to query_context in phonebook-ebook.c
comparing to previous submission, and phonebook_req_cancel changed to
phonebook_req_finalize.

More comments added to phonebook.h.

Br,
Dmitriy

