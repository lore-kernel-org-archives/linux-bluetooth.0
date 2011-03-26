Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/6] Move Attrib client (including: should we disconnect or not?)
Date: Fri, 25 Mar 2011 21:01:07 -0300
Message-Id: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The move itself is pretty simple, but when implementing it, I took a decision
and I would like to hear your opinion about it.

With this patch series, the behaviour is that we never disconnect from
a LE device unless we are told so, i.e. org.bluez.Device.Disconnect(),
is that what is expected from us?


Cheers,
--

Vinicius Costa Gomes (6):
  Move Attrib client to the core
  Register Attrib interface when loading device from storage
  Register Attrib interface after Primary Service discovery
  Remove _init and _exit methods from Attrib client
  Add support for re-using the attrib channel
  Fix disconnecting when primary service discovery is done

 Makefile.am      |    4 ++--
 attrib/client.c  |   49 ++++++++++++++++++-------------------------------
 attrib/client.h  |    6 +++---
 attrib/manager.c |   47 -----------------------------------------------
 src/adapter.c    |    5 +++++
 src/device.c     |   20 +++++++++++++-------
 6 files changed, 41 insertions(+), 90 deletions(-)

--
1.7.4.1

