Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: VISHWANATH KM <a21174@motorola.com>
Date: Wed, 1 Jun 2011 00:02:13 +0530
Message-ID: <BANLkTi=LMR0vRhyUm22vVodJzFPw=Rbi=A@mail.gmail.com>
Subject: remote name request missing for incoming connections in newer Bluez 4.93
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In newer versions of Bluez version 4.93, after the ACL established,
remote name request is not issued , due to which device name is not
present in case of incoming connections. Please confirm if anybody
observed this issue. thanks

Bluez 4.93
src/event.c  btd_event_conn_complete ( Does not issue remote name req )

Bluez 4.69
src/security.c conn_complete  (issues remote name req )

Regards
Vishwanath
