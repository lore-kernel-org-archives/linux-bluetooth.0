Return-Path: <cyrus@holtmann.org>
Message-ID: <4AE18EA3.50701@pardus.org.tr>
Date: Fri, 23 Oct 2009 14:08:19 +0300
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: hid2hci rules breaks standard USB dell mouses
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.novell.com/show_bug.cgi?id=522287

It seems that the rules matches some other devices than hid proxies
trying to switch them to HCI mode causing the mouse to be nonfunctional.

Just wanted to report it the correct list for a correct solution.

Regards,
Ozan Caglayan
