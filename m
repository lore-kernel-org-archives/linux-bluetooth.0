Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Tue, 5 Dec 2017 14:39:37 +0100
Message-ID: <CAOT_U5ZE_an7h2Co5Rg27+eY2uyfEG6PBHsL1vnsNToEXPadYQ@mail.gmail.com>
Subject: Change controller role with non deprecated commands
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
what is the proper way to change the role of the controller after the
deprecation of the hcitool?

An equivalent of this:

hcitool sr <bdaddr> <role>

Ref.
https://manpages.debian.org/testing/bluez/hcitool.1.en.html
