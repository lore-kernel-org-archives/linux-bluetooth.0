Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 18 Apr 2010 19:28:51 +0300
Message-ID: <x2q2c3916b71004180928s9778e8d8zdeebe9e350ae4a19@mail.gmail.com>
Subject: obexd FTP server signals
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I have a question:

Is there any way to get more transaction-related signals from obexd,
when it's used as an FTP _server_?

As far as I can see from "obexd-api.txt" and from dbus-monitor, the
only things to catch are "session_started" and "session_removed".

But I'd like to have a level of granularity similar to the FTP client:
signals about starting/progress/canceling/completing transfers, which
specific kinds of trasfers are done (list folder, get file, put file,
etc.).

Any ideas?

Thanks
