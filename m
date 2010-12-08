Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3 v3] Cancel pending phonebook request
Date: Wed,  8 Dec 2010 23:15:53 +0200
Message-Id: <1291842956-8610-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is updated version of patch to handle pending phonebook
request and to cancel it if OBEX session is terminated.

Additionally to previous submission, it containts updates for
phonebook-dummy.c and phonebook-ebook.c backend drivers. Therefore,
it is highly encouraged for those who exploit them to provide
feedback.

Also, code for tracker was significantly improved.

BR,
Dmitriy

