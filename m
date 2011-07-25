Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Proximity Monitor implementation (for testing)
Date: Mon, 25 Jul 2011 17:15:50 -0300
Message-Id: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series implements a basic Proximity Monitor for testing purposes. It lacks
a number of features, but is already useful for testing our current Proximity
Monitor implementation.

Note: when applying these patches, make sure it is applied *after* Proximity
Monitor ones, otherwise it will conflict on the Makefile.am changes.

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
