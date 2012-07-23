Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 23 Jul 2012 16:46:52 +0530
Message-ID: <CAOVXEJJawhMTvVLvF1E0YjPpJsOD6fNy4G8m3oxS9G=vQYP=3A@mail.gmail.com>
Subject: AVDTP RECONFIGURE COMMAND & RESPONSE
From: Sathish narasimman <nsathish41@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi all,
i am trying to send AVDTP_RECONFIGURE command but every time i am just
getting AVDTP_MSG_TYPE_GEN_REJECT . I saw in avdtp.c that response for
RECONFIGURE command is always set to reply as unknown command i.e
response is rejected.. I want to know whether reconfigure is possible
in bluez.

-- 
Regards
Sathish N
