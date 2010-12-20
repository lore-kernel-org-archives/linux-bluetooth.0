Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Tools user interface improve
Date: Mon, 20 Dec 2010 11:13:46 +0100
Message-ID: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

Normally tools allow to put non-existent or mistake type arguments and
that do not have any impact on the program. But "hciconfig tty1" or
"hcitool name 'fooX' rm file.c" hide important error. Patches make tools more
hermetic, more information.

Regards
