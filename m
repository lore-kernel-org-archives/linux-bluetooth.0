Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: MCAP Patches
Date: Thu, 22 Jul 2010 10:51:55 +0200
Message-Id: <1279788733-2324-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Next you are MCAP patches that José Antonio Santos Cadenas and me have generated for BlueZ.
We still believe that MCAP should be an independent library from HDP because other profiles
non health related may want to use it in the future, if we set this health dependency we will
force to import health features in plugins that only require MCAP.
Nevertheless, as we accorded last week in Brazil we are sending a last patch to set MCAP
into health directory with HDP. We leave in your hands upload it as health plugin or not.

Regards


