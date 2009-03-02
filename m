Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Mar 2009 17:28:26 +0800
Message-ID: <ac8af0be0903020128y66156981ydfd32168fd055e9f@mail.gmail.com>
Subject: [PATCH 0/4] HFP Gateway profile -- take 2 -- resend
From: Zhao Forrest <forrest.zhao@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Johan,

Compared with last version, the main changes are:
1 fix the bug in IPC part
2 check the string length for sscanf()
3 rebase the patch against git master

Thanks,
Forrest
