Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: [PATCH 0/1 v2] Fix response on adapter RequestSession method
Date: Tue,  1 Mar 2011 16:25:34 +0200
Message-Id: <1298989535-403-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This submission is modified version accordingly to previous comments of
Luiz.

New session is not created if session for such message already exists,
instead of session for sender of such message.

Also, dbus_message_new_method_return is removed.

BR,
Dmitriy

