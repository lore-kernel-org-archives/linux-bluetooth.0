Return-Path: <cyrus@holtmann.org>
Message-ID: <1357601714.1806.16.camel@aeonflux>
Subject: New kernel APIs and actually testing them
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 07 Jan 2013 15:35:14 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

our kernel APIs are not as good as they were years back. There are a
bunch of the management commands that are actually broken. And they have
been broken for years now. For example Set Device Class, Load Long Term
Keys, Confirm Name and maybe even others. Some commands are really
relaxing when it comes to accept certain input variables and turning
them into booleans. Which is also a bad idea.

This all has to stop. From now on, I do not want to see any kernel API
additions (management or socket) that we do not have a proper testing
tool for that can verify its correct behavior. Also adding new APIs
until we have verified the old ones is not something I like to do
either.

During the holidays I started a tool called mgmt-tester that allows
end-to-end testing of the management interface by using emulated HCI
controllers. You just need to load hci_vhci kernel module and run it.

There is a lot of extra work to do for actually ensuring that we are
sending the right HCI commands on different controller versions, but it
is possible to verify this since it is all emulated. Nobody needs the
latest hardware. Look into the emulator directory for my effort in
providing flexible support for simulating different behaviors.

This work of testing our APIs needs to be done NOW. So instead of
everybody trying to squeeze in the latest features, I rather see the
core being improved first and made rock solid.

I welcome every patch that tries to improve this situation.

Regards

Marcel


