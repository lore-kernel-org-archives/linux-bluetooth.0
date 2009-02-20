Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Feb 2009 21:40:04 +0800
Message-ID: <ac8af0be0902200540v346cb3b5mbd1eb087d2e792e@mail.gmail.com>
Subject: [PATCH 0/4] HFP Gateway profile -- take 2 - resend
From: Zhao Forrest <forrest.zhao@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I revised the patch according to your comments and resend.

Compared with last version the change is:
1 fix the bug that HFP AG can't initiate the service-level connection
with HFP HF unit.
2 more coding style fix
3 rebase the patch set against the BlueZ master

Thanks,
Forrest
