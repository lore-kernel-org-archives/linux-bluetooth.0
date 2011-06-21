Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Add MGMT_OP_SET_LE_SUPPORT command
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Jun 2011 13:36:58 -0700
In-Reply-To: <1308686870-26101-3-git-send-email-andre.guedes@openbossa.org>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
	 <1308686870-26101-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308688620.2196.61.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a new command to management interface to enable/
> disable LE support. This command will be used to set LE support
> according to the host configuration.

any reason why we want this separated and being under host stack control
in the first place. Should we not always enable LE if we can support it?
What are the reason to run an LE capable BlueZ on an LE capable dongle
and then not enable LE?

A similar argumentation applies for Secure Simple Pairing. We are
currently enabling this by default. Even while there are qualification
tests that would us force to run it with SSP disabled.

Maybe we should just have a generic kernel mgmt features enabling
command. One thing that I do not wanna do is to just blindly make a copy
of HCI commands for mgmt interface. The controller abstraction for the
mgmt interface is suppose to have a feature list so we can check what
the kernel supports and what not.

Regards

Marcel


