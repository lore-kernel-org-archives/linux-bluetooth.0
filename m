Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: ofono@ofono.org
Subject: HFP support into BlueZ and oFono
Date: Wed, 27 Jan 2010 17:12:46 -0200
Message-Id: <1264619569-12448-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
References: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

New patches for the HFP support. The BlueZ part was updated with the Johan's comments and the oFono patch supports load/remove of bluetooth devices dynamically.
We still have bug: the link RFCOMM on the AG side is closed only when bluetoothd shuts down. Any idea on that?

Comments are welcome.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi 

