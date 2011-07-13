Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v3 0/2] Add handling of system D-Bus method calls
Date: Wed, 13 Jul 2011 12:43:44 +0300
Message-Id: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

This is updated version where
client/session.c:189: error: no previous declaration for 'find_session_request'
make[1]: *** [client/session.o] Error 1
is fixed.

Please, check if
+static struct pending_req *find_session_request(
+				const struct session_data *session,

is coding-style-wise acceptable.

Thanks,
Dmitriy

