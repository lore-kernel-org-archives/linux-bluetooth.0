Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6 v2] Cancel pending phonebook request
Date: Wed, 24 Nov 2010 17:07:10 +0200
Message-Id: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is optimized version of previous submission
[PATCH 0/7] Cancel pending phonebook request

In these patches only pointer to pending call is returned from 
phonebook_..._open functions, while no other structure is created.
For tracker this call is DBusPendingCall and for phonebook-dummy
and phonebook-ebook it is NULL.

Also, query_tracker is modified appropriately.

BR,
Dmitriy

