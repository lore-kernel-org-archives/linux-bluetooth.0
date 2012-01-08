Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Connectable PANU state for PTS certifications?
Date: Sun, 8 Jan 2012 17:51:55 +0000
Message-ID: <A7CD2DBA66569F478A0C1ECFC39E1C521064C56B@DLEE74.ent.ti.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I am trying to pass PTS tests for PANU.
Number of them try to initialize connection to PANU ( IUT ) and 
fail because of " bluetoothd[298]: Server unavailable: (0x1115)".
Spec. says that support for connectable mode in PANU is optional, 
and the code ( server.c:: server_register() ) seems to register 
only NAP server.

The question is - is it possible to enable the connectable PANU
mode ( maybe via configuration or light modifications to the code )?


Kind regards,
Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009




