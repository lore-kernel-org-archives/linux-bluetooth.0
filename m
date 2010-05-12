Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 13 May 2010 00:28:14 +0300
Message-ID: <AANLkTiklu7yRsbmNbOgSW2b4LobLlguxnJxxMpi_k_sp@mail.gmail.com>
Subject: FTP problem during obexd initialization?
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Whenever I start obexd 0.23 (on Fedora 12 with BlueZ 4.64) with the -f
argument (FTP), I see the following log message:

"obexd[...]: Bluetooth server register failed: rfcomm_bind: Address
already in use (98)"

happens only with FTP, and regardless whether I specify other
protocols (e.g. e/o/p/s).

Is that indicative or a real problem, or just a harmless log message?

Thanks
